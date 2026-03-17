---
name: java-spring-boot
description: Spring Boot 3.3+ patterns for enterprise applications. Modular monolith, DDD, security, testing, API design. Based on production MES system patterns.
allowed-tools: Read, Write, Edit, Glob, Grep
requires_reading:
  - ARCHITECTURE.md
  - .agent/project-context.md
---

# Spring Boot 3.3+ — Senior Architect Perspective

> "Spring Boot is the framework, not the architecture. Your domain model IS the architecture."

This skill combines **battle-tested production conventions** with **architectural decision-making**. For Java core patterns, see `agkit-java`.

---

## Read First, Code Never

Before writing ANY code in an existing project:
1. Read `ARCHITECTURE.md` — module boundaries, conventions
2. Find 1 similar module → match its patterns exactly
3. If no reference exists → establish one and get team alignment

---

## 0. Project Architecture Overview

### Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Language** | Java | 21 (LTS) |
| **Framework** | Spring Boot | 4.0.3 |
| **Build** | Maven | Multi-module POM |
| **Database** | PostgreSQL | 16+ (schema-per-module) |
| **ORM** | Hibernate / JPA | 7.x (via Spring Boot) |
| **Mapping** | MapStruct | 1.6.3 |
| **API Docs** | SpringDoc OpenAPI | 2.8.4 |
| **Security** | Spring Security + JWT (jjwt) | 0.12.6 |
| **Scheduling** | Timefold Solver | 1.31.0 (APS module) |
| **File Storage** | MinIO | 8.5.14 |
| **DB Migration** | Liquibase | 4.x |
| **Arch Tests** | ArchUnit | 1.3.0 |
| **Integration Tests** | Testcontainers | 1.20.4 |
| **Utilities** | Lombok | (Spring Boot managed) |

### Maven Module Structure

```
{project-name} (parent POM)
├── modules/
│   ├── {prefix}-shared        ← Shared Kernel (base classes, DTOs, exceptions)
│   │
│   ├── {prefix}-{mod-a}-api   ← API JARs (built BEFORE impl modules)
│   ├── {prefix}-{mod-b}-api   ←   Contains: QueryService + Events + Response DTOs
│   ├── ...                    ←   Purpose: compile-time cross-module boundary enforcement
│   │
│   ├── {prefix}-iam           ← Generic Context (Auth, RBAC)
│   ├── {prefix}-{mod-a}       ← Domain module A
│   ├── {prefix}-{mod-b}       ← Domain module B
│   ├── ...                    ← More domain modules
│
└── server/                     ← Spring Boot Application (assembles all modules)
```

#### Module Dependency Rule

```java
// Each domain module's pom.xml:
<dependencies>
    <dependency>{prefix}-{module}-api</dependency>    <!-- Own API JAR -->
    <dependency>{prefix}-shared</dependency>          <!-- Base classes -->
    <dependency>{prefix}-{other}-api</dependency>     <!-- Cross-module: API JAR only! -->
    <!-- NEVER depend on full {prefix}-{other} module -->
</dependencies>
```

### Shared Kernel (`{prefix}-shared`)

| Package | Classes | Purpose |
|---------|---------|---------|
| `domain/` | `BaseDomainModel`, `DomainRepository`, `AbstractDomainRepository`, `EntityMapper`, `DomainEvent`, `InvalidStateTransitionException`, `ShiftCode` | DDD foundation |
| `dto/response/` | `ApiResponse`, `PageResponse`, `ErrorResponse` | Unified API wrappers |
| `dto/` | `PageDTO` | Internal pagination |
| `exception/` | `BusinessException`, `GlobalExceptionHandler`, `CommonErrorCode`, `ResponseError` | Error handling |
| `infrastructure/` | `BaseJpaEntity`, `BaseEventEntity`, `AuditorAwareImpl`, `JpaAuditingConfig` | JPA foundation |
| `infrastructure/outbox/` | `OutboxEntry`, `OutboxJpaRepository`, `OutboxPollingPublisher`, `OutboxStatus` | Transactional Outbox for event delivery |
| `infrastructure/security/` | `SecurityUtils`, `JwtTokenProvider`, `JwtProperties`, `UserPrincipal` | Auth infrastructure |
| `infrastructure/async/` | `AsyncTaskExecutor`, `TaskProgress`, `TaskStatus` | Background tasks |
| `infrastructure/lock/` | `AdvisoryLockService`, `AdvisoryLockException` | PostgreSQL advisory locks |
| `config/` | `SseEmitterManager` | Server-Sent Events |

### Bounded Contexts & Aggregate Roots (Example)

Each bounded context owns a schema, aggregate roots, and state machines:

