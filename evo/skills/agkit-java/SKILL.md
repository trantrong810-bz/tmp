---
name: java-patterns
description: Java 21+ development principles. Modern Java features, clean architecture, DDD patterns, testing strategies. Teaches thinking, not copying.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Java 21+ Patterns — Senior Dev Perspective

> "Good Java code reads like a business document. Great Java code makes invalid states unrepresentable."

This skill teaches **decision-making** for Java 21+. Not rules to memorize — principles to internalize.

---

## 1. Modern Java: Use the Language, Don't Fight It

Java 21 is expressive. If your code looks like Java 8 boilerplate, you're doing it wrong.

### Records — Default choice for data

Records aren't just "less boilerplate." They signal: **this is immutable data with no hidden behavior.**

```java
// ✅ DTOs, Events, Value Objects, Query results → always records
public record OrderCreatedEvent(UUID orderId, String orderCode, Instant createdAt) {}

// ✅ Self-validating value objects
public record Money(BigDecimal amount, Currency currency) {
    public Money {
        if (amount.compareTo(BigDecimal.ZERO) < 0)
            throw new IllegalArgumentException("Negative amount");
    }
    public Money add(Money other) {
        if (!this.currency.equals(other.currency))
            throw new DomainException("Currency mismatch");
        return new Money(this.amount.add(other.amount), this.currency);
    }
}

// ❌ Don't use records for: mutable entities, aggregate roots, anything with lifecycle
```

### Sealed types — Make the compiler your QA

Sealed types aren't about restriction — they're about **exhaustiveness guarantees**.

```java
public sealed interface PaymentResult
    permits Success, Failed, Pending {
    record Success(UUID txId, BigDecimal amount) implements PaymentResult {}
    record Failed(String errorCode, String reason) implements PaymentResult {}
    record Pending(UUID txId) implements PaymentResult {}
}

// The compiler enforces exhaustive handling — no forgotten cases
return switch (result) {
    case Success s -> processPayment(s);
    case Failed f  -> handleFailure(f);
    case Pending p -> scheduleRetry(p);
};
// No default needed. Add a new case → compiler tells you everywhere to update.
```

### Virtual threads — Know when NOT to use them

```
The decision matrix:
├── I/O-bound (HTTP, DB, file)     → ✅ Virtual threads
├── CPU-bound (hashing, ML)        → ❌ Platform threads (pinning risk)
├── synchronized + I/O inside      → ⚠️ Replace with ReentrantLock first
└── Already async (reactive)       → 🤔 Measure before migrating

Spring Boot 3.2+: spring.threads.virtual.enabled=true
  → Requests auto-use virtual threads. But watch for pinning in legacy libs.
```

---

## 2. The Type System IS Your Architecture

The most important architectural decision in Java isn't your framework — it's your type system.

### Wrapper types, always (never primitives)

```java
// Why? Because null carries meaning.
private Integer totalOrders;   // null = "not computed yet"
private int totalOrders;       // 0 = "zero orders" or "not computed"?
// JPA + nullable DB columns + primitives = NullPointerException at 3AM.
```

### Instant everywhere — LocalDateTime is a timezone bug waiting to happen

```java
private Instant createdAt;                         // ✅ always
Instant.now().plus(Duration.ofDays(30));            // ✅ Instant has no plusDays()
private LocalDateTime createdAt;                   // ❌ which timezone? nobody knows
```

### Enums must be consistent across ALL layers

This is where 90% of type-mismatch bugs come from:

| Layer | Type | Why |
|-------|------|-----|
| Domain model | `OrderStatus` enum | Single source of truth |
| JPA Entity | `@Enumerated(STRING) OrderStatus` | Readable DB, auto-mapped |
| Response DTO | `OrderStatus` | Client gets type-safe values |
| JPA Repo params | `OrderStatus` | Compile-time safety |
| Request DTO | `String` | Parse → enum in Service (graceful errors) |

If Response returns `String` where an enum exists → that's a **bug**, not a style choice.

### Field names must match across layers

```
Request.dealValue → Domain.dealValue → Entity.deal_value → Response.dealValue
❌ Request.dealAmount ≠ Domain.dealValue  (confusing API, mapper bugs)
```

---

## 3. Rich Domain Model — The Heart of DDD

### The Senior Dev Perspective

An anemic domain model (entities as data bags + God services) is the #1 architectural debt in enterprise Java. It feels fast initially but compounds into unmaintainable spaghetti.

**Rich domain = business rules live in the entity, protected by invariants.**

