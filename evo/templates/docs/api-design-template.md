# API Design Document

<!-- 
  Template based on OpenAPI/REST conventions
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | API-{project}-{version} |
| **Base URL** | `{base_url}` |
| **Version** | {version} |
| **Auth** | {auth_mechanism} |
| **Date** | {date} |

---

## 1. API Conventions

| Convention | Value |
|-----------|-------|
| Style | RESTful |
| Versioning | URL path (`/api/v1/`) |
| Format | JSON |
| Date format | ISO 8601 (`2026-03-17T12:00:00Z`) |
| Pagination | Keyset (`?after={cursor}&limit=20`) |
| Naming | kebab-case URLs, camelCase JSON |
| Error format | RFC 7807 Problem Details |

### Standard Error Response

```json
{
  "type": "https://api.example.com/errors/not-found",
  "title": "Resource not found",
  "status": 404,
  "detail": "Inventory item with ID 123 was not found",
  "instance": "/api/v1/inventory/123"
}
```

### Standard HTTP Status Codes

| Code | Usage |
|------|-------|
| 200 | Success (GET, PUT) |
| 201 | Created (POST) |
| 204 | No content (DELETE) |
| 400 | Validation error |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 409 | Conflict (duplicate) |
| 422 | Unprocessable entity |
| 500 | Internal server error |

---

## 2. Resource Endpoints

### {Resource Name}

#### `GET /api/v1/{resources}`
- **Description:** List resources with pagination
- **Auth required:** Yes
- **Query params:**

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `after` | string | No | Cursor for keyset pagination |
| `limit` | int | No | Page size (default: 20, max: 100) |
| `sort` | string | No | Sort field (default: createdAt) |

- **Response:** `200 OK`
```json
{
  "data": [...],
  "pagination": { "nextCursor": "abc123", "hasMore": true }
}
```

#### `GET /api/v1/{resources}/{id}`
- **Description:** Get single resource
- **Response:** `200 OK`

#### `POST /api/v1/{resources}`
- **Description:** Create resource
- **Request body:**
```json
{
  "field": "value"
}
```
- **Response:** `201 Created`

#### `PUT /api/v1/{resources}/{id}`
- **Description:** Update resource
- **Response:** `200 OK`

#### `DELETE /api/v1/{resources}/{id}`
- **Description:** Delete resource
- **Response:** `204 No Content`

---

## 3. Authentication & Authorization

| Aspect | Detail |
|--------|--------|
| Mechanism | {JWT / OAuth2 / API Key} |
| Token location | `Authorization: Bearer {token}` |
| Token expiry | {duration} |
| Refresh | {strategy} |
| Roles | {roles_list} |

---

## 4. Rate Limiting

| Tier | Limit | Window |
|------|-------|--------|
| Default | {N} req | per minute |
| Authenticated | {N} req | per minute |
| Admin | Unlimited | — |

---

## 5. API Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | {date} | Initial release |