| Context | Schema | Aggregate Root(s) | State Machine |
|---------|--------|-------------------|---------------|
| **{Mod-A}** | `{prefix}_{mod_a}` | `Order`, `Dispatch` | Draft → Submitted → Approved → InProgress → Completed |
| **{Mod-B}** | `{prefix}_{mod_b}` | `Inspection`, `Report` | Pending → InProgress → Closed |
| **{Mod-C}** | `{prefix}_{mod_c}` | `MaterialLot` | Multi-state lifecycle |
| **IAM** | `{prefix}_iam` | `User`, `Role` | Active ↔ Disabled |

### Domain Event Flow (Cross-Module Example)

```
{Mod-A} ──OrderApproved──────→ {Mod-B}, {Mod-C}
{Mod-B} ──InspectionPassed───→ {Mod-C}
{Mod-C} ──LotReceived────────→ {Mod-A}
{Mod-D} ──BreakdownCreated───→ {Mod-E}
```

> **Pattern:** Module emits domain events → other modules listen via `@TransactionalEventListener`. Each event documented with: source module → event name → consumer modules.

### Architectural Principles

| # | Principle | Implementation |
|---|-----------|---------------|
| 1 | Module Isolation | Each module = own package, own schema, communicates via API JAR interfaces |
| 2 | Domain Events | State changes emit events via Transactional Outbox (at-least-once delivery) |
| 3 | Audit Everything | Every state transition logged (BaseJpaEntity audit columns) |
| 4 | State Machine Enforcement | All lifecycle entities use `BaseDomainModel.validateTransition()` |
| 5 | API-First | REST API for all operations, uniform `ApiResponse` / `PageResponse` wrappers |
| 6 | Soft Delete Only | `deleted = false` filter on all queries, no hard deletes |
| 7 | Schema-per-Module | No cross-schema JOINs, cross-schema refs via `module_id` (no physical FK) |

---

## 1. DDD Architecture (MANDATORY — Not Optional)

Every module uses Domain-Driven Design with Hexagonal Architecture. No exceptions. No "simple CRUD" shortcut.

**Why no shortcuts?** Because today's CRUD becomes tomorrow's 15-rule domain. Refactoring from CRUD → DDD mid-project is 10x more expensive than starting with DDD. The overhead is minimal when you have the infrastructure right.

### The Invariant

```
Presentation → Application → Domain ← Infrastructure
```

### Module Package Structure (100% enforced)

```
{module}/
├── domain/
│   ├── model/              ← Rich Domain Model (NO JPA, NO Spring)
│   ├── repository/         ← Port interface (DomainRepository<D,I>)
│   ├── event/              ← Domain events (records)
│   └── exception/          ← Domain exceptions (RuntimeException)
├── application/
│   ├── service/            ← Orchestration (NO business logic here)
│   ├── mapper/             ← Domain → Response DTO (MapStruct)
│   └── dto/
│       ├── request/        ← Jakarta validation
│       └── response/       ← API response (records)
├── infrastructure/
│   ├── adapter/            ← extends AbstractDomainRepository
│   ├── mapper/             ← Entity ↔ Domain (extends EntityMapper)
│   └── persistence/
│       ├── entity/         ← JPA entities (extends BaseJpaEntity)
│       └── repository/     ← JPA repos (@Query, Pageable)
└── presentation/
    └── rest/               ← Controllers (1 per aggregate root)
```

### DDD Infrastructure: The Foundation Classes

Every module is built on 4 shared base classes. **All are mandatory.**

#### BaseDomainModel — Domain identity + events + state machine

```java
@Getter @SuperBuilder(toBuilder = true) @NoArgsConstructor(access = PROTECTED)
public abstract class BaseDomainModel {
    protected UUID id;
    protected Instant createdAt, updatedAt;
    protected UUID createdBy, updatedBy;
    protected Boolean deleted = false;      // Soft delete (always Boolean, never boolean)

    // Domain Events — register in aggregate, publish in adapter
    private final transient List<DomainEvent> domainEvents = new ArrayList<>();
    protected void registerEvent(DomainEvent event) { domainEvents.add(event); }

    // State Machine validation — reusable across all aggregates
    protected <S extends Enum<S>> void validateTransition(
            S current, S target, Map<S, Set<S>> allowedTransitions) {
        Set<S> allowed = allowedTransitions.getOrDefault(current, Set.of());
        if (!allowed.contains(target))
            throw new InvalidStateTransitionException(current, target);
    }

    // Soft delete — mark, don't destroy
    public void logicalDelete(UUID userId) { deleted = true; deletedBy = userId; deletedAt = Instant.now(); }
}
```

#### DomainRepository — The Port (CRUD only, nothing more)

```java
public interface DomainRepository<D, I> {
    Optional<D> findById(I id);
    List<D> findAllByIds(List<I> ids);
    D save(D domain);
    List<D> saveAll(List<D> domains);
    D getById(I id);  // throws EntityNotFoundException
}
// CẤM: No custom read queries here. Those go to JpaRepository.
```

#### AbstractDomainRepository — The Adapter (Transactional Outbox)

