# PRFAQ – SaaS tổ chức giải cầu lông CLB

> **Phiên bản:** 2.0 | Cập nhật lần cuối: 2026-04-08
> **Changelog:** Cập nhật dựa trên brainstorming session. Bổ sung 2-Tier Admin/Referee System và Smart Notification vào MVP scope. Điều chỉnh Out-of-scope tương ứng.

---

## Press Release (viết như sản phẩm đã launch)

**FOR IMMEDIATE RELEASE**

### Giới thiệu *[Working name]* – Ứng dụng giúp CLB thiết lập và lên lịch giải cầu lông trong 30 phút thay vì cả buổi loay hoay với Excel

Hà Nội – Hôm nay chúng tôi giới thiệu *[Working name]*, ứng dụng iOS giúp ban tổ chức CLB cầu lông tạo và vận hành giải đấu nhỏ (8–32 đội) nhanh chóng, chính xác và chuyên nghiệp.

Việc tổ chức giải cầu lông cấp CLB hiện nay vẫn phụ thuộc vào Excel, giấy bút và rất nhiều thao tác thủ công. Ban tổ chức phải tự bốc thăm, xếp lịch, gọi trận, nhập điểm và cập nhật kết quả. Sai sót xảy ra thường xuyên và gây áp lực lớn trong ngày thi đấu — đặc biệt khi giải có từ 3 sân trở lên.

*[Working name]* giải quyết vấn đề này bằng cách tự động hóa toàn bộ quy trình:

* Tạo bracket trong vài giây
* Tự động sinh danh sách gọi trận (Match Queue) thông minh để trống sân nào gọi trận đó
* Nhập điểm trận đấu cực nhanh trên điện thoại — hỗ trợ nhiều trọng tài đồng thời
* Tự động cập nhật kết quả và nhánh đấu
* Thông báo thông minh để VĐV tự biết khi nào chuẩn bị vào sân
* Chia sẻ link public để VĐV theo dõi realtime

Với *[Working name]*, một giải cầu lông CLB có thể được tạo và vận hành hoàn chỉnh chỉ bằng điện thoại — dù có 1 hay nhiều trọng tài hỗ trợ.

**Khách hàng mục tiêu**

* CLB cầu lông phong trào
* Trung tâm cầu lông
* Ban tổ chức giải cuối tuần

**Tình trạng**
Phiên bản đầu tiên hiện đang được thử nghiệm tại các CLB tại Việt Nam.

---

# FAQ – Internal (để định hướng product)

## 1. Customer problem

### BTC đang làm gì today?

Quy trình phổ biến hiện tại:

1. Thu danh sách đăng ký (Excel / Google Sheet)
2. Bốc thăm thủ công
3. Vẽ bracket bằng tay hoặc Excel
4. In giấy / gửi ảnh qua group chat
5. Gọi trận thủ công
6. Nhập điểm → cập nhật lại bracket thủ công

### Pain lớn nhất

* Khó để cho tất cả mọi người cùng biết được kết quả các trận đấu.
* Khó khăn trong việc lưu lại lịch sử thi đấu cho mọi người một cách dễ dàng, tiện lợi.
* Mất công trong việc sắp xếp các trận đấu.
* Mất công làm thủ công trong việc regenerate bracket khi có thay đổi phút chót.
* Vận động viên bất tiện trong việc theo dõi kết quả và lịch thi đấu.

👉 Ngày thi đấu = stress cực cao cho BTC.

---

## 2. Target user

### Primary user (payer)

Ban tổ chức CLB cầu lông nhỏ
Quy mô giải: 8–32 đội

Đặc điểm:

* Không chuyên IT
* Tổ chức giải 1–2 lần/tháng
* Làm vì đam mê → rất thiếu tool

### Secondary user (operator)

Trọng tài tại sân (Referee)
Được admin mời vào giải. Trọng tài tự chọn sân để chấm điểm sau khi đã được phân công bằng miệng.

### Tertiary user (viewer)

VĐV, khán giả và bất kỳ ai quan tâm đến giải đấu.
Có thể **follow giải** để nhận notification thời gian thực (khi trận bắt đầu, khi trận sắp kết thúc). Xem tất cả thông tin giải đấu: lịch thi đấu, kết quả, bracket, bảng xếp hạng qua link public —> đến màn hình cài app, xem mà không cần đăng nhập.

---

## 3. Job to be done

"When I organize a club tournament,
I want to run the whole tournament from my phone,
so that I don't feel stressed on tournament day."

---

## 4. MVP scope (what must be true)

Người dùng có thể:

1. **Tạo giải:** Tất cả các thông tin cơ bản của giải đấu: tên giải, ngày bắt đầu, kết thúc thi đấu, địa điểm thi đấu, logo( tùy chọn, để in trên áo thi đấu, cúp, huy chương), banner( tùy chọn, hiển thị background cho giải đấu), mô tả giải.

