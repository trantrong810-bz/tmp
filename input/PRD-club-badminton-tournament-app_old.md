---
workflowType: 'prd'
workflow: 'edit'
classification:
  domain: 'sports-tournament'
  projectType: 'saas-mobile'
  complexity: 'medium'
inputDocuments: ['PRFAQ-club-badminton-tournament-saas.md']
stepsCompleted: ['step-e-01-discovery', 'step-e-02-review', 'step-e-03-edit']
lastEdited: '2026-04-10'
editHistory:
  - date: '2026-04-10'
    changes: 'Updated Create Tournament fields and added Excel Export Fallback based on PRFAQ updates'
---

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

> **Version:** 1.2 | **Cập nhật:** 2026-04-10
> **Platform:** iOS (MVP). Android + Web Viewer là roadmap.
> **Tài liệu gốc:** [PRFAQ-club-badminton-tournament-saas.md](./PRFAQ-club-badminton-tournament-saas.md)
> **Trạng thái:** Draft — chờ architecture review 2-Tier Role & Notification trước khi dev.

---

## Product: SaaS tổ chức giải cầu lông CLB – MVP v1

---

# 1. Product Summary

### Vision ngắn hạn (MVP)

Ứng dụng iOS giúp BTC CLB tổ chức và vận hành **giải cầu lông đôi nội dung 8–32 đội** chỉ bằng điện thoại trong ngày thi đấu, hỗ trợ nhiều trọng tài đồng thời và thông báo thông minh đến người theo dõi.

### Giá trị cốt lõi

App phải thay thế hoàn toàn:

* Excel / Google Sheets để nhập đội và lập lịch
* Giấy in bracket
* Gọi trận thủ công (hô lên loa hoặc nhắn Zalo)

> **MVP fail definition:** Nếu BTC vẫn phải mở Excel trong ngày thi đấu → sản phẩm thất bại.

---

# 2. Personas

## 2.1 Admin / Organizer (Primary — người trả tiền)

**Đặc điểm:**
* Không chuyên IT, tổ chức giải 1–2 lần/tháng
* Làm vì đam mê → rất thiếu công cụ phù hợp

**Vai trò trong app:**
* Tạo giải, cấu hình nội dung (Event) và luật điểm
* Nhập danh sách đội, seeding
* Generate bracket, quản lý Match Queue
* Thêm/xóa Trọng tài
* Override điểm, xử lý Walkover/Forfeit
* Xem Referee Dashboard

**Môi trường sử dụng:**
* Sân ồn ào, áp lực thời gian, một tay cầm điện thoại

> **UI constraint:** Cực nhanh – cực đơn giản – ít chạm. Mỗi thao tác quan trọng ≤ 2 tap.

---

## 2.2 Referee / Trọng tài (Secondary — operator)

**Đặc điểm:**
* Có tài khoản sẵn, được Admin tìm và add vào giải
* Đứng tại sân, cần nhập điểm nhanh, ít nhìn màn hình

**Vai trò trong app:**
* Xem danh sách giải đấu mình được phân công
* Tự chọn trận từ Match Queue để chấm điểm
* Nhập điểm realtime (Interactive mode)
* Xác nhận kết quả, sử dụng 60s Undo Window
* Có thể cầm nhiều trận cùng lúc

**Môi trường sử dụng:**
* Ồn ào, cần nhìn ra sân, điện thoại 1 tay

---

## 2.3 Viewer / Follower (Tertiary — người theo dõi)

**Đặc điểm:**
* VĐV, khán giả, bất kỳ ai quan tâm đến giải đấu

**2 chế độ:**

| Chế độ | Yêu cầu | Khả năng |
|---|---|---|
| **Read-only Viewer** | Không cần tài khoản | Xem lịch, kết quả, bracket qua link public |
| **Follower** | Cần tài khoản | Nhận Push Notification khi trận bắt đầu / sắp kết thúc |

---

# 3. Scope MVP (Functional Requirements)

> ⚠️ **Nếu thiếu 1 trong các mục 3.1 – 3.10 → MVP fail.**

---

## 3.1 Tournament Creation

Admin tạo giải với các trường:

| Field | Bắt buộc | Ghi chú |
|---|---|---|
| Tên giải | ✓ | |
| Ngày bắt đầu thi đấu | Tùy chọn | |
| Ngày kết thúc thi đấu | Tùy chọn | |
| Địa điểm thi đấu | Tùy chọn | |
| Logo | Tùy chọn | Dùng để in áo/cúp/huy chương |
| Banner | Tùy chọn | Hiển thị background cho giải đấu |
| Mô tả giải | Tùy chọn | Hiển thị trên public page |

