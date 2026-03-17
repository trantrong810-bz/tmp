# Architecture Design Document

<!-- 
  Template based on ISO/IEC/IEEE 42010:2022 + arc42
  Exported: {export_date}
  Version: {version}
-->

| Field | Value |
|-------|-------|
| **Document ID** | ADD-{project}-{version} |
| **Project** | {project_name} |
| **Version** | {version} |
| **Status** | Draft / Approved |
| **Architect** | {architect} |
| **Date** | {date} |

---

## 1. Introduction & Goals

### 1.1 Requirements Overview
{requirements_overview}

### 1.2 Quality Goals
| Priority | Quality Goal | Scenario |
|----------|-------------|----------|
| 1 | {goal} | {scenario} |

### 1.3 Stakeholders
| Role | Expectation |
|------|------------|
| {role} | {expectation} |

---

## 2. Architecture Constraints

| # | Constraint | Type | Rationale |
|---|-----------|------|-----------|
| 1 | {constraint} | Technical / Business / Regulatory | {why} |

---

## 3. Context & Scope

### 3.1 Business Context
{business_context_diagram}

### 3.2 Technical Context
{technical_context_diagram}

---

## 4. Solution Strategy

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Architecture style | {style} | {why} |
| Primary framework | {framework} | {why} |
| Database | {database} | {why} |
| Communication | {pattern} | {why} |

---

## 5. Building Block View

### 5.1 Level 1: System Overview
{system_modules_diagram}

### 5.2 Level 2: Module Decomposition

#### Module: {module_name}
- **Responsibility:** {responsibility}
- **Interfaces:** {interfaces}
- **Dependencies:** {dependencies}

---

## 6. Runtime View

### Scenario: {scenario_name}
{sequence_diagram_or_flow}

---

## 7. Deployment View
{deployment_diagram}

---

## 8. Cross-Cutting Concerns

### 8.1 Security
{security_approach}

### 8.2 Logging & Monitoring
{observability}

### 8.3 Error Handling
{error_strategy}

### 8.4 Persistence
{data_strategy}

---

## 9. Architecture Decisions

See [Architecture Decision Records](adr/)

| ADR | Decision | Status |
|-----|----------|--------|
| [ADR-001](adr/001-{name}.md) | {title} | Accepted |

---

## 10. Quality Requirements

### Quality Tree
{quality_tree}

### Quality Scenarios
| Quality | Scenario | Response Measure |
|---------|----------|-----------------|
| {attr} | {scenario} | {measure} |

---

## 11. Risks & Technical Debt

| # | Risk | Probability | Impact | Mitigation |
|---|------|------------|--------|-----------|
| 1 | {risk} | High/Med/Low | High/Med/Low | {action} |

---

## 12. Glossary
See [Glossary](../00-project/glossary.md)
