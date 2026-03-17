# Database Design Document

<!-- 
  Exported: {export_date}
  Version: {version}
-->

| Field | Value |
|-------|-------|
| **Document ID** | DBD-{project}-{version} |
| **Project** | {project_name} |
| **Database** | {database_type} |
| **Version** | {version} |
| **Date** | {date} |

---

## 1. Database Overview

| Property | Value |
|----------|-------|
| DBMS | {PostgreSQL / MySQL / etc.} |
| Schema strategy | {per-module: mes_inv, mes_prd} |
| Migration tool | {Liquibase / Flyway} |
| Naming convention | {snake_case, prefix_module} |

---

## 2. Schema Design

### Schema: {schema_name}

#### Table: {table_name}

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| id | BIGINT | NO | sequence | Primary key |
| {column} | {type} | {yes/no} | {default} | {description} |
| created_at | TIMESTAMP | NO | now() | Audit |
| updated_at | TIMESTAMP | NO | now() | Audit |
| version | INTEGER | NO | 0 | Optimistic lock |

**Constraints:**
- PK: `pk_{table}` on `id`
- FK: `fk_{table}_{ref}` on `{column}` → `{ref_table}(id)`
- UQ: `uq_{table}_{column}` on `{column}`
- CK: `ck_{table}_{rule}` — {business_rule}

---

## 3. Entity Relationship Diagram

{erd_diagram_or_mermaid}

---

## 4. Index Strategy

| Table | Index | Columns | Type | Rationale |
|-------|-------|---------|------|-----------|
| {table} | `idx_{table}_{cols}` | {columns} | BTREE / GIN | {why} |

---

## 5. Migration Strategy

| # | Changeset | Description | Reversible |
|---|-----------|-------------|-----------|
| V001 | Baseline | Initial schema | No |
| V002 | {desc} | {what_changed} | {yes/no} |

### Migration Rules
- Changesets are **immutable** after release
- Always provide rollback plan
- Test with production-like data volume
- Never rename columns — add new + migrate + drop old

---

## 6. Data Archival & Retention

| Table | Retention | Archive Strategy |
|-------|-----------|-----------------|
| {table} | {period} | {strategy} |

---

## 7. Performance Considerations

| Concern | Approach |
|---------|---------|
| Large table pagination | Keyset pagination |
| Full-text search | {GIN index / Elasticsearch} |
| Connection pooling | HikariCP, max {N} |
| Read replicas | {if applicable} |