Sau khi tạo → vào màn hình cấu hình giải (tạo Event).

---

## 3.2 Event (Nội dung thi đấu) & Scoring Rules Preset

Một giải có nhiều **Event** (nội dung thi đấu). Mỗi Event hoạt động như 1 tournament nhỏ độc lập.

Ví dụ: Đôi Nam TB, Đôi Nam Mạnh, Đôi Nam Nữ.

**Admin có thể:** Tạo / Sửa tên / Xóa Event.

### Scoring Rules Preset (bắt buộc mỗi Event)

Mỗi Event phải được gắn 1 **Preset luật điểm**. Luật điểm hiển thị trực tiếp trên màn hình nhập điểm để Admin/Referee không cần nhớ.

| Preset | Mô tả | Điểm thắng | Điều kiện |
|---|---|---|---|
| 1 Set 21 | Đánh 1 set đến 21 | 21 | Cách biệt ≥ 2, tối đa 30 |
| 1 Set 31 (chạm) | Đánh đến 31, không cần cách biệt | 31 | Chạm đúng 31 là thắng |
| Best of 3 (Set 21) | Thắng 2 trong 3 set | 21/set | Cách biệt ≥ 2, tối đa 30 |

> **Lưu ý triển khai:** Scoring rules ảnh hưởng đến (a) logic kiểm tra điều kiện thắng khi Referee bấm Confirm, (b) ngưỡng kích hoạt Trigger 2 Notification.

---

## 3.3 Team Management

Trong mỗi Event, Admin nhập danh sách cặp đấu:

| Field | Bắt buộc | Ghi chú |
|---|---|---|
| Tên cặp VĐV | ✓ | VD: Hùng / Nam |
| Tên CLB | Tùy chọn | Hiển thị trên public page nếu giải mở rộng |

**Constraints:** 8–32 đội / Event.

### Tính năng Paste danh sách nhanh (Quick Import)

Admin có thể **dán (Paste) nguyên cột danh sách** từ Excel, Google Sheet, hoặc Zalo message vào một text area duy nhất. Hệ thống tự nhận diện từng dòng = 1 đội.

**Acceptance Criteria:**
- Hỗ trợ dán text nhiều dòng, mỗi dòng = 1 tên đôi
- Hệ thống parse và hiển thị preview danh sách để Admin xác nhận trước khi lưu
- Admin vẫn có thể thêm/sửa/xóa từng dòng sau khi paste

---

## 3.4 Seeding

| Mode | Thao tác |
|---|---|
| **Random** | 1 tap Shuffle — hệ thống tự trộn |
| **Manual** | Drag & Drop để xếp lại thứ tự |

Seeding ảnh hưởng đến: chia bảng (Group Stage) và cặp đấu Knockout bracket.

---

## 3.5 Bracket Generation

Admin chọn 1 trong 2 phương thức tạo bracket:

### A) 3 Template nhanh (1 click)

| Template | Mô tả |
|---|---|
| **Group Stage → Knockout** | Chia bảng, đấu vòng tròn trong bảng, lấy Nhất/Nhì vào Knockout. *(Nhất/Nhì được tính tự động theo hiệu số — nhưng Admin xác nhận thủ công ai vào nhánh nào để xử lý mọi tình huống ngoại lệ.)* |
| **Round Robin (League)** | Tất cả đấu với tất cả, xếp hạng cuối giải |
| **Single Knockout** | Loại trực tiếp từ vòng 1 |

### B) Custom Format (kết hợp tự do)

Admin ghép các đơn vị format cơ bản: `League` + `Group` + `Knockout` theo thứ tự tùy ý. Mỗi "phase" là 1 đơn vị format độc lập.

*Ví dụ phức tạp: Group Stage → Round Robin trong bảng → Single Knockout.*

### Regenerate

Admin có thể Regenerate Bracket bất cứ lúc nào (kèm cảnh báo xóa kết quả cũ nếu có). Hệ thống lưu Version và cho phép Rollback.

---

## 3.6 Match Ordering Engine (CRITICAL)

Hệ thống tự động sinh **Global Match Queue** — danh sách tất cả trận của tất cả Event, theo thứ tự thi đấu.

**Quy tắc sắp xếp:**
* Có dependency giữa các trận Knockout (trận sau phụ thuộc kết quả trận trước)
* Nhiều Event chạy song song được xen kẽ hợp lý
* Tất cả trận Final phải ở cuối danh sách
* Admin có thể Skip / Move Down trận bất kỳ
* Có thể PIN trận lên đầu
* Có thể Regenerate order + Version history

> **Quan trọng:** App không quản lý sân hay giờ — chỉ quản lý thứ tự trận đấu.

---

