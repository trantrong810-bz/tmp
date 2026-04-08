 8cos Tuyệt. Với stage hiện tại, **PRFAQ** rất hợp để “đóng băng vision” trước khi viết requirements.

Mình sẽ viết theo format startup chuẩn (Amazon style) nhưng tối giản cho MVP.

---

# PRFAQ – SaaS tổ chức giải cầu lông CLB

## Press Release (viết như sản phẩm đã launch)

**FOR IMMEDIATE RELEASE**

### Giới thiệu *[Working name]* – Ứng dụng giúp CLB thiết lập và lên lịch giải cầu lông trong 30 phút thay vì cả buổi loay hoay với Excel

Hà Nội – Hôm nay chúng tôi giới thiệu *[Working name]*, ứng dụng iOS giúp ban tổ chức CLB cầu lông tạo và vận hành giải đấu nhỏ (8–32 đội) nhanh chóng, chính xác và chuyên nghiệp.

Việc tổ chức giải cầu lông cấp CLB hiện nay vẫn phụ thuộc vào Excel, giấy bút và rất nhiều thao tác thủ công. Ban tổ chức phải tự bốc thăm, xếp lịch, gọi trận, nhập điểm và cập nhật kết quả. Sai sót xảy ra thường xuyên và gây áp lực lớn trong ngày thi đấu.

*[Working name]* giải quyết vấn đề này bằng cách tự động hóa toàn bộ quy trình:

* Tạo bracket trong vài giây
* Tự động sinh danh sách gọi trận (Match Queue) thông minh để trống sân nào gọi trận đó
* Nhập điểm trận đấu cực nhanh trên điện thoại
* Tự động cập nhật kết quả và nhánh đấu
* Chia sẻ link public để VĐV theo dõi realtime

Với *[Working name]*, một giải cầu lông CLB có thể được tạo và vận hành hoàn chỉnh chỉ bằng điện thoại.

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

* Sai sót khi nhập điểm
* Khó sắp xếp thứ tự trận gọi vào sân, dễ gây tình trạng đợi sân quá lâu
* Regenerate bracket khi có thay đổi phút chót rất cực
* Khán giả/VĐV luôn hỏi: “trận tiếp theo là gì?”

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

### Secondary user (viewer)

VĐV và người xem
Chỉ cần xem lịch & kết quả.

---

## 3. Job to be done

“When I organize a club tournament,
I want to run the whole tournament from my phone,
so that I don’t feel stressed on tournament day.”

---

## 4. MVP scope (what must be true)

Người dùng có thể:

1. Tạo giải: Tên giải, ngày thi đấu, logo, banner, mô tả giải.
2. Tạo các nội dung thi đấu: Gắn kèm 2 Preset luật điểm số linh hoạt (Đánh 1 Set hoặc Best of 3).
3. Nhập danh sách cá nhân/đội thi đấu cực nhanh: Hỗ trợ tính năng Paste (dán) nguyên cột danh sách từ Excel/Zalo để hệ thống tự nhận diện, thay vì phải gõ tay từng tên trên điện thoại.
4. Random / manual seeding.
5. Generate bracket với 3 Template tự động (1 click):
   - Vòng bảng + Loại trực tiếp (Group Stage -> Knockout) (Lưu ý: Ở vòng bảng, hệ thống tự động tính Nhất/Nhì dựa trên hiệu số, NHƯNG quyền quyết định ghép đội nào vào vòng Knockout hoàn toàn do Admin bấm chọn thủ công để xử lý mọi tình huống).
   - Chỉ đấu Vòng tròn (League / Round Robin)
   - Chỉ Loại trực tiếp (Single Knockout)
6. Regenerate bracket khi cần (ví dụ: có đội bỏ thi đấu phút chót).
7. Nhập điểm trận linh hoạt: Nhập điểm số thực tế trên sân và tự đánh dấu Đội Thắng (linh hoạt tối đa, tin tưởng Admin).
8. Tự động cập nhật Match Queue thông minh: Kèm theo tính năng "Bỏ qua / Quẹt lùi" (Skip / Move down) để linh hoạt đẩy lùi các trận đấu mà VĐV đang bận sân khác hoặc cần nghỉ mệt. Tự lấp tiếp sơ đồ Bracket.
9. Share link public theo dõi giải thời gian thực.

Nếu thiếu 1 trong các mục trên → MVP fail.

---

## 5. Out of scope (cố tình chưa làm)

* Không cần quan tâm đến số sân, chỉ cần quan tâm đến thứ tự trận đấu.
* Thanh toán
* Notification
* Ranking / stats
* Multi admin
* Offline mode toàn diện (Tuy nhiên, MVP phải thiết kế cơ chế Cache lưu tạm điểm số tại máy nếu mạng 4G chập chờn, khi có mạng tự đẩy lên để tránh văng app).
* Sponsor / branding nâng cao
* Check-in VĐV
* Tournament format phức tạp

Lý do: không cần để chạy giải đầu tiên.

---

## 6. Success metrics (demo stage)

Sau 1–2 tháng:

* Chạy được ≥ 3 giải thật bằng app
* BTC không quay lại Excel
* BTC sẵn sàng trả tiền khi có subscription

Metric quan trọng nhất:
👉 “Chúng tôi không muốn quay lại cách cũ.”

---

## 7. Biggest risks

1. Bracket + scheduling đủ tốt chưa?
2. Nhập điểm có đủ nhanh và ít sai sót không?
3. BTC có tin tưởng dùng trong ngày thi đấu thật không?
4. Hạ tầng mạng: Sóng 4G tại các nhà thi đấu mái tôn thường rất kém, app có rủi ro bị treo hoặc mất dữ liệu khi cập nhật điểm.

---

## 8. Future vision (sau MVP)

* Tournament OS cho CLB cầu lông
* Payment & registration
* Ranking CLB
* Multi-club ecosystem
* Marketplace dịch vụ tổ chức giải

---

Nếu bạn đồng ý PRFAQ này, bước tiếp theo rất hợp lý là:
👉 chuyển sang **Product Requirements (PRD)** chi tiết + user flow.