```java
public abstract class AbstractDomainRepository<D extends BaseDomainModel, E, I>
        implements DomainRepository<D, I> {

    // save() → maps to entity → persists → writes events to outbox (SAME transaction)
    // → afterCommit callback publishes events immediately
    // → background polling job = safety net for failed afterCommit

    // Extension points for child entities:
    protected List<D> enrichList(List<D> domains) { return domains; }  // Override this
    // NEVER override enrich() or save() singular — ONLY enrichList() and saveAll()
}
```

#### BaseJpaEntity — Audit + soft delete columns

```java
@MappedSuperclass @EntityListeners(AuditingEntityListener.class)
@Getter @SuperBuilder(toBuilder = true) @NoArgsConstructor
public abstract class BaseJpaEntity {
    @Id private UUID id;
    @CreatedDate private Instant createdAt;
    @CreatedBy private UUID createdBy;
    @LastModifiedDate private Instant updatedAt;
    @LastModifiedBy private UUID updatedBy;
    private Boolean deleted = false;
    private Instant deletedAt;
    private UUID deletedBy;
    @PrePersist void prePersist() { if (id == null) id = UUID.randomUUID(); }
}
```

### Layer Discipline — WHY each boundary exists

| Layer | What it knows | What it MUST NOT know | The SA question |
|-------|--------------|----------------------|-----------------|
| **Domain** | Business rules only | No JPA, Spring, HTTP, SecurityUtils | "Can I test without starting Spring?" → **Yes** |
| **Application** | Domain + orchestration | No DB queries, no business logic | "Can I swap the use case trigger?" → **Yes** |
| **Infrastructure** | How to persist/query | No business logic, no HTTP | "Can I swap PostgreSQL?" → **Yes** |
| **Presentation** | Request/response shape | No business logic, no repos, no mappers | "Can I add GraphQL alongside REST?" → **Yes** |

---

## 2. CQRS-lite — Read Path ≠ Write Path

This isn't full CQRS with separate databases. It's **separating read and write concerns through different repositories**.

| Path | Flow | Why |
|------|------|-----|
| **WRITE** | Controller → Service → DomainRepo → Adapter → JPA | Enforce invariants through domain model |
| **READ** | Controller → Service → JpaRepo → Mapper → DTO | Optimize queries without domain overhead |

### Domain Repository = Write Only (CRUD)

```java
// ✅ Empty — inherits findById, getById, save, saveAll from base
public interface OrderRepository extends DomainRepository<Order, UUID> {}

// Why empty? Because:
// 1. Write operations need domain model validation (go through aggregate)
// 2. Read operations need flexible queries (pagination, filters, projections)
// 3. Mixing both creates a God interface
```

### JPA Repository = Flexible Reads

```java
public interface OrderJpaRepository extends JpaRepository<OrderJpaEntity, UUID> {
    // ✅ Always @Query — explicit, reviewable, refactor-safe
    @Query("SELECT o FROM OrderJpaEntity o WHERE o.status = :status AND o.deleted = false")
    Page<OrderJpaEntity> findByStatus(@Param("status") OrderStatus status, Pageable pageable);
}

// ❌ NEVER derived methods (findByStatusAndDeletedFalse)
// Why? Field rename → method still compiles but generates wrong query. Silent bugs.
```

### Specification Pattern — Dynamic Complex Queries

When filter conditions are dynamic (user selects multiple filters):

```java
// ✅ Composable Specifications for complex search
Specification<OrderJpaEntity> spec = Specification.where(isNotDeleted())
    .and(hasStatus(filter.getStatus()))          // only if status != null
    .and(createdAfter(filter.getFromDate()))      // only if fromDate != null
    .and(belongsToWorkshop(filter.getWorkshopId()));

Page<OrderJpaEntity> result = orderJpaRepo.findAll(spec, pageable);

// Each Specification is a reusable building block
private Specification<OrderJpaEntity> hasStatus(OrderStatus status) {
    return status == null ? null : (root, query, cb) -> cb.equal(root.get("status"), status);
}
```

> **Rule:** Use `@Query` for fixed queries. Use `Specification` for dynamic filter combinations. NEVER concatenate JPQL strings.

---

## 3. Injection Discipline

This is where architectural decay starts — one wrong injection and your layers are coupled.

| Component | Injects | NEVER injects |
|-----------|---------|---------------|
| **Controller** | Service only | ❌ Repository, Mapper, JpaRepository |
| **Service** | DomainRepo, JpaRepo, Mapper, other Services | ❌ Controller |
| **Adapter** | JpaRepository, EntityMapper | ❌ Service, Controller |
| **Mapper** | Nothing (stateless) | ❌ Any Spring bean |