## 3.7 Match Scoring (Most Critical UX)

Admin hoặc Referee đứng tại sân → cần nhập điểm cực nhanh, ít nhìn màn hình.

### Interactive Mode (chấm điểm từng pha)

* Nút **[+]** to gấp 3–4 lần nút **[-]** (tránh fat-finger)
* Tap [+] để tăng điểm theo pha bóng thực tế
* Điểm lưu local ngay lập tức (Optimistic UI), sync server ngầm
* Khi mạng rớt: hiện cờ **"Saved Locally"**, biến mất khi sync xong
* Màn hình hiển thị **Scoring Rule** của Event (VD: "1 Set 21 | Cách biệt 2") để không cần nhớ

### Quick Result Mode (nhập kết quả sau trận)

* Gõ tay trực tiếp điểm tổng kết của từng đội/set
* Dùng khi không chấm từng điểm (VD: nhập kết quả sau khi trận đã kết thúc)
* Có nudge nhắc nếu điểm chưa thỏa điều kiện thắng

### Xác nhận kết quả & Undo

* Khi bấm **"Kết thúc trận"**: hệ thống validate điều kiện thắng theo Scoring Rule
* Sau khi confirm: 60-second **Undo Window** — nút đếm ngược, bracket chưa bị khóa
* Sau 60 giây: trận chuyển sang `DONE`, bracket và standings tự động update

---

## 3.8 Special Match Handling

### Walkover (bỏ 1 trận)
* 1 nút kết thúc trận ngay với trạng thái "Vắng mặt"
* Không cần nhập điểm 21-0 thủ công
* Bracket tự động cập nhật: đội còn lại đi tiếp

### Forfeit Team (đội rút khỏi giải)
* Admin đánh dấu 1 đội "Rút lui khỏi giải"
* Tất cả trận chưa đánh của đội đó được xử lý tự động (đối thủ thắng mặc định)
* Bracket và Match Queue tự động update

---

## 3.9 2-Tier Role System (Admin & Referee)

### Phân quyền

| Quyền | Admin | Referee |
|---|---|---|
| Cấu hình giải, tạo Event | ✓ | ✗ |
| Generate / Regenerate bracket | ✓ | ✗ |
| Quản lý Match Queue (Skip/Move) | ✓ | ✗ |
| Thêm/Xóa Referee | ✓ | ✗ |
| Override điểm bất kỳ trận | ✓ | ✗ |
| Nhập điểm trận đang active | ✓ | ✓ |
| Chọn trận để chấm điểm | ✓ | ✓ |
| Xem toàn bộ Match Queue | ✓ | ✓ |

### Cơ chế thêm Referee

Admin tìm user bằng **email**, **số điện thoại**, hoặc **username** (exact match để bảo vệ privacy). 1-click Add → Referee có quyền ngay.

### Đồng thời (Concurrency)

* **Không có Screen Lock** — nhiều Referee có thể cùng nhập điểm 1 trận
* **Last-write-wins**: điểm cuối cùng được lưu trên server thắng
* Mọi Referee đang xem cùng trận đều thấy điểm update **realtime qua WebSocket**
* Conflict được BTC xử lý trực tiếp trên sân — app không can thiệp

### Admin Referee Dashboard

Admin thấy realtime:
* Danh sách Referee: **Active [Trận X]** / **Idle**
* **Active** = có ít nhất 1 score update trong trận X trong vòng **5 phút** gần nhất (configurable)
* **Idle** = không có thao tác quá 5 phút

---

## 3.10 Smart Match Notification

### Follow Tournament

* Viewer đăng nhập vào App và bấm **"Follow Giải"** để nhận Push Notification
* Follow yêu cầu tài khoản (để liên kết Device Token với user)
* Xem lịch/kết quả không cần follow (link public không cần login)

### Trigger Logic (mỗi trận có 2 trigger)

**Trigger 1 — Trận bắt đầu:**
- Fire khi Referee nhập điểm đầu tiên → Match state: `PENDING → IN_PROGRESS`
- Nội dung: *"Trận [STT]: [Đội A] vs [Đội B] vừa bắt đầu!"*
- Idempotent: chỉ gửi đúng 1 lần/trận dù có Undo

**Trigger 2 — Gần kết thúc (set quyết định):**
- Chỉ fire ở **set quyết định** (set 3 của Best of 3, hoặc set 2 nếu 1 đội đã thắng set 1)
- Ngưỡng theo Scoring Rule:
  - 1 Set 21: khi 1 đội đạt **18 điểm**
  - 1 Set 31 (chạm): khi 1 đội đạt **28 điểm**
