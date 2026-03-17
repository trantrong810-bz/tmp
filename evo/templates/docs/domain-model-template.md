# Domain Model Design

<!-- 
  Exported: {export_date}
  Version: {version}
-->

| Field | Value |
|-------|-------|
| **Document ID** | DMD-{project}-{version} |
| **Project** | {project_name} |
| **Version** | {version} |
| **Date** | {date} |

---

## 1. Bounded Contexts

| Context | Responsibility | Team |
|---------|---------------|------|
| {context} | {responsibility} | {team} |

### Context Map
{context_map_diagram}

---

## 2. Aggregates

### {Aggregate Name}

| Property | Value |
|----------|-------|
| **Root Entity** | {root_entity} |
| **Invariants** | {business_rules} |
| **Lifecycle** | {creation_to_deletion} |

#### Entities
| Entity | Attributes | Rules |
|--------|-----------|-------|
| {entity} | {attrs} | {rules} |

#### Value Objects
| VO | Attributes | Validation |
|----|-----------|-----------|
| {vo} | {attrs} | {validation} |

#### Domain Events
| Event | Trigger | Payload |
|-------|---------|---------|
| {event} | {when_raised} | {data} |

#### State Machine
| State | Transitions | Guard |
|-------|------------|-------|
| {state} | → {next_state} | {condition} |

---

## 3. Domain Services

| Service | Responsibility | Coordinates |
|---------|---------------|------------|
| {service} | {what_it_does} | {which_aggregates} |

---

## 4. Cross-Module Communication

| From | To | Mechanism | Data |
|------|----|----------|------|
| {module} | {module} | Event / QueryService | {payload} |

---

## 5. Repository Interfaces

| Repository | Aggregate | Key Methods |
|-----------|----------|------------|
| {repo} | {aggregate} | findById, save, findByX |

---

## 6. Glossary Reference
See [Glossary](../00-project/glossary.md)