```java
// The most common violation — and the most damaging:
@RestController
public class OrderController {
    private final OrderJpaRepository repo;       // ❌ Bypasses all business logic
    private final OrderResponseMapper mapper;    // ❌ Controller shouldn't know about mapping
}
// Why it's bad: Business logic now lives in controllers. Untestable. Unreusable.
```

> **SecurityUtils** (getting current user) → ONLY in Application Service. Never in Controller (HTTP concern leaking) or Domain (framework dependency).

### Transaction Management — @Transactional Placement

**This is the #1 source of bugs** in enterprise Spring Boot systems.

| Where | Rule |
|-------|------|
| **Application Service** | ✅ `@Transactional` — covers domain logic + persist + events |
| **Application Service (reads)** | ✅ `@Transactional(readOnly = true)` — Hibernate optimization |
| **Controller** | ❌ NEVER — transaction scope too wide |
| **Repository/Adapter** | ❌ NEVER — transaction scope too narrow |
| **Domain model** | ❌ NEVER — framework dependency in pure domain |

```java
@Service
@RequiredArgsConstructor
public class OrderService {
    @Transactional  // ← Unit of work: validate + save + publish events
    public OrderResponse create(CreateOrderRequest req) {
        UUID userId = SecurityUtils.getCurrentUserId();
        Order order = Order.create(req.orderCode(), req.quantity(), userId);
        orderRepo.save(order);
        return orderMapper.toResponse(order);
    }

    @Transactional(readOnly = true)  // ← Hibernate skips dirty checking → faster
    public PageResponse<OrderResponse> search(Pageable pageable) {
        return PageResponse.of(orderJpaRepo.findAllActive(pageable), orderMapper::toResponse);
    }
}

// ❌ NEVER: @Transactional on Controller
// ❌ NEVER: @Transactional on AbstractDomainRepository (already handled)
```

### Exception Architecture — Domain → Service → GlobalHandler

Exceptions flow **up** the layers, each layer throws its own type:

| Layer | Exception Type | Example |
|-------|---------------|--------|
| **Domain** | `DomainException extends RuntimeException` | `InvalidStateTransitionException`, `InsufficientStockException` |
| **Application** | `BusinessException` (with error code) | `OrderNotFoundException`, `DuplicateOrderCodeException` |
| **Infrastructure** | JPA/DB exceptions | `OptimisticLockingFailureException` |
| **Presentation** | Nothing — `GlobalExceptionHandler` catches all | — |

```java
// Domain layer — pure exception, NO HTTP awareness
public void approve(UUID approvedBy) {
    validateTransition(state, APPROVED, TRANSITIONS);  // throws InvalidStateTransitionException
    this.state = APPROVED;
    registerEvent(new OrderApprovedEvent(id, approvedBy, Instant.now()));
}

// Application layer — catches domain, throws business
public OrderResponse approve(UUID orderId) {
    Order order = orderRepo.findById(orderId)
        .orElseThrow(() -> new BusinessException("Order not found", CommonErrorCode.NOT_FOUND));
    order.approve(SecurityUtils.getCurrentUserId());
    orderRepo.save(order);
    return orderMapper.toResponse(order);
}

// GlobalExceptionHandler — maps ALL exceptions to ApiResponse
@ExceptionHandler(BusinessException.class)
public ApiResponse<?> handle(BusinessException ex) {
    return new ApiResponse<>().fail(ex.getMessage(), ex.getErrorCode());
}

@ExceptionHandler(InvalidStateTransitionException.class)
public ApiResponse<?> handle(InvalidStateTransitionException ex) {
    return new ApiResponse<>().fail(ex.getMessage(), CommonErrorCode.BAD_REQUEST);
}
```

> **Rule:** Controller NEVER catches exceptions. GlobalExceptionHandler is the ONLY exception handler.

---

## 4. API Standards

### URL Format

```
/api/v1/{module}/{scope?}/{domain}/...
```

| Segment | Purpose | Example |
|---------|---------|---------|
| `{module}` | Module name | `iam`, `lbr`, `wod`, `qms`, `pay`, `mat`, `eqp`, `dcc`, `mnt`, `aps`, `report` |
| `{scope}` | Access level *(optional, BEFORE domain)* | `public`, `me`, `admin`, or omitted |
| `{domain}` | Resource / aggregate root | `orders`, `materials`, `confirmations` |

#### Scope Convention

| Scope | Meaning | Example URL |
|-------|---------|-------------|
| `public` | No auth required | `/api/v1/iam/public/otp/request` |
| `me` | Current user only | `/api/v1/user/me/profile` |
| `admin` | Admin/super-admin only | `/api/v1/admin/users/{userId}` |
| *(omitted)* | Authenticated user | `/api/v1/wod/orders/{id}` |

#### Module Domains (Example)