- Nội dung: *"Set quyết định Trận [STT] đã đến điểm 18! Tay vợt trận tiếp theo hãy chuẩn bị."*
- Idempotent: chỉ gửi 1 lần khi vượt ngưỡng (không gửi lại nếu điểm bị gỡ về 17 rồi lên 18)

### Match Lifecycle

```
PENDING → IN_PROGRESS → DONE
           ↑[Điểm đầu]   ↑[Confirm + 60s Undo xong]
           →Fire Trigger 1  →Bracket update
                           →Fire Trigger 2 (tại ngưỡng)
```

### Hạ tầng

* Score update realtime qua **WebSocket**
* Server evaluate Trigger 2 sau mỗi score update
* Dispatch **FCM** (Android) / **APNs** (iOS) với idempotency key per trigger

---

## 3.11 Public Viewer Page

Hệ thống tạo 1 **link public** và QR code cho mỗi giải. QR có thể chiếu hoặc in tại nhà thi đấu.

Viewer không đăng nhập thấy:

| Nội dung | Realtime |
|---|---|
| Trận sắp diễn ra (Match Queue) | ✓ |
| Kết quả mới nhất | ✓ |
| Bracket (sơ đồ thi đấu) | ✓ |
| Bảng xếp hạng (Group Stage) | ✓ |

Trang public dẫn đến màn hình cài App (nếu muốn Follow/nhận notification).

---

## 3.12 Resilience (Mạng chập chờn)

* **Optimistic Local Commit:** Điểm lưu local ngay, sync server ngầm sau
* **"Saved Locally" Toast:** Hiện banner khi offline, tự mất khi sync xong
* **Excel Export Fallback:** Có file excel lưu trữ tất cả các trận đấu và kết quả tự động export ra local của điện thoại mỗi 1 phút để đề phòng mất mạng hoàn toàn.
* **Phạm vi:** Chỉ cache điểm số trong session hiện tại và file excel chạy ngầm — không có full offline mode

---

# 4. Authentication Flow

| Người dùng | Phương thức đăng ký / đăng nhập |
|---|---|
| Admin | Email + Password hoặc Google OAuth |
| Referee | Email + Password hoặc Google OAuth (cùng hệ thống với Admin) |
| Follower | Email + Password hoặc Google OAuth |
| Read-only Viewer | Không cần tài khoản |

> **MVP note:** Social login (Google) ưu tiên để giảm ma sát onboarding. Apple Sign-in bắt buộc nếu app lên App Store.

---

# 5. Scoring Rules Definition

Định nghĩa chi tiết để dev implement đúng logic:

| Tình huống | Rule |
|---|---|
| Thắng set | Đạt đúng điểm thắng (21/31) **VÀ** cách biệt ≥ 2 (trừ preset 31 chạm) |
| Điểm tối đa 1 Set 21 | 30–29 là điểm cuối cùng (không có điểm 31) |
| Best of 3 — thắng trận | Thắng 2 set |
| Set quyết định (Best of 3) | Set mà nếu thắng sẽ thắng trận: Set 3, hoặc Set 2 nếu 1 đội đã thắng Set 1 |
| Walkover | Đội vắng mặt thua 0-21 (không nhập tay) |
| Forfeit | Tất cả trận chưa đánh: đối thủ thắng mặc định |

---

# 6. Non-Functional Requirements

| Yêu cầu | Mục tiêu |
|---|---|
| Generate bracket | < 3 giây |
| Save score (local commit) | < 0.5 giây (optimistic) |
| Sync score lên server | < 1 giây (khi có mạng) |
| Excel Export Background | Không gây giật lag hoặc tăng thời gian Save score > 1s |
| Learning time cho Admin mới | < 10 phút |
| Push Notification latency | < 5 giây sau trigger |
| WebSocket reconnect | Tự động, user không thấy gián đoạn |

---

# 7. Core User Flows

---

## FLOW A — Admin Setup Tournament

1. Đăng nhập → Màn hình chính
2. Tap **"Tạo Giải Đấu"**
3. Nhập tên giải, ngày, logo (optional)
4. Tạo Event(s) → Gắn Scoring Rule Preset cho mỗi Event
5. Nhập danh sách đội (Paste / nhập tay)
6. Seeding (Random / Manual Drag & Drop)
7. Chọn Format (3 Template hoặc Custom)
8. Tap **"Generate Bracket"**

Output: Bracket + Global Match Queue + Public link + QR Code

---

## FLOW B — Admin vận hành ngày thi đấu

Màn hình chính: **Global Match Queue**

1. Xem trận đang diễn ra + trận tiếp theo
2. Skip / Move Down trận khi cần
3. Xem Referee Dashboard (ai đang cầm trận nào)
4. Override điểm / xử lý Walkover / Forfeit khi có sự cố

