# UX Design Specification

<!-- 
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | UXD-{project}-{version} |
| **Version** | {version} |
| **Status** | Draft / Approved |
| **Designer** | {designer} |
| **Date** | {date} |

---

## 1. User Personas

### Persona: {persona_name}
| Attribute | Detail |
|-----------|--------|
| Role | {role} |
| Goals | {what_they_want} |
| Pain points | {current_frustrations} |
| Tech savviness | Low / Medium / High |

---

## 2. User Flows

### Flow: {flow_name}
| Step | Action | Screen | Notes |
|------|--------|--------|-------|
| 1 | {user_action} | {screen_name} | {notes} |
| 2 | {user_action} | {screen_name} | {notes} |

### Flow Diagram
{flow_diagram_or_mermaid}

---

## 3. Screen Specifications

### Screen: {screen_name}

| Property | Value |
|----------|-------|
| **URL path** | `/{path}` |
| **Layout** | {layout_type} |
| **Primary action** | {main_CTA} |
| **Data displayed** | {data_sources} |

#### Components
| Component | Type | Behavior | States |
|-----------|------|----------|--------|
| {component} | {button/form/table/card} | {interaction} | default, hover, active, disabled, error |

#### Responsive Behavior
| Breakpoint | Layout Change |
|-----------|--------------|
| Desktop (≥1024px) | {behavior} |
| Tablet (768-1023px) | {behavior} |
| Mobile (<768px) | {behavior} |

---

## 4. Interaction Patterns

| Pattern | Usage | Example |
|---------|-------|---------|
| Confirmation dialog | Destructive actions | Delete, bulk operations |
| Toast notification | Success/error feedback | Save, submit |
| Loading skeleton | Data fetching | Table, card lists |
| Infinite scroll / Pagination | Long lists | {where_used} |

---

## 5. Accessibility (WCAG 2.1 AA)

| Requirement | Implementation |
|-------------|---------------|
| Keyboard navigation | All interactive elements focusable |
| Color contrast | ≥ 4.5:1 ratio |
| Screen reader | ARIA labels on all controls |
| Form errors | Inline + summary |

---

## 6. References
- Design system: [design-artifacts/](../../design-artifacts/)
- SRS: [srs.md](srs.md)