| Module | Prefix | Primary Domains |
|--------|--------|-----------------|
| **IAM** | `/api/v1/iam` | `auth`, `users`, `roles`, `departments` |
| **{Mod-A}** | `/api/v1/{mod-a}` | `orders`, `operations`, `dispatches` |
| **{Mod-B}** | `/api/v1/{mod-b}` | `inspections`, `reports`, `alerts` |
| **Report** | `/api/v1/report` | `dashboard`, `export` |

### Response Convention

| Method | Return | Status |
|--------|--------|--------|
| GET (single) | `ApiResponse.of(data)` | 200 |
| GET (list) | `PageResponse.of(page)` | 200 |
| POST (create) | `ApiResponse.of(data)` + `@ResponseStatus(CREATED)` | 201 |
| PUT/PATCH | `ApiResponse.of(data)` | 200 |
| DELETE | `ApiResponse.ok()` | 200 |

#### ApiResponse Structure

```json
{
  "success": true,
  "code": 200,
  "message": "Success",
  "traceId": "abc123-def456-789",
  "timestamp": 1715567890123,
  "data": { "id": "uuid", "name": "..." }
}
```

#### PageResponse Structure

```json
{
  "success": true,
  "code": 200,
  "data": [ { ... }, { ... } ],
  "page": { "pageIndex": 0, "pageSize": 20, "total": 142 },
  "timestamp": 1715567890123
}
```

```java
// ✅ Clean, consistent
@PostMapping("/orders")
@ResponseStatus(HttpStatus.CREATED)
@PreAuthorize("hasPermission('WOD', 'CREATE')")
public ApiResponse<OrderResponse> create(@Valid @RequestBody CreateOrderRequest req) {
    return ApiResponse.of(orderService.create(req));
}

// ❌ Don't wrap in ResponseEntity — framework handles it
return ResponseEntity.ok(ApiResponse.of(data));

// ❌ Don't use ApiResponse<List<>> for pagination — you lose page metadata
public ApiResponse<List<OrderResponse>> list() {}
```

### Error Handling

| Code | Meaning |
|------|---------|
| `200/201` | Success |
| `400` | Bad Request (validation) |
| `401` | Unauthorized (no token / expired) |
| `403` | Forbidden (no permission) |
| `404` | Not Found |
| `409` | Conflict (idempotency key collision) |
| `429` | Too Many Requests (rate limit) |
| `500` | Internal Server Error |

### Query Parameters

| Param | Default | Description |
|-------|---------|-------------|
| `page` | 0 | Page number (0-indexed) |
| `size` | 20 | Items per page (max 100) |
| `sort` | `createdAt,desc` | Format: `field,asc` or `field,desc` |
| `search` | — | Full-text search (when supported) |

### Idempotency (POST Only)

```
POST /api/v1/wod/orders
X-Idempotency-Key: {client-generated UUID}
```

| Rule | Detail |
|------|--------|
| Scope | All **POST** create operations (orders, lots, documents, requests) |
| Key format | UUID v4, client-generated |
| Storage | Redis key `idempotency:{tenantId}:{key}` → TTL 24h |
| Behavior | Duplicate key → return cached response (HTTP 200), NO new record |
| Not applied | GET, PUT, PATCH, DELETE |

### API Versioning

| Rule | Detail |
|------|--------|
| Strategy | URL versioning: `/api/v1/...` → `/api/v2/...` |
| Breaking change | MUST create new version (`/v2/`) |
| Non-breaking | Adding new response fields → NO new version needed |
| Deprecation | Support old version minimum **6 months** after new version GA |
| Header | `X-API-Deprecated: true` on deprecated versions |

---

## 5. Mapping: MapStruct — The Only Way

### Why MapStruct Is Mandatory (Not a Preference)

Manual mapping (`new XxxResponse(order.getId(), order.getTitle())`) is the #2 source of bugs after N+1 queries. Add a field → forget to update 3 manual mappings → silent data loss.

### Two Mapper Types

| Mapper | Location | Converts |
|--------|----------|----------|
| **EntityMapper** | `infrastructure/mapper/` | Domain ↔ JPA Entity |
| **ResponseMapper** | `application/mapper/` | Domain → Response DTO |

```java
// ✅ The ONLY way to map
@Mapper(componentModel = "spring")
public interface OrderMapper {
    OrderResponse toResponse(Order domain);
}

// ❌ Manual mapping in: Service, Entity.toResponse(), Domain.toDto()
// — all forbidden. Zero exceptions.
```

### When Mapper Needs Custom Logic

Only when types genuinely differ: `Set<String> ↔ JSON column`, `embedded ↔ flat`. If both sides use the same enum → MapStruct auto-maps. Don't write `.name()` conversions.

---

## 6. Entity Design — Infrastructure, Not Domain

### Every Entity Extends BaseJpaEntity

```java
@Entity @Table(name = "orders", schema = "{prefix}_{mod_a}")
public class OrderJpaEntity extends BaseJpaEntity {
    // Inherited: id, createdAt, createdBy, updatedAt, updatedBy, deleted, deletedAt, deletedBy
    @Column(unique = true) private String orderCode;
    @Enumerated(EnumType.STRING) private OrderStatus status;
    @Version private Long version;  // 🔴 MANDATORY on all aggregate root entities
}
```