---

## FLOW C — Referee chấm điểm

1. Đăng nhập → "Giải đấu tôi đang làm trọng tài"
2. Chọn giải → Xem Global Match Queue
3. Tap vào trận PENDING → mở Scoring Screen
4. Nhập điểm (Interactive Mode) từng pha bóng
5. Khi trận xong: Tap "Kết thúc trận" → 60s Undo → DONE

---

## FLOW D — Follower theo dõi và nhận thông báo

1. Nhận link public / scan QR
2. Xem trực tiếp trên Web browser (không cần login)
3. Tap "Follow Giải Đấu" → được redirect cài App / đăng nhập
4. Sau khi Follow → nhận Push Notification:
   - Trigger 1: Trận bắt đầu
   - Trigger 2: Set quyết định gần kết thúc

---

## FLOW E — Admin Regenerate

Khi có thay đổi nhân sự phút chót:

1. Vào phần Quản lý Đội
2. Sửa danh sách / seeding
3. Tap **"Regenerate Bracket"** → xác nhận cảnh báo
4. Hệ thống tạo Version mới — Admin có thể Rollback

---

# 8. Core Screens

### Admin Screens

| # | Màn hình | Mô tả |
|---|---|---|
| 1 | Tournament List | Danh sách giải Admin đang quản lý |
| 2 | Tournament Setup | Tạo/sửa giải + Event + Scoring Rule |
| 3 | Team Entry | Nhập đội (Paste / tay) |
| 4 | Seeding Screen | Drag & Drop hoặc Random shuffle |
| 5 | Bracket View | Sơ đồ nhánh đấu |
| 6 | ⭐ Match Queue | Màn hình chính ngày thi đấu |
| 7 | ⭐ Score Input (Admin) | Override / Walkover / Forfeit |
| 8 | Referee Management | Tìm, Add, Remove referee |
| 9 | ⭐ Referee Dashboard | Ai đang active ở trận nào |
| 10 | Version History | Lịch sử Regenerate, Rollback |

### Referee Screens

| # | Màn hình | Mô tả |
|---|---|---|
| 1 | My Tournaments | Giải đang được phân công |
| 2 | Match Queue (Referee) | Global queue, chọn trận để chấm |
| 3 | ⭐ Scoring Screen | Chấm điểm realtime, Undo Window |

### Public Viewer (Web)

| # | Màn hình | Mô tả |
|---|---|---|
| 1 | Public Home | Trận sắp tới, kết quả mới nhất |
| 2 | Bracket View | Sơ đồ thi đấu realtime |
| 3 | Match List | Danh sách tất cả trận + kết quả |

---

# 9. Acceptance Criteria (MVP Success)

BTC phải có thể:

* Tạo và setup giải 16 đội (bao gồm nhập đội, seeding, generate bracket) trong **< 10 phút**
* Chạy toàn bộ giải trong ngày thi đấu **chỉ bằng app** — không cần Excel
* Phân công 2+ trọng tài và giám sát họ từ xa qua Referee Dashboard
* VĐV/khán giả nhận notification khi trận bắt đầu mà không cần BTC gọi thủ công

Nếu không đạt → MVP fail.

---

# 10. Out of Scope (Cố tình chưa làm)

* Quản lý số sân / số hiệu sân — chỉ quản lý thứ tự trận
* Thanh toán / đăng ký thi đấu online
* Ranking / Stats cá nhân VĐV (Player Profile)
* In-App Chat / Comment *(→ V2+; hiện tại CLB dùng Zalo)*
* Full Offline Mode *(Cache điểm trong session là đủ)*
* Sponsor / Branding nâng cao
* Check-in VĐV
* Android App *(→ V2+)*

---

# 11. Biggest Risks

| # | Rủi ro | Mức độ | Biện pháp giảm thiểu |
|---|---|---|---|
| 1 | Bracket generation không đủ tốt (semi-auto slotting vào Knockout) | 🔴 Cao | Cho Admin xác nhận thủ công sau ranking |
| 2 | Nhập điểm sai, bracket bị hỏng | 🔴 Cao | 60s Undo + Admin Override bất kỳ lúc nào |
| 3 | BTC không tin tưởng dùng ngày thi đấu thật | 🟡 Trung bình | Dry Run Mode (test giả) |
| 4 | Mạng 4G kém trong nhà thi đấu mái tôn | 🟡 Trung bình | Optimistic Local Commit + "Saved Locally" toast |
| 5 | Notification onboarding friction (VĐV không cài app) | 🟡 Trung bình | Onboarding flow nhẹ cho Follower |

---

# 12. Suggested Next Steps