```java
@Getter
public class Order extends BaseDomainModel {
    private String orderCode;
    private OrderStatus status;

    // Factory method enforces creation invariants
    public static Order create(String code, UUID workshopId, BigDecimal qty) {
        if (qty.compareTo(BigDecimal.ZERO) <= 0)
            throw new BusinessRuleViolationException("Quantity must be positive");
        var order = new Order();
        order.orderCode = code;
        order.status = OrderStatus.DRAFT;
        order.registerEvent(new OrderCreatedEvent(order.getId(), code));
        return order;
    }

    // State transitions are business operations, not setters
    public void approve(UUID approverId) {
        if (this.status != OrderStatus.SUBMITTED)
            throw new InvalidStateTransitionException("SUBMITTED", this.status.name());
        this.status = OrderStatus.APPROVED;
        registerEvent(new OrderApprovedEvent(this.getId(), approverId));
    }
}
```

### Lombok Rules — Protect the boundary

| Annotation | Verdict | Reasoning |
|------------|---------|-----------|
| `@Getter` | ✅ | Read state is fine |
| `@Setter` | ❌ FORBIDDEN | Destroys encapsulation, bypasses invariants |
| `@AllArgsConstructor` | ❌ FORBIDDEN | Bypasses factory method validation |
| `@SuperBuilder(toBuilder=true)` | ✅ Internal | For reconstitution from persistence only |
| `@NoArgsConstructor(PROTECTED)` | ⚠️ | Only when JPA/framework demands it |

### When is anemic OK?

Simple CRUD with < 3 business rules → skip domain model complexity. Not everything needs DDD. But once you have state machines, validation chains, or cross-entity rules → **rich model is mandatory, not optional.**

---

## 4. Domain Events — Decouple Without Distributed Complexity

```java
// Always records. Always past tense. Always carry full context.
public record OrderApprovedEvent(UUID orderId, UUID approvedBy, Instant approvedAt)
    implements DomainEvent {}

// Register in aggregate → publish in application service → handle in consumer
// ❌ Never publish from domain model directly (domain must stay pure)
```

---

## 5. Effective Java — The Non-Negotiable Habits

From Joshua Bloch's Effective Java 3rd Edition. Not guidelines — **habits.**

| # | Rule | Do | Don't |
|---|------|----|-------|
| EJ-1 | Empty collections | `List.of()` | `return null` |
| EJ-2 | Optional for single | `Optional<Order>` | `Optional<List<>>` |
| EJ-3 | Domain exceptions | `OrderNotFoundException` | `RuntimeException("not found")` |
| EJ-4 | 1 file = 1 class | Separate files | Exception: nested record in DTO |
| EJ-5 | Utility class | `@NoArgsConstructor(PRIVATE) final` | Public constructor |
| EJ-6 | equals/hashCode | By ID only (base class) | `@EqualsAndHashCode` all fields |
| EJ-7 | Copy objects | `toBuilder().build()` | `.clone()` |
| EJ-8 | Debug output | `@ToString(exclude={"password"})` | No toString at all |
| EJ-9 | Lambda style | `Order::getId` | `o -> o.getId()` |
| EJ-10 | Stream purity | No side effects in streams | `forEach` with mutation |
| EJ-11 | Declare by interface | `List<>`, `Map<>`, `Set<>` | `ArrayList<>`, `HashMap<>` |
| EJ-12 | Generics | `List<OrderResponse>` | Raw `List` |
| EJ-13 | No IO in loops | Batch load → Map lookup | `findById()` in for loop |

---

## 6. Error Handling — Exceptions Carry Business Meaning

```java
// Domain exceptions hierarchy (NO Spring dependency)
DomainException (base)
├── EntityNotFoundException      → 404
├── InvalidStateTransitionException → 409
├── BusinessRuleViolationException  → 422
└── ConcurrencyConflictException    → 409

// Throw early (domain boundary), catch late (presentation layer)
// Global @RestControllerAdvice translates domain → HTTP
```

---

## 7. Testing — The Senior Dev Testing Philosophy

> "Tests are the only documentation that never lies."

### Test Pyramid (Quantified)

| Level | % | Focus | Speed |
|-------|---|-------|-------|
| Unit (domain) | 60% | Invariants, state transitions, factories | ⚡ No Spring |
| Integration | 25% | Real DB (Testcontainers), queries | 🔄 Medium |
| Contract/API | 10% | Endpoint contracts, response shapes | 🔄 Medium |
| E2E | 5% | Critical happy paths only | 🐢 Slow |

### Coverage Targets (by business risk, not by line count)

| Layer | Target | Why |
|-------|--------|-----|
| Domain model | 90%+ | Core business logic — bugs here = money lost |
| Application service | 80%+ | Orchestration correctness |
| Controller | 70%+ | Validation, response mapping |
| Infrastructure | 60%+ | Query correctness, mapping |

### Naming: `should_[expected]_when_[condition]`