### Optimistic Locking — MANDATORY for Aggregate Roots

`@Version` is **required** on every aggregate root entity. Concurrent edits MUST be detected.

```java
// Entity: @Version Long version; → Hibernate auto-increments on save

// Service: handle concurrent modification
try {
    orderRepo.save(order);
} catch (OptimisticLockingFailureException e) {
    throw new BusinessException(
        "Order was modified by another user. Please reload and try again.",
        CommonErrorCode.CONFLICT);
}
```

**For critical sections** (e.g., inventory deduction), use PostgreSQL advisory locks:

```java
// AdvisoryLockService already in be-shared
advisoryLockService.withLock("lot-" + lotId, () -> {
    MaterialLot lot = lotRepo.getById(lotId);
    lot.deduct(quantity);
    lotRepo.save(lot);
});
```

### Soft Delete — The Only Delete

```java
// ❌ Hard delete = data loss + broken referential integrity
repository.delete(entity);

// ✅ Soft delete = audit trail + recovery + referential safety
entity.markDeleted(deletedBy);
repository.save(entity);

// 🔴 EVERY @Query MUST include: AND deleted = false
// Forgetting this → returning deleted records → data leak
```

### Adapter: enrichList/saveAll for Child Entities

When aggregate has children stored in separate tables:

```java
@Override
protected List<Campaign> enrichList(List<Campaign> campaigns) {
    // Batch load children → attach to parent (NOT N+1)
    Map<UUID, List<Step>> stepMap = loadStepsByCampaignIds(campaignIds);
    return campaigns.stream()
        .map(c -> c.toBuilder().steps(stepMap.getOrDefault(c.getId(), List.of())).build())
        .toList();
}

// Only override enrichList/saveAll (batch) — never enrich/save (singular)
```

### Bulk Operations Pattern

```java
// ✅ Batch import — not save() one by one
List<Material> materials = excelParser.parse(file);
materialRepo.saveAll(materials);  // Already in DomainRepository

// ✅ Batch update — load all, modify, save all
List<Order> orders = orderRepo.findAllByIds(orderIds);
orders.forEach(o -> o.cancel(userId));
orderRepo.saveAll(orders);
```

---

## 7. Validation — Trust Nothing From the Client

```java
public record CreateOrderRequest(
    @NotBlank(message = "Order code is required")
    @Size(max = 50, message = "Order code max 50 chars")  // Match VARCHAR(50)
    String orderCode,

    @NotNull(message = "Quantity is required")
    @Positive(message = "Quantity must be positive")
    BigDecimal quantity,

    @FutureOrPresent LocalDate plannedStart
) {}
```

**The alignment principle:** `@Size(max = n)` MUST match `VARCHAR(n)`. If DB says 100 chars, validation says 100 chars. Mismatch → DB exception instead of clean 400 error.

---

## 8. Naming Conventions — Convention IS Communication

| Component | Pattern | Example |
|-----------|---------|---------|
| Domain class | `{Entity}` | `Order` |
| Domain repo | `{Entity}Repository` | `OrderRepository` |
| Domain event | `{Entity}{Action}Event` | `OrderConfirmedEvent` |
| Service | `{Entity}Service` | `OrderService` |
| Request DTO | `{Action}{Entity}Request` | `CreateOrderRequest` |
| Response DTO | `{Entity}Response` | `OrderResponse` |
| JPA Entity | `{Entity}JpaEntity` | `OrderJpaEntity` |
| JPA Repo | `{Entity}JpaRepository` | `OrderJpaRepository` |
| EntityMapper | `{Entity}EntityMapper` | `OrderEntityMapper` |
| Adapter | `{Entity}Adapter` | `OrderAdapter` |

**Don't use:** `Port`, `UseCase`, `PersistenceAdapter`, `Gateway`, `Handler`, `RepositoryImpl` — these add ceremony without clarity.

---

## 9. Module Boundaries (Modular Monolith)

### Maven Structure: API JARs for Cross-Module Dependencies

Each module that exposes contracts to other modules is split into 2 Maven artifacts:

```
modules/
├── {prefix}-{mod-a}/          ← Full implementation (domain, infra, app, API)
├── {prefix}-{mod-a}-api/      ← Thin API JAR: QueryService + Events + Response DTOs
├── {prefix}-{mod-b}/
├── {prefix}-{mod-b}-api/
├── {prefix}-shared/           ← Base classes (BaseDomainModel, BaseJpaEntity, etc.)
└── ...
```

**API JAR contains exactly 3 things:**
1. `{Module}QueryService` — Interface for cross-module reads
2. Domain Events — Records consumed by other modules
3. Response DTOs — Shared data contracts