1. **Architecture Review:** 2-Tier Role WebSocket concurrency + FCM/APNs Notification pipeline
2. **Data Model Design:** Tournament, Event, Team, Match, Bracket, MatchQueue, Notification, User, Role
3. **UI Mockups:** Scoring Screen, Referee Dashboard, Public Viewer Page
4. **Dev Sprint Planning:** Chia Epic theo User Stories đã có ở Section 13

---

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

---

# 13. User Stories (Agile Scope)

## 13.1 Luồng A (Admin Flow)

### Epic 1: Admin - Setup Giải đấu (Tournament Setup)

**US-A01: Tạo và cấu hình giải đấu**
* **As a** Tournament Admin
* **I want to** tạo một giải đấu mới với các thiết lập cơ bản (Tên giải, Ngày tổ chức) và tạo các nội dung thi đấu (Events: Đôi Nam, Đôi Nam Nữ...)
* **So that** tôi có không gian làm việc độc lập để quản lý từng nội dung.
* **Acceptance Criteria:**
  - Nhập bắt buộc: Tên giải. (Tùy chọn: Ngày, Logo/Banner).
  - Có thể tạo nhiều Event trong một giải đấu.
  - Xóa/Sửa tên Event khi giải chưa diễn ra.

**US-A02: Quản lý danh sách VĐV & Seeding**
* **As a** Tournament Admin
* **I want to** nhập danh sách các cặp đấu (Team) vào từng Event và thiết lập hạng hạt giống (Seeding)
* **So that** hệ thống có dữ liệu để chia bảng và xếp lịch bốc thăm.
* **Acceptance Criteria:**
  - Có thể nhập nhanh tên cặp VĐV, tên CLB (dành cho giải mở rộng).
  - Có nút "Random Shuffle" để trộn ngẫu nhiên.
  - Có thể kéo-thả (Drag & Drop) để xếp hạng Manual Seeding.
  - Giới hạn 8 - 32 đội mỗi Event.

**US-A03: Auto-Generate Bracket & Match Queue**
* **As a** Tournament Admin 
* **I want to** tạo lịch thi đấu bằng 1-click dựa trên Template (Vòng bảng → Knockout, Round Robin, Single Knockout) hoặc bằng cách ghép Custom Format
* **So that** tôi không phải tự vẽ sơ đồ và tự sắp xếp thứ tự thi đấu thủ công.
* **Acceptance Criteria:**
  - Chọn 1 trong 3 template có sẵn hoặc build Custom format.
  - Hệ thống tự động chia bảng (nếu có Group Stage).
  - Tự động sinh ra Bracket Knockout.
  - Tự động gộp tất cả các trận của các Event thành 1 **Global Match Queue** (thứ tự thời gian thi đấu từ trên xuống).
  - Đảm bảo các trận Chung kết (Final) nằm ở cuối queue.

---

### Epic 2: Admin - Phân quyền Trọng tài (Referee Management)

**US-A04: Tìm và thêm Trọng tài (Referee)**
* **As a** Tournament Admin
* **I want to** tìm user bằng email, số điện thoại hoặc username để cấp quyền Referee cho giải đấu của tôi
* **So that** các trọng tài có quyền vào app và chấm điểm các trận đấu thay tôi.
* **Acceptance Criteria:**
  - Admin có màn hình "Quản lý Trọng tài".
  - Chức năng search chỉ trả về kết quả matching exact (chính xác username/email/sđt) để bảo vệ privacy.
  - 1-click "Add" để đưa user vào danh sách Referee của giải.
  - Ngay sau khi Add, Referee có quyền chỉnh sửa điểm số trong giải.

**US-A05: Bỏ quyền Trọng tài (Revoke)**
* **As a** Tournament Admin
* **I want to** có thể xóa quyền Referee của một user ngay lập tức
* **So that** tôi kiểm soát được rủi ro nếu có người cố tình phá hoại hoặc hết nhiệm vụ.
* **Acceptance Criteria:**
  - Nút "Remove" ở cạnh tên từng Referee trong danh sách.
  - Ngay sau khi Remove, phiên làm việc (websocket) chấm điểm của user đó bị ngắt quyền write lập tức.

---

### Epic 3: Admin - Vận hành Giải đấu (Live Operation)

**US-A06: Quản lý Match Queue linh hoạt (Skip / Move Down)**
* **As a** Tournament Admin
* **I want to** có thể Bỏ qua (Skip) hoặc Đẩy lùi (Move Down) các trận đấu đang ở đầu danh sách Match Queue
* **So that** luồng giải đấu không bị kẹt khi VĐV chưa tới sân hoặc đang cần nghỉ ngơi.
* **Acceptance Criteria:**
  - Quẹt trái/phải trên UI thẻ trận đấu (hoặc bấm context menu) để chọn "Move down".
  - Trận bị dời sẽ rớt xuống sau X trận kế tiếp (hoặc cuối danh sách tuỳ chọn nhanh).
  - Mọi thay đổi về thứ tự lập tức đồng bộ realtime cho màn hình của Referee và Follower.