2. **Tạo các nội dung thi đấu:** Tất cả các nội dung thi đấu có chung 1 luật hoặc các nội dung thi đấu có luật điểm riêng (mặc định là đánh 1 Set (set x chạm y, mặc định là set 25 chạm 31. Nếu x=y thì gọi luật là "chạm x không hỏi" ) hoặc Best of 3 (set x chạm y, mặc định là set 21 chạm 31)). Ở các vòng tứ kết, bán kết, chung kết có thể thay đổi luật khác nhau để trận đấu diễn ra hấp dẫn hơn, chủ yếu vẫn là 1 set (chạm 25 hoặc 31). Luật điểm hiển thị trực tiếp trên màn hình nhập điểm để BTC/trọng tài không cần nhớ.

3. **Nhập danh sách cá nhân/đội cực nhanh cho từng nội dung thi đấu:** Hỗ trợ tính năng Paste (dán) nguyên cột danh sách từ Excel/Zalo để hệ thống tự nhận diện, thay vì phải gõ tay từng tên trên điện thoại.

4. **Generate bracket — 3 Template nhanh + Custom Format:**
   - **3 Template tự động (1 click):**
     - Vòng bảng + Loại trực tiếp (Group Stage → Knockout). *(Lưu ý: Ở vòng bảng, hệ thống tự động tính thứ hạng dựa trên hiệu số, NHƯNG quyền quyết định ghép đội nào vào vòng Knockout hoàn toàn do Admin bấm chọn thủ công để xử lý mọi tình huống).*
     - Chỉ đấu Vòng tròn (League / Round Robin)
     - Chỉ Loại trực tiếp (Single Knockout)
   - **Custom Format (kết hợp tự do):** Admin có thể xây dựng format phức tạp hơn bằng cách ghép các đơn vị format cơ bản: `League` + `Group` + `Knockout` theo thứ tự tùy ý. Ví dụ: Group Stage → Round Robin trong bảng → Single Knockout. *(Đây là cách mở rộng tự nhiên không cần thêm logic mới — mỗi "phase" là 1 đơn vị format độc lập.)*

5. **Regenerate bracket khi cần** (ví dụ: có đội bỏ thi đấu phút chót).

6. **Nhập điểm trận linh hoạt:**
   - **Interactive mode:** Nhấn [+]/[-] từng điểm theo pha bóng thực tế (nút [+] lớn gấp 3-4 lần nút [-] để tránh fat-finger).
   - **Quick result mode:** Gõ nhanh kết quả cuối cùng sau trận.
   - Có nudge nhắc nhở nếu điểm chưa đạt điều kiện thắng khi bấm Confirm.
   - Có 60-second Undo Window sau mỗi lần confirm kết quả.

7. **Tự động cập nhật Match Queue thông minh:** Dựa vào sơ đồ Bracket, hệ thống tự động cập nhật danh sách các trận đấu theo thứ tự được đánh số. Có thể thay đổi thứ tự các trận đấu bằng 2 cách: kéo thả hoặc khi trọng tài chọn 1 trận đấu là trận đấu tiếp theo thì đẩy trận đó lên bên trên tất cả những trận chưa bắt đầu (để linh hoạt đẩy lùi các trận đấu mà VĐV đang bận sân khác hoặc cần nghỉ mệt).

8. **Xử lý tình huống đặc biệt:**
   - Walkover UI: 1 nút kết thúc trận ngay với trạng thái "Vắng mặt", không cần nhập điểm 21-0.
   - Forfeit Team: Đánh dấu đội rút lui, app tự xử lý các trận liên quan.

9. **Hệ thống Admin và Trọng tài (2-Tier Role System):**
    - **Admin (BTC):** Toàn quyền — cấu hình giải, generate bracket, quản lý match queue, skip/move trận, thêm/xóa trọng tài, override bất kỳ điểm nào.
    - **Referee (Trọng tài):** Có tài khoản sẵn. Admin tìm referee bằng **email, số điện thoại, hoặc username** và add vào giải. Referee tự chọn trận để chấm điểm, **có thể cầm nhiều trận cùng lúc**. Không thể sửa bracket hay quản lý match queue.
    - **Không có Screen Lock:** Cho phép nhiều trọng tài cùng nhập điểm 1 trận — last-write-wins, conflict do BTC tự xử lý trên sân. Nhiều referee cùng xem màn hình scoring của 1 trận đều thấy điểm cập nhật real-time qua WebSocket.
    - **Admin Referee Dashboard:** Admin thấy được referee nào đang active ở trận nào. Một referee được coi là "đang active" ở trận X khi có ít nhất 1 score update trong trận X trong vòng N phút gần nhất (N = configurable, gợi ý 5 phút).
    - *(Lý do: Khi giải có 3+ sân, mỗi trọng tài tự di chuyển và cầm bất kỳ trận nào cần — linh hoạt tối đa, không cần phân công cứng nhắc.)*