```java
// {prefix}-{mod-a}-api/src/.../{mod_a}/api/{ModA}QueryService.java
public interface ModAQueryService {
    Optional<ItemResponse> findItemById(UUID itemId);
    Optional<VersionResponse> findActiveVersion(UUID itemId);
}
// Implementation lives in {prefix}-{mod-a}, NOT in the API JAR

// {prefix}-{mod-b} depends on {prefix}-{mod-a}-api (NOT {prefix}-{mod-a})
// → Compile-time enforcement: Mod-B cannot access Mod-A internals
```

### Cross-Module Communication Rules

| Method | When | Example |
|--------|------|---------|
| **QueryService** (sync) | Need data in same transaction | Mod-B calls `modAQueryService.findActiveVersion()` |
| **Domain Events** (async) | Side-effects that can happen eventually | `ItemApprovedEvent` → Mod-C recalculates |
| **Direct repo injection** | ❌ NEVER | Bypasses module contract |

```java
// ❌ FORBIDDEN — Cross-module repository injection
private final ItemJpaRepository itemRepo;  // ❌ Mod-A internal!

// ✅ CORRECT — Depend on API JAR interface
private final ModAQueryService modAQueryService;  // ✅ Public contract

// ✅ CORRECT — Async events via Transactional Outbox
@TransactionalEventListener(phase = AFTER_COMMIT)
public void onItemApproved(ItemApprovedEvent event) { ... }
```

### Schema-per-Module (PostgreSQL)

```
PostgreSQL Instance
├── schema: {prefix}_{mod_a}  ← Orders, Dispatches
├── schema: {prefix}_{mod_b}  ← Inspections, Reports
├── schema: {prefix}_{mod_c}  ← Materials, Lots
├── schema: {prefix}_iam      ← Users, Roles
├── ...                       ← Each module owns its schema
```

- No cross-schema JOINs in JPA
- Cross-schema FKs use `module_id` references (no physical FK constraints)
- Need data from another module → call its QueryService or listen to its Events

---

## 10. Development Workflow — Order Matters

### Phase 0: Read docs (🔴 NON-NEGOTIABLE)

Before touching code, read: Domain Design → API Design → DB Schema → SRS/Requirements. Every time. No shortcuts.

### Build Order

```
1. Domain FIRST  → model, repo interface, events, exceptions
2. Infra SECOND  → entity, JPA repo, entity mapper, adapter
3. App THIRD     → service, DTO mapper, DTOs
4. API LAST      → controller
```

Why this order? Because domain drives everything. If domain is wrong, everything built on top is wrong.

---

## 11. DDD Testing Patterns — Test Each Layer Independently

### Domain Layer Test (Plain JUnit — ZERO Spring)

```java
@Test void should_reject_invalid_state_transition() {
    Order order = Order.create("ORD-001", BigDecimal.TEN, UUID.randomUUID());
    // Order starts as DRAFT, cannot go directly to COMPLETED
    assertThrows(InvalidStateTransitionException.class, () -> order.complete());
}

@Test void should_register_event_on_approval() {
    Order order = Order.create("ORD-001", BigDecimal.TEN, UUID.randomUUID());
    order.submit();
    order.approve(UUID.randomUUID());
    assertThat(order.getDomainEvents())
        .hasSize(1)
        .first().isInstanceOf(OrderApprovedEvent.class);
}
```

### Application Service Test (Mock DomainRepo)

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {
    @Mock OrderRepository orderRepo;
    @Mock OrderMapper orderMapper;
    @InjectMocks OrderService orderService;

    @Test void create_should_save_and_return_response() {
        var req = new CreateOrderRequest("ORD-001", BigDecimal.TEN, LocalDate.now());
        when(orderMapper.toResponse(any())).thenReturn(new OrderResponse(...));
        var result = orderService.create(req);
        verify(orderRepo).save(any(Order.class));
        assertThat(result).isNotNull();
    }
}
```

### Integration Test (Testcontainers + Real DB)

```java
@SpringBootTest
@Testcontainers
@ActiveProfiles("test")
class OrderServiceIT {
    @Container
    static PostgreSQLContainer<?> pg = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired OrderService orderService;

    @Test void full_lifecycle_test() {
        var response = orderService.create(new CreateOrderRequest(...));
        assertThat(response.id()).isNotNull();
        orderService.approve(response.id());
        // Verify event was published, state changed, etc.
    }
}
// ❌ NEVER use H2 — different SQL dialect = false confidence
// ✅ ALWAYS Testcontainers + real PostgreSQL
```

### ArchUnit — Enforce Architecture at Compile Time

```java
@AnalyzeClasses(packages = "vn.evo.mes")
class ArchitectureTest {
    @ArchTest
    static final ArchRule domain_should_not_depend_on_infrastructure =
        noClasses().that().resideInAPackage("..domain..")
            .should().dependOnClassesThat().resideInAPackage("..infrastructure..");