**US-A07: Giám sát Trọng tài (Admin Referee Dashboard)**
* **As a** Tournament Admin
* **I want to** xem được dashboard để biết trọng tài nào đang bắt trận nào
* **So that** tôi điều phối được từ xa nếu thấy 1 sân trống hoặc 1 trọng tài ngưng hoạt động quá lâu.
* **Acceptance Criteria:**
  - Có danh sách trạng thái Referee đang Active/Idle.
  - Được đánh dấu là **Active [Trận X]** nếu có thao tác nhập lượt điểm trong vòng 5 phút qua.
  - Vượt quá 5 phút không có thao tác → Trạng thái **Idle**.

**US-A08: Ghi đè kết quả (Take Over / Override) & Xử lý đặc biệt**
* **As a** Tournament Admin
* **I want to** có thể trực tiếp sửa điểm bất kỳ trận đấu nào (dù referee đang cầm) và đánh dấu nộp phạt/bỏ cuộc (Forfeit/Walkover)
* **So that** tôi sửa được các lỗi sai nghiêm trọng mà trọng tài không sửa kịp, hoặc xử lý biến cố tại sân.
* **Acceptance Criteria:**
  - Khi Admin click vào trận đang **IN_PROGRESS**, có nút "Override Score".
  - Khi lưu override, điểm server lập tức đẩy xuống (last-write-wins) cho màn hình Referee đang trực tiếp chấm.
  - Có tuỳ chọn kết thúc nhanh trận đấu: "Walkover" (bỏ cuộc) mà không cần phải gõ tay 21-0.
  - Bracket tự động update và tính điểm nhánh nếu dùng Walkover.

**US-A09: Tạo mới toàn bộ lịch đấu (Regenerate & Versioning)**
* **As a** Tournament Admin
* **I want to** có thể sửa danh sách đội, bốc thăm lại seeding sau đó bấm "Regenerate Bracket" ngay cả khi giải sắp bắt đầu
* **So that** tôi xử lý được những sự thay đổi nhân sự phút chót (có đội bỏ thi đấu, đổi nhánh) mà không phải tạo giải đấu mới từ đầu.
* **Acceptance Criteria:**
  - Hệ thống cảnh báo nội dung thay đổi sẽ xóa các kết quả cũ (nếu có).
  - Có thể Regenerate và lưu lại Version (người dùng có thể khôi phục lại Version trước đó để Rollback nếu lỡ tay bấm).
  - Hệ thống rebuild lại Bracket và update tự động lại Global Match Queue.

---

## 13.2 Luồng B (Referee Flow)

### Epic 4: Referee - Tham gia & Chấm điểm

**US-B01: Truy cập giải đấu được phân công**
* **As a** Referee
* **I want to** nhìn thấy giải đấu mà tôi vừa được add vào ngay trên màn hình chính của ứng dụng
* **So that** tôi có thể chọn giải và tiến hành làm nhiệm vụ mà không cần tìm kiếm phức tạp.
* **Acceptance Criteria:**
  - Cần đăng nhập tài khoản.
  - Có mục "Giải đấu của tôi đang làm trọng tài".
  - Click vào giải đấu hiển thị Global Match Queue.

**US-B02: Chọn trận đấu từ Match Queue**
* **As a** Referee
* **I want to** tự do click chọn một hoặc nhiều trận đấu đang có trạng thái PENDING từ Match Queue
* **So that** tôi có thể chấm điểm cho sân cụ thể mà tôi đang đứng giám sát.
* **Acceptance Criteria:**
  - Chuyển vào màn hình nhập điểm (Scoring Screen) ngay lập tức khi chọn trận.
  - Hệ thống cho phép nhiều Referee cùng mở một trận đấu (không giới hạn quyền vào).

**US-B03: Màn hình nhập điểm (Scoring Screen - Interactive Mode)**
* **As a** Referee
* **I want to** có một giao diện chấm điểm cực kỳ to và phản hồi nhanh, với nút Tăng điểm [+] to gấp 3 lần nút Giảm điểm [-]
* **So that** tôi không bao giờ chạm nhầm (fat-finger) khi đang nhìn ra sân.
* **Acceptance Criteria:**
  - Nút [+] chiếm phần lớn màn hình.
  - Ngay khi bấm [+] điểm đầu tiên của trận, state chuyển sang `IN_PROGRESS` (kích hoạt Trigger 1 Notification trên Server).
  - Mọi thao tác đổi điểm cập nhật realtime (last-write-wins) qua WebSocket cho bất kỳ ai đang xem.
  - Điểm lưu cục bộ (Local Commit) trước để cảm giác tức thì (optimistic UI), sau đó đồng bộ ngầm. Hiển thị cờ "Saved Locally" nều mạng rớt.

