Dưới đây là **PRD chi tiết + User Flow bản build-ready** sau khi cập nhật PRFAQ mới.

---

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

## Product: SaaS tổ chức giải cầu lông CLB – MVP v1

---

# 1. Product Summary

### Vision ngắn hạn (MVP)

Ứng dụng iOS giúp BTC CLB tổ chức và vận hành **giải cầu lông đôi 8–32 đội** chỉ bằng điện thoại trong ngày thi đấu.

### Giá trị cốt lõi

App phải thay thế hoàn toàn:

* Excel
* Giấy in bracket
* Gọi trận thủ công

Nếu BTC vẫn phải mở Excel → sản phẩm thất bại.

---

# 2. Personas

## 2.1 Organizer (Primary / payer)

Vai trò:

* Tạo giải
* Nhập đội
* Generate bracket
* Nhập điểm tại sân
* Gọi trận tiếp theo

Môi trường sử dụng:

* Ồn ào
* Áp lực thời gian
* Một tay cầm điện thoại

=> UI phải **cực nhanh – cực đơn giản – ít chạm**

---

## 2.2 Viewer (Secondary)

Vai trò:

* VĐV
* Khán giả

Nhu cầu:

* Trận tiếp theo là gì?
* Đang đánh tới đâu?
* Ai đang thắng?

Không cần login.

---

# 3. Scope MVP (Functional Requirements)

---

# 3.1 Tournament Creation

Organizer có thể tạo giải với:

| Field           | Required |
| --------------- | -------- |
| Tournament name | ✓        |
| Date            | optional |

Sau khi tạo → vào màn hình cấu hình giải.

---

# 3.2 Event (Nội dung thi đấu)

Một giải có nhiều nội dung đôi:

Ví dụ:

* Đôi TB
* Đôi TBY

Mỗi event hoạt động như **1 tournament nhỏ độc lập**.

Organizer có thể:

* Tạo event
* Sửa tên event
* Xoá event

---

# 3.3 Team Management

Trong mỗi event:

Organizer nhập danh sách đôi:

Fields:

* Team name (VD: Hùng / Nam)
* Club name (optional)

Logic:

* Nếu giải nội bộ → có thể bỏ trống club
* Nếu giải mở rộng → club hiển thị ở public page

Constraints:

* 8–32 teams / event

---

# 3.4 Seeding

Hai mode:

### Random seeding

1 tap shuffle.

### Manual seeding

Drag & drop reorder list.

Seeding ảnh hưởng:

* Chia bảng
* Knockout bracket

---

# 3.5 Bracket Generation (CORE)

Format duy nhất MVP:

## GROUP STAGE → KNOCKOUT

System tự động:

### Phase 1 – Group stage

* Auto chia bảng
* Auto generate lịch round robin

### Phase 2 – Ranking

* Tính điểm bảng
* Xác định top teams

### Phase 3 – Knockout

* Generate knockout bracket

Organizer có thể:

* Regenerate bất cứ lúc nào.

---

# 3.6 Match Ordering Engine (CRITICAL)

System phải tạo:
👉 **Global Match Queue**

Bao gồm tất cả trận của tất cả event.

Quy tắc:

* Có dependency giữa các trận knockout
* Có nhiều event song song
* Tất cả FINAL phải ở cuối danh sách
* Có thể PIN trận thủ công
* Có thể regenerate order
* Có version history

Output:
Danh sách trận theo **thứ tự thi đấu**.

Lưu ý:
Không quản lý thời gian hoặc sân → chỉ thứ tự.

---

# 3.7 Match Scoring (Most critical UX)

BTC đứng tại sân → cần nhập điểm cực nhanh.

### Score input screen phải hỗ trợ:

* Tap để tăng điểm
* Edit thủ công
* Confirm winner
* Save trong < 3s

Sau khi save:
System tự động:

* Update bảng
* Update knockout bracket
* Unlock trận tiếp theo trong queue

---

# 3.8 Public Viewer Page

System tạo 1 public link.

Viewer thấy:

* Trận sắp diễn ra
* Kết quả mới nhất
* Bracket
* Bảng đấu

Realtime update.

---

# 3.9 Regeneration & Versioning

Organizer có thể:

* Regenerate bracket
* Regenerate match order

System phải:

* Lưu version
* Cho phép rollback

---

# 4. Non-Functional Requirements

| Requirement      | Target   |
| ---------------- | -------- |
| Generate bracket | <3s      |
| Save score       | <1s      |
| Learning time    | <10 phút |

---

# 5. Core User Flows

---

# FLOW A — Create Tournament (Setup flow)

1. Open app
2. Tap **Create Tournament**
3. Enter tournament name
4. Create Event(s)
5. Enter teams
6. Seed teams
7. Tap **Generate Tournament**

Output:

* Bracket created
* Match queue created
* Public link created

---

# FLOW B — Tournament Day (Primary loop)

Màn hình chính: **Match Queue**

Hiển thị:

* Match now
* Match next

### Loop:

1. Tap match
2. Enter score
3. Confirm winner
4. Save

System:

* Update standings
* Update bracket
* Push next match

Lặp lại tới Final.

---

# FLOW C — Regenerate

Khi BTC muốn sửa:

1. Edit teams / seeding
2. Tap **Regenerate**
3. Confirm

System:

* Create new version
* Rebuild bracket + queue

---

# FLOW D — Viewer

Viewer mở link → thấy:

Home:

* Next matches
* Latest results
* Bracket

Không cần login.

---

# 6. Core Screens

Organizer:

1. Tournament list
2. Event list
3. Team entry
4. Seeding screen
5. Bracket view
6. ⭐ Match Queue (home screen)
7. ⭐ Score input
8. Version history

Viewer:

1. Public home
2. Bracket view
3. Match list

---

# 7. Acceptance Criteria (MVP Success)

BTC phải có thể:

* Tạo giải 16 đội <10 phút
* Chạy toàn bộ giải chỉ bằng app
* Không cần Excel backup
* Share link cho VĐV xem

Nếu không đạt → MVP fail.

---

# 8. Suggested Next Step

PRD đã đủ để bắt đầu build.

Bước logic tiếp theo:
👉 Thiết kế **Data Model / Entities**
(Teams, Matches, Brackets, MatchQueue, Versions).