```java
should_publish_when_status_is_draft()
should_throw_InsufficientBalance_when_amount_exceeds_balance()
```

### Test Data: Factories over constructors

```java
public class OrderFactory {
    public static Order draft() {
        return Order.create("WO-001", UUID.randomUUID(), BigDecimal.TEN);
    }
    public static Order approved() {
        Order o = draft(); o.submit(); o.approve(UUID.randomUUID()); return o;
    }
}
```

### Mutation Testing — Prove Your Tests Actually Test Something

Line coverage is vanity. Mutation testing is reality. PITest mutates your code (`>` → `>=`, remove method call, return null) and checks if tests catch it.

```xml
<plugin>
    <groupId>org.pitest</groupId>
    <artifactId>pitest-maven</artifactId>
    <configuration>
        <targetClasses>com.example.domain.*</targetClasses>
        <mutationThreshold>80</mutationThreshold>
    </configuration>
</plugin>
```

| Mutation | What it proves |
|----------|----------------|
| Conditionals (`>` → `>=`) | Boundary conditions tested |
| Return values (return null) | Method contracts verified |
| Void methods (remove call) | Side effects asserted |
| Math (`+` → `-`) | Calculations correct |

**Target:** Mutation kill rate > 80% on domain models. If a mutant survives → your test is decorative, not protective.

### Flaky Test Protocol — Zero Tolerance

Flaky tests erode trust in the entire suite. Handle them surgically:

```
1. DETECT    — CI flags test as flaky (failed then passed on retry)
2. QUARANTINE — @Tag("flaky"), exclude from main CI pipeline
3. DIAGNOSE  — Root cause:
   ├── Timing?        → Awaitility / polling assertions
   ├── Shared state?  → @BeforeEach cleanup
   ├── External dep?  → Testcontainers / WireMock
   └── Race condition? → CountDownLatch / synchronization
4. FIX       — Remove the flakiness (not the test)
5. RESTORE   — Move back to main CI suite
```

### Contract Testing — API Boundaries

When frontend and backend evolve independently, contract tests prevent silent breakage:

```groovy
// Spring Cloud Contract
Contract.make {
    request { method GET(); url "/api/v1/wod/orders/123" }
    response {
        status 200
        body([ data: [ id: "123", orderCode: $(anyNonBlankString()), status: "DRAFT" ] ])
    }
}
```

### Testing Anti-Patterns

| ❌ Don't | ✅ Do | Why |
|----------|-------|-----|
| `Thread.sleep()` | Awaitility / polling | Flaky, slow |
| H2 for integration | Testcontainers + real PG | Different SQL behavior |
| Shared mutable state | Isolated per test | Test interference |
| `@SpringBootTest` for domain | Pure JUnit | 100x faster |
| Test implementation | Test behavior | Brittle on refactor |
| Ignore flaky tests | Quarantine → fix → restore | Erodes CI trust |
| 100% line coverage goal | 80% mutation kill rate | Coverage ≠ quality |

---

## 8. Performance: Think in Batches

### N+1 Prevention — The Most Common Performance Bug

```java
// ❌ 100 orders = 101 queries
for (Order order : orders) {
    User user = userRepo.findById(order.getUserId()); // DB call per iteration
}

// ✅ 100 orders = 2 queries
Set<UUID> userIds = orders.stream().map(Order::getUserId).collect(toSet());
Map<UUID, User> userMap = userService.findAllByIds(userIds)
    .stream().collect(toMap(User::getId, identity()));
orders.forEach(o -> process(o, userMap.get(o.getUserId())));
```

**Rule:** If you see `findById()`, `save()`, or any external call inside a loop → it's a bug.

### BigDecimal — Financial calculations

```java
BigDecimal price = new BigDecimal("10.50");   // ✅ String constructor
BigDecimal total = price.multiply(qty).setScale(2, RoundingMode.HALF_UP);

double price = 10.50;                         // ❌ Floating point errors
new BigDecimal(10.50);                        // ❌ Still floating point
price1 == price2;                             // ❌ Reference equality
```

---

## 9. Concurrency — Choose the Right Lock

| Strategy | When | How | Trade-off |
|----------|------|-----|-----------|
| Optimistic | Read-heavy, low contention | JPA `@Version` | Retry on conflict |
| Pessimistic | Write-heavy, critical | `SELECT FOR UPDATE` | Blocks others |
| Distributed | Multi-instance | Redis `SETNX` / Redisson | Network overhead |

Default to optimistic. Escalate only when you measure contention.

---

> **The SA perspective:** Choose complexity only when the problem demands it. Simple CRUD? Skip DDD. Complex domain? Rich models save you. Always measure before optimizing. And remember — the best code is code you don't have to write.