**US-B04: Xác nhận kết quả & 60s Undo Window**
* **As a** Referee
* **I want to** bấm xác nhận người thắng cuộc và có một khoảng thời gian ngắn để hoàn tác (Undo)
* **So that** tôi nộp kết quả an toàn nhưng vẫn sửa được ngay nếu hai bên VĐV phát hiện sai sót sau khi tôi vừa bấm nút.
* **Acceptance Criteria:**
  - Khi bấm "Kết thúc trận", hệ thống kiểm tra điểm có đủ đIều kiện kết thúc set/match không (vd: cách biệt 2 điểm). 
  - Trạng thái chuyển sang `DONE` sau khi kết thúc.
  - Màn hình duy trì nút "Undo" đếm ngược 60 giây. Trong thời gian này, bracket chưa bị khoá vĩnh viễn, referee có thể revert lại trạng thái `IN_PROGRESS` và gỡ điểm.

---

## 13.3 Luồng C (Follower & Viewer Flow)

### Epic 5: Follower - Xem lịch và Nhận thông báo

**US-C01: Theo dõi giải không cần tài khoản (Read-only Viewer)**
* **As a** Viewer (Khán giả/VĐV đang ở nhà hoặc xa sân)
* **I want to** quét mã QR hoặc bấm vào link public và xem kết quả, bracket, match queue thời gian thực
* **So that** tôi nắm được tiến độ giải đấu mà không cần cài App và tạo tài khoản rườm rà.
* **Acceptance Criteria:**
  - Link public truy cập được qua Web/Mobile browser.
  - Dữ liệu Auto-refresh hoặc sync realtime nhờ WebSocket.
  - Hiển thị đầy đủ Lịch thi đấu, tiến độ nhánh đấu.

**US-C02: Đăng ký Follow giải đấu**
* **As a** Viewer/VĐV
* **I want to** bấm nút "Follow Giải Đấu" trên giao diện link public (yêu cầu tạo tài khoản nhanh / đăng nhập để dùng App)
* **So that** tôi có thể nhận thông báo đẩy (Push Notification) mỗi khi có diễn biến mới trong giải.
* **Acceptance Criteria:**
  - Nhập app/đăng nhập thành công để liên kết Device Token với tài khoản.
  - Nhấn "Follow" → Đăng ký nhận Pub/Sub Topic của giải đấu.

**US-C03: Nhận thông báo Trận Bắt Đầu (Trigger 1)**
* **As a** Follower (VĐV chuẩn bị hoặc khán giả)
* **I want to** nhận Push Notification ngay khi trận đấu bắt đầu (điểm số đầu tiên được nhập)
* **So that** nếu tôi là VĐV tôi biết mình chuẩn bị phải ra sân (phải sẵn sàng), hoặc tôi vào xem trực tiếp giải.
* **Acceptance Criteria:**
  - Gửi tự động khi Trận đấu chuyển sang `IN_PROGRESS`.
  - Nội dung Noti: "Trận [Số thứ tự]: [Đội A] vs [Đội B] vừa bắt đầu!".
  - Idempotent: Mỗi trận đấu chỉ bắn Trigger 1 đúng 1 lần duy nhất dù Undo kết quả sau đó.

**US-C04: Nhận thông báo Sắp Kết Thúc Trận (Trigger 2)**
* **As a** Follower (VĐV trận tiếp theo)
* **I want to** nhận được Push Notification khi trận đang đánh bước vào những điểm số cuối cùng ở Set quyết định
* **So that** tôi có thể bước ra cửa sân khởi động, sẵn sàng thay ca.
* **Acceptance Criteria:**
  - Chỉ tính ở Set Quyết Định (Ví dụ: Set 3 của Best of 3, hoặc Set 1 của loại 1 set chạm 21).
  - Vạch kích hoạt (Threshold) configurable theo form quy định (ví dụ: đạt 18/21 điểm hoặc 28/31 điểm).
  - Nội dung Noti: "Set quyết định Trận [Số thứ tự] đã đến điểm 18! Các tay vợt trận tiếp theo vui lòng chuẩn bị."
  - Idempotent: Chỉ bắn 1 lần khi lên điểm 18, không bắn thêm khi lên 19 hay nếu điểm bị gỡ về 17 rồi lên lại 18.