    @ArchTest
    static final ArchRule domain_should_not_use_spring =
        noClasses().that().resideInAPackage("..domain..")
            .should().dependOnClassesThat().resideInAPackage("org.springframework..");

    @ArchTest
    static final ArchRule controllers_should_only_use_services =
        classes().that().resideInAPackage("..presentation..")
            .should().onlyDependOnClassesThat()
            .resideInAnyPackage("..application..", "..dto..", "java..", "jakarta..",
                "org.springframework..", "io.swagger..");
}
```

---

## 12. Architectural Review Checklist

Before submitting any module's code:

### Structure
- [ ] Entities extend `BaseJpaEntity`? Domain models extend `BaseDomainModel`?
- [ ] Controller injects Service only?
- [ ] Domain Repository empty (no custom reads)?
- [ ] All JPA queries use `@Query` (no derived methods)?
- [ ] All queries have `AND deleted = false`?
- [ ] No `@Setter` on domain models?

### Transaction & Exception
- [ ] `@Transactional` only on Application Service methods?
- [ ] `@Transactional(readOnly = true)` on all read-only methods?
- [ ] No exception catching in Controllers?
- [ ] Domain exceptions extend `RuntimeException` (no HTTP awareness)?
- [ ] `@Version` on all aggregate root entities?
- [ ] `OptimisticLockingFailureException` handled in Service?

### Type Safety
- [ ] Zero primitive types in entities/DTOs?
- [ ] Enum everywhere (not String in Response)?
- [ ] `Instant` everywhere (no `LocalDateTime`)?
- [ ] Field names consistent across layers?

### Quality
- [ ] All mapping via MapStruct?
- [ ] All write requests validated with clear messages?
- [ ] `@Size(max)` aligned with DB `VARCHAR(n)`?
- [ ] No IO inside loops?
- [ ] SecurityUtils only in Service layer?

### Testing
- [ ] Domain model tested with plain JUnit (no Spring)?
- [ ] Integration tests use Testcontainers (no H2)?
- [ ] ArchUnit rules enforce layer boundaries?

---

## 13. Issue Severity Classification

When reviewing code, classify every finding. Not all violations are equal:

| Issue | Severity | Why |
|-------|----------|-----|
| Entity doesn't extend `BaseJpaEntity` | 🔴 **CRITICAL** | Missing audit, soft delete, broken lifecycle |
| Domain doesn't extend `BaseDomainModel` | 🔴 **CRITICAL** | Inconsistent identity, no event support |
| Primitive types in entity/DTO | 🔴 HIGH | NPE on nullable columns |
| Missing `deleted = false` in query | 🔴 HIGH | Returns deleted data → data leak |
| Hard delete (`repo.delete()`) | 🔴 HIGH | Permanent data loss |
| No validation on write request | 🔴 HIGH | Bad data reaches DB |
| SecurityUtils in Controller | 🔴 HIGH | Layer violation, untestable |
| `LocalDateTime` anywhere | 🔴 HIGH | Silent timezone bugs |
| String in Response where enum exists | 🔴 HIGH | API returns wrong type |
| Manual mapping in Service | 🟡 MED | Add field → forget → data loss |
| IO in loop (N+1) | 🟡 MED | Performance degradation |
| Custom reads in Domain Repo | 🟡 MED | CQRS violation |
| Dead/orphan fields in DTO | 🟡 MED | Bloated API contract |
| Derived query methods (no @Query) | 🟡 MED | Fragile, silent wrong queries |
| Raw types (`List` unparameterized) | 🟢 LOW | Type safety |
| Lambda instead of method reference | 🟢 LOW | Readability |

---

## 14. Common Anti-Patterns — and WHY They're Wrong

| Pattern | Impact | Fix |
|---------|--------|-----|
| Anemic domain model | Logic scattered, untestable | Rich model with intentful methods |
| `@Setter` on domain | Bypasses invariants, anyone can corrupt state | Factory methods + mutation methods |
| `LocalDateTime` | Silent timezone bugs in production | `Instant` + `TIMESTAMPTZ` |
| H2 for tests | Different SQL dialect → false confidence | Testcontainers + real PostgreSQL |
| `Map<String, Object>` return | No type safety, no Swagger, unreadable | Typed Response DTO (record) |
| Derived query methods | Field rename = silent wrong query | `@Query` annotation always |
| IO in loop | N+1 = 100x slower than batch | Batch load → Map lookup |
| Manual mapping | Add field → forget → data loss | MapStruct everywhere |
| Hard delete | Data loss, broken FK, no audit trail | Soft delete + `deleted = false` |
| String where enum exists | Typos, no compile-time safety | Enum across all layers |

---

> **"I don't write code to work. I write code to survive 10 years of maintenance."**
> — The mindset behind every pattern in this skill.