10. **Smart Match Notification (2 trigger mỗi trận):**
    - **Trigger 1 — Khi trận bắt đầu:** Fire khi **referee nhập điểm đầu tiên** của trận (không cần nút "Bắt đầu" riêng). Notification kèm số thứ tự trận và tên đầy đủ 2 cặp đấu, gửi đến tất cả follower của giải.
    - **Trigger 2 — Khi trận gần kết thúc:** Fire khi một đội đạt ngưỡng điểm ở **set quyết định**, cảnh báo follower chuẩn bị. Ngưỡng theo từng format:
      - 1 Set 21: khi 1 đội đạt 18 điểm
      - 1 Set 31 (chạm): khi 1 đội đạt 28 điểm
      - Best of 3: **chỉ fire ở set quyết định** (set 3, hoặc set 2 nếu một đội đã thắng set 1).
    - **Gửi đến tất cả người dùng đã Follow giải** — VĐV, khán giả, và bất kỳ ai quan tâm. Follow giải yêu cầu có tài khoản.
    - **Match Lifecycle:** `PENDING → IN_PROGRESS → DONE`. Không có trạng thái CALLED. Chuyển sang `IN_PROGRESS` khi có điểm đầu tiên → kích hoạt Trigger 1. Chuyển sang `DONE` khi Admin/Referee confirm kết quả → 60s Undo Window.
    - **Hạ tầng:** Score update realtime qua WebSocket. Server evaluate threshold sau mỗi update và dispatch FCM/APNs với idempotency (mỗi trigger chỉ gửi đúng 1 lần/trận).

11. **Resilience khi mạng chập chờn:**
    - Optimistic Local Commit: Điểm được lưu local ngay lập tức, sync server sau.
    - "Saved Locally" Toast: Hiện banner thông báo khi offline, biến mất khi sync xong.
    - *Không có full offline-first (out-of-scope), nhưng điểm số không bao giờ bị mất.*
    - Có file excel lưu trữ tất cả các trận đấu và kết quả được export ra local của điện thoại mỗi 1 phút để đề phòng trường hợp mất mạng.


12. **Share link public** theo dõi giải thời gian thực (kèm QR code để chiếu hoặc in tại nhà thi đấu).

Nếu thiếu 1 trong các mục **1–10** → MVP fail.

---

## 5. Out of scope (cố tình chưa làm)

* Không cần quan tâm đến số sân hay số hiệu sân — chỉ quan tâm đến thứ tự trận đấu.
* Thanh toán
* Ranking / stats cá nhân VĐV (Player Profile)
* In-App Chat / Comment *(→ Deferred V2+; hiện tại CLB dùng Zalo)*
* Offline mode toàn diện *(Cache điểm số local là đủ — xem mục 12)*
* Sponsor / branding nâng cao
* Check-in VĐV
* Court Management UI *(BTC nhìn sân bằng mắt — app không cần biết sân số mấy)*

Lý do: không cần để chạy giải đầu tiên.

---

## 6. Success metrics (demo stage)

Sau 1–2 tháng:

* Chạy được ≥ 3 giải thật bằng app
* BTC không quay lại Excel
* BTC sẵn sàng trả tiền khi có subscription

Metric quan trọng nhất:
👉 *"Chúng tôi không muốn quay lại cách cũ."*

---

## 7. Biggest risks

1. **Bracket + scheduling đủ tốt chưa?** — Đặc biệt ở bước Semi-Auto Bracket Slotting (vòng Knockout cần BTC confirm thủ công).
2. **Nhập điểm có đủ nhanh và ít sai sót không?** — Fat-finger, nhập nhầm kết quả, bracket bị sai.
3. **BTC có tin tưởng dùng trong ngày thi đấu thật không?** — Dry Run Mode là tính năng quan trọng để phá rở rào cản tâm lý lần đầu adopt.
4. **Hạ tầng mạng:** Sóng 4G tại các nhà thi đấu mái tôn thường rất kém. Optimistic Local Commit + "Saved Locally" Toast là giải pháp, cần test kỹ ở điều kiện mạng kém.
5. **2-Tier Role System complexity:** Multi-user real-time với ownership lock có thể phức tạp hơn ước tính. Cần architecture review sớm trước khi code.
6. **Notification onboarding friction:** VĐV cần cài app và bật notification → cần onboarding flow riêng nhẹ nhàng cho VĐV (không phải BTC).

---

## 8. Future vision (sau MVP)

* Tournament OS cho CLB cầu lông
* Payment & registration
* Ranking CLB và stats cá nhân VĐV
* Filter giải đấu theo thời gian, số lượng vận động viên, loại nội dung, địa điểm
* In-App Chat / Comment
* Multi-club ecosystem
* Marketplace dịch vụ tổ chức giải
* Sponsor / branding nâng cao

---

*Bước tiếp theo: Chuyển sang **Product Requirements Document (PRD)** chi tiết + User Flows.*
*Lưu ý: 2-Tier Role System và Smart Notification cần được architecture review trước khi viết user stories.*
