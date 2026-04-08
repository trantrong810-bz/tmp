---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7]
session_continued: true
continuation_date: '2026-04-08'
inputDocuments: []
session_topic: 'Chi tiết hóa hành động của BTC khi tạo 1 giải đấu mới'
session_goals: 'Mô tả rõ từng bước thực hiện, thông tin đầu vào, và quyết định BTC cần đưa ra'
selected_approach: 'Progressive Flow + Extended (Failure / Emotional / Anti-Feature)'
techniques_used:
  - 'First Principles Thinking'
  - 'Role Playing'
  - 'Constraint Mapping'
  - 'Decision Tree Mapping'
  - 'Worst Case Scenario Analysis'
  - 'Emotional Journey Mapping'
  - 'Anti-Features Thinking'
ideas_generated: 43
context_file: 'input/PRFAQ-club-badminton-tournament-saas.md'
---

## Session Overview

**Topic:** Chi tiết hóa hành động của BTC khi tạo 1 giải đấu mới
**Goals:** Xác định rõ ràng và chi tiết quy trình, các bước công việc và thao tác mà Ban Tổ Chức cần thực hiện trên ứng dụng MVP khi bắt đầu tạo một giải đấu (tournament).

### Context Guidance

Dựa trên file `PRFAQ-club-badminton-tournament-saas.md`, đây là ứng dụng SaaS thiết kế tối giản nhằm giúp các CLB phong trào thoát khỏi file Excel, vận hành qua điện thoại nhanh chóng. Tính năng "Tạo giải" là bước đầu tiên cực kỳ quan trọng, cần đảm bảo tính tiện dụng cao nhất.

### Session Setup

Phiên brainstorm tập trung vào góc độ trải nghiệm của Ban Tổ Chức (BTC) — từ lúc click chọn đến lúc có được một giải đấu để mọi người theo dõi. Session được mở rộng bằng cách phân tích tình huống tệ nhất, cảm xúc người dùng, và các quyết định "cố tình không làm" để giữ MVP sắc nét.

---

## Technique Selection

**Approach:** Progressive Technique Flow → Extended
**Journey Design:** Systematic development from exploration → action → failure resilience → emotional design → scope discipline

**Techniques:**

- **Phase 1 — Exploration:** First Principles Thinking
- **Phase 2 — Pattern Recognition:** Role Playing
- **Phase 3 — Development:** Constraint Mapping
- **Phase 4 — Action Planning:** Decision Tree Mapping
- **Phase 5 — Resilience:** Worst Case Scenario Analysis
- **Phase 6 — Emotion:** Emotional Journey Mapping
- **Phase 7 — Scope:** Anti-Features Thinking

---

## Technique Execution Results

### Phase 1: First Principles Thinking

**[Category: Scoring] — #1 Đa hình luật điểm (Multi-stage Scoring Rules)**
_Concept:_ Cho phép thiết lập các "profile" điểm số khác nhau cho từng giai đoạn của cùng một nội dung (ví dụ: Vòng bảng đánh 1 set 21, Bán kết đánh chạm 31).
_Novelty:_ Giải quyết việc BTC phải nhớ và nhắc VĐV về luật đổi giữa chừng — điều thường gây cãi vã ở các giải phong trào.

**[Category: Logistics] — #2 Hàng đợi gọi trận thông minh (Smart Match Queueing)**
_Concept:_ Hệ thống tự động đẩy thứ tự trận đấu dựa trên sơ đồ nhánh nhưng cho phép BTC "Skip/Move Down" linh hoạt như danh sách phát nhạc.
_Novelty:_ Thay vì BTC phải nhìn chằm chằm vào bảng Excel để tìm trận tiếp theo, app "định tuyến" sẵn, BTC chỉ việc chọn sân.

**[Category: Flexibility] — #3 Tùy biến nhánh đấu tức thì (On-the-fly Bracket Logic)**
_Concept:_ Cho phép chọn nhanh logic chuyển tiếp giữa các vòng (X đứng nhất bảng A gặp Y đứng nhì bảng B) hoặc số đội được đi tiếp ngay tại thời điểm generate.
_Novelty:_ Loại bỏ việc BTC phải vẽ lại sơ đồ tay khi giải đấu bị giới hạn thời gian (ví dụ: từ lấy 2 đội mỗi bảng xuống chỉ lấy 1 đội nhanh nhất).

---

### Phase 2: Role Playing (Cơn bão 8h sáng)

**[Category: Error Handling] — #4 Action "Xử thua" (Walkover UI)**
_Concept:_ Một nút bấm đặc biệt cho phép kết thúc trận đấu ngay lập tức với trạng thái "Vắng mặt" (Walkover), tự động đẩy đội còn lại vào vòng trong mà không cần nhập điểm 21-0 thủ công.
_Novelty:_ Tiết kiệm từng giây cho BTC khi đang phải xử lý áp lực tại sân.

**[Category: Decoupling] — #5 Tách biệt Quản lý sân (Court Decoupling)**
_Concept:_ App hoàn toàn không cần biết có bao nhiêu sân hay sân số mấy. App chỉ cung cấp "Trận đấu tiếp theo". BTC tự nhìn sân trống và gọi tên VĐV.
_Novelty:_ Giảm 100% gánh nặng cấu hình sân (Court setup) cho BTC. App cực kỳ linh hoạt kể cả khi sân bị hỏng giữa chừng.

---

### Phase 3: Constraint Mapping (Ranh giới Tự động vs Thủ công)

**[Category: UI/UX] — #6 High-Confidence Scoring UI (Giao diện nhập điểm tự tin)**
_Concept:_ Thiết kế nút **[+]** có diện tích lớn gấp 3-4 lần nút **[-]**. Số điểm hiển thị ở vị trí trung tâm, không bị ngón tay che khuất khi bấm.
_Novelty:_ Giảm thiểu tối đa lỗi nhập liệu (fat-finger) trong môi trường nhà thi đấu ồn ào và gấp gáp.

**[Category: Context] — #7 Subtle Rule Guidance (Nhắc luật tinh tế)**
_Concept:_ Hiển thị luật điểm (VD: "Đánh 1 set 21, chạm 25") bằng chữ nhỏ, nghiêng, màu đỏ ở dưới cùng màn hình nhập điểm. Thêm thông báo nhắc nhở (nudge) khi BTC nhấn "Finish" hoặc "Exit" mà điểm số chưa đạt điều kiện thắng cuộc.
_Novelty:_ Đảm bảo BTC luôn đúng luật mà không cần phải nhớ máy móc, app đóng vai trò là "người giám sát" thầm lặng.

**[Category: Logic] — #8 Semi-Auto Bracket Slotting (Ghép cặp bán tự động)**
_Concept:_ App tự tính toán thứ hạng bảng (hiệu số, đối đầu), nhưng ở vòng Knockout, app hiện danh sách gợi ý và BTC phải nhấn "Confirm" hoặc "Select Team" cho từng ô trống.
_Novelty:_ Đảm bảo 100% sự linh hoạt cho BTC để xử lý các vấn đề nội bộ hoặc thay đổi phút chót mà thuật toán không lường hết.

**[Category: Data Management] — #9 Roster Elasticity (Độ co giãn danh sách)**
_Concept:_ Cho phép sửa đổi tên VĐV hoặc thay thế đội kể cả khi giải đấu đã bắt đầu và sơ đồ nhánh đã được tạo.
_Novelty:_ Chấp nhận sự "hỗn loạn" của giải phong trào, app không cứng nhắc khóa dữ liệu, giúp BTC không phải tạo lại giải từ đầu.

---

### Phase 4: Decision Tree Mapping (Luồng quyết định vận hành)

**[Category: Workflow] — #10 Atomic Event-first Registry (Nhập nội dung trước, VĐV sau)**
_Concept:_ BTC tạo các nội dung (Đôi TB, Đôi TBY...) trước, sau đó nạp danh sách VĐV trực tiếp vào từng nội dung đó.
_Novelty:_ Phản ánh đúng thực tế BTC thường nhận hoặc chia sẵn danh sách VĐV theo từng nhóm trình độ.

**[Category: Architecture] — #11 Hybrid Scoring Entry (Nhập liệu lai)**
_Concept:_ Cho phép BTC chọn lựa giữa việc nhấn cộng/trừ từng điểm (Interactive) hoặc gõ nhanh kết quả cuối cùng (Quick result entry) trong cùng một màn hình.
_Novelty:_ Phục vụ cả hai tình huống: BTC đứng tại sân theo dõi từng pha bóng HOẶC BTC chỉ nhận kết quả từ trọng tài sau trận.

**[Category: Automation] — #12 One-Click Manifest (Nút sinh giải "Tất cả trong một")**
_Concept:_ Chốt thông tin từ format chuẩn (giống Excel), nhấn 1 nút duy nhất để sinh ra toàn bộ Bracket, Match Queue và có thể bắt đầu tính điểm ngay lập tức.
_Novelty:_ Thời gian từ lúc "Mở app" đến lúc "Gọi trận đầu tiên" là ngắn nhất có thể.

**[Category: Policy Enforcement] — #13 Đóng băng đăng ký (Registration Freeze)**
_Concept:_ Sau khi đã Generate Bracket, app mặc định không cho phép sửa đổi danh sách VĐV ở màn hình vận hành (chỉ xử lý thắng/thua). Tuy nhiên có hidden override cho admin.
_Novelty:_ Giữ tính toàn vẹn dữ liệu và tránh lỗi logic tính toán khi đang chạy giải.

**[Category: UX] — #14 Paste-to-Register (Dán danh sách từ Excel/Zalo)**
_Concept:_ Hỗ trợ tính năng Paste nguyên cột danh sách từ Excel/Zalo, hệ thống tự nhận diện từng dòng là 1 VĐV/đội mà không cần gõ tay.
_Novelty:_ BTC không cần gõ tay từng tên trên điện thoại — thao tác copy-paste quen thuộc là đủ.

**[Category: Sharing] — #15 Public Realtime Link**
_Concept:_ Share link public để VĐV theo dõi kết quả và bracket realtime mà không cần cài app.
_Novelty:_ VĐV/khán giả tự tra cứu thông tin mà không cần hỏi BTC liên tục.

---

### Phase 5: Worst Case Scenario Analysis

**[Category: Resilience] — #16 Optimistic Local Commit**
_Concept:_ Khi BTC bấm "Confirm Score", app lưu ngay vào local storage trước rồi mới sync lên server sau. UI hiển thị badge nhỏ "⏳ Đang đồng bộ..." thay vì spinner blocking. BTC vẫn tiếp tục vận hành bình thường.
_Novelty:_ App không bao giờ "đứng hình" vì mạng. BTC luôn nhìn thấy trạng thái đúng nhất mà mình biết — dù offline.

**[Category: Trust Signal] — #17 "Saved Locally" Toast**
_Concept:_ Ngay khi offline được phát hiện, app hiện banner vàng nhẹ: "Không có mạng — điểm đã lưu tạm trên máy. Sẽ tự đồng bộ khi có mạng." Biến mất khi sync xong.
_Novelty:_ Xóa đi nỗi sợ lớn nhất của BTC — "Mất điểm rồi!". Đây là tính năng tâm lý quan trọng hơn là tính năng kỹ thuật.

**[Category: Error Recovery] — #18 60-Second Undo Window**
_Concept:_ Sau khi confirm kết quả trận, app hiện snackbar: "Xác nhận: [Đội A] thắng 21–15. [Hoàn tác] (55s)". Trong 60 giây, BTC có thể undo toàn bộ — bracket roll back, trận trở về trạng thái "đang đấu".
_Novelty:_ 60 giây đủ để BTC nhận ra lỗi (thường phát hiện ngay khi thấy sơ đồ bracket nhảy sai), nhưng đủ ngắn để không tạo cảm giác "bất ổn định".

**[Category: Error Recovery] — #19 Admin Force Override (Hidden)**
_Concept:_ Nút "Sửa kết quả trận đã kết thúc" tồn tại nhưng bị ẩn (cần tap 3 lần vào tên trận hoặc qua menu ⋮ > "Chỉnh sửa nâng cao"). Khi sửa, app cảnh báo rõ: "Thay đổi này sẽ ảnh hưởng đến [N] trận phía sau. Bạn chắc chắn?" và yêu cầu confirm lần 2.
_Novelty:_ Giải quyết 100% trường hợp thực tế mà không làm phức tạp UX bình thường. Hidden = tránh bấm nhầm, nhưng vẫn CÓ THỂ làm khi thực sự cần.

**[Category: Lifecycle] — #20 "Rút lui" (Forfeit Team) Action**
_Concept:_ BTC vào trang danh sách đội → chọn đội → "Đánh dấu Rút lui". App tự động xử lý: trận đã đấu giữ nguyên, trận chưa đấu tự Walkover cho đội kia, tính lại bảng xếp hạng.
_Novelty:_ Theo chuẩn giải chuyên nghiệp nhưng đơn giản hóa thành 2 bước cho BTC phong trào.

**[Category: Communication] — #21 Phantom Team Indicator**
_Concept:_ Đội rút lui vẫn hiện trong bracket nhưng bị gạch chéo (❌) và tô xám. Người xem qua public link thấy lịch sử trận nhưng biết đội đó đã rút. Không bị xóa trắng khỏi lịch sử.
_Novelty:_ Giữ tính minh bạch — không ai thắc mắc "đội X đâu rồi?"

**[Category: Concurrency] — #22 Screen Lock khi Scoring**
_Concept:_ Khi một admin/referee mở màn hình scoring của 1 trận, trận đó chuyển sang trạng thái "🔒 Đang nhập bởi [tên]". Người khác cố vào cùng trận thấy thông báo "Đang được cập nhật. Xin chờ."
_Novelty:_ Giải quyết race condition mà không cần build multi-user system phức tạp. Ownership model đơn giản và trực quan.

**[Category: Simplicity] — #23 Single Session Design (Constraint-as-Feature)**
_Concept:_ Với giải nhỏ (dưới 3 sân), 1 admin cầm 1 điện thoại là đủ. Tài liệu onboarding ghi rõ: "Mô hình 1 admin cho giải nhỏ". Không over-engineer khi không cần.
_Novelty:_ Đơn giản là selling point — không phải limitation. BTC phong trào cần sự đơn giản trước tiên.

---

### Phase 6: Emotional Journey Mapping

#### T-3 ngày: Chuẩn bị giải (Cảm xúc: lo lắng, không chắc)

**[Category: Confidence Building] — #24 Readiness Checklist "Giải sẵn sàng chưa?"**
_Concept:_ Trước ngày thi đấu, app chủ động hiện Readiness Checklist ngay trên dashboard: "✅ Đã có 16 đội · ✅ Bracket đã generate · ⚠️ Chưa set luật điểm cho Nội dung 2". BTC nhìn một cái biết ngay cần làm gì tiếp.
_Novelty:_ Chuyển lo lắng mơ hồ thành hành động cụ thể. App đóng vai "trợ lý nhắc việc" thay vì chỉ là công cụ nhập liệu.

**[Category: Trust] — #25 Dry Run Mode**
_Concept:_ Cho phép BTC chạy thử giải (simulate) — gọi trận ảo, nhập điểm ảo — để test toàn bộ flow mà không ảnh hưởng dữ liệu thật. Kết thúc dry run → app reset về trạng thái ban đầu.
_Novelty:_ BTC lần đầu dùng app không dám dùng trong giải thật vì sợ làm hỏng. Dry Run phá vỡ rào cản tâm lý lớn nhất khi adopt tool mới.

#### T-60 phút: Tại nhà thi đấu, setup (Cảm xúc: bận rộn, bị ngắt liên tục)

**[Category: Focus] — #26 "Giải đang chạy" Full-Screen Mode**
_Concept:_ Khi BTC bấm "Bắt đầu giải", app chuyển sang giao diện tối giản toàn màn hình: chỉ hiện "Trận tiếp theo" + nút "Gọi trận" + "Nhập điểm". Không có menu, settings, hay bất kỳ thứ gì gây phân tán.
_Novelty:_ Giống chế độ "Do Not Disturb" nhưng cho UI. BTC đang trong trạng thái cognitive overload — app cần thu hẹp lựa chọn, không mở rộng.

**[Category: Speed] — #27 Zero-Tap Match Calling**
_Concept:_ Màn hình vận hành chỉ có 1 hành động chính: "Gọi trận này" (full-width button, màu sặc sỡ). Không cần chọn sân, không cần confirm thêm. 1 tap = trận được gọi = hàng đợi tự cập nhật.
_Novelty:_ Khi BTC đang vừa nói chuyện với VĐV vừa nhìn app, cần thao tác nhanh nhất có thể. Mỗi bước thêm = mỗi cơ hội nhầm lẫn thêm.

#### Giờ cao điểm: Giải đang chạy (Cảm xúc: áp lực cao, nhiều người hỏi cùng lúc)

**[Category: Delegation] — #28 Public Display QR Code**
_Concept:_ App tạo sẵn 1 QR code dẫn đến trang public realtime. BTC in ra hoặc chiếu lên màn hình lớn. VĐV/khán giả tự xem lịch, không cần hỏi BTC nữa.
_Novelty:_ Giảm 80% interrupt cho BTC. Câu trả lời cho mọi câu hỏi "trận tiếp theo là gì?" = chỉ tay vào QR. Đây là tính năng giảm stress BTC quan trọng nhất.

**[Category: Clarity] — #29 "Ai đang ở sân?" At-a-Glance Strip**
_Concept:_ Màn hình vận hành có một dải thông tin nhỏ phía trên: "🏸 Đang đấu: [Đội A] vs [Đội B]". BTC nhìn lẹ biết ngay sân đang có ai — không cần nhớ hay hỏi trọng tài.
_Novelty:_ App trở thành "bộ nhớ ngoài" cho BTC trong lúc đầu óc đang xử lý 5 thứ cùng lúc.

**[Category: Confidence] — #30 Score Sanity Check (Gentle Nudge)**
_Concept:_ Khi BTC nhập điểm và toan bấm Confirm, app instant-validate: nếu điểm số trông "lạ" (VD: 21-1, hoặc cả hai đội 0-0), app hiện gentle nudge: "Điểm [21–1] trông có vẻ ít điểm cho đội B — bạn có muốn kiểm tra lại không?" Không block, chỉ nhắc.
_Novelty:_ Phân biệt với hard validation. App tin tưởng BTC nhưng vẫn đóng vai người nhắc nhở thông minh.

#### Cuối giải: Trao giải (Cảm xúc: kiệt sức nhưng nhẹ nhõm)

**[Category: Celebration] — #31 Tournament Summary Card (Shareable)**
_Concept:_ Khi trận chung kết kết thúc, app tự động generate một "Kết quả giải" đẹp (Champion, Runner-up) dưới dạng card có thể chụp màn hình và share luôn lên Zalo group.
_Novelty:_ Việc cuối cùng BTC làm = share kết quả cho cả CLB. App làm luôn bước này, BTC chỉ cần 1 tap. Khoảnh khắc "chiến thắng" của BTC — cảm giác chuyên nghiệp, xứng đáng.

**[Category: Retention] — #32 Tournament History Report**
_Concept:_ Sau khi giải kết thúc, app lưu trữ toàn bộ và cung cấp trang summary đơn giản: tổng số trận, số đội, thời gian giải kéo dài. BTC có thể xem lại bất kỳ lúc nào.
_Novelty:_ Tạo "digital memory" cho CLB. Lần sau tổ chức giải, BTC có dữ liệu so sánh. Hook để BTC quay lại dùng app cho lần sau.

#### T+1 tuần: Sau giải (Cảm xúc: bắt đầu nghĩ đến giải tiếp theo)

**[Category: Advocacy] — #33 "Dùng lại giải này" Template**
_Concept:_ Khi tạo giải mới, app gợi ý: "Bạn có muốn sao chép cấu trúc từ [Giải tháng 3] không? (Danh sách nội dung, luật điểm, số đội)". BTC chỉ cần cập nhật danh sách VĐV mới.
_Novelty:_ CLB thường tổ chức cùng format hàng tháng. Tính năng giữ chân mạnh nhất — càng dùng nhiều, việc bỏ app đi càng tốn công hơn (switching cost tự nhiên).

---

### Phase 7: Anti-Features Thinking (Quyết định "Cố tình KHÔNG làm")

**[Anti-Feature] — #34 ❌ Không có Court Management (Quản lý sân)**
_Lý do:_ BTC phong trào nhìn thấy sân bằng mắt — app không cần "biết" thứ mà BTC đã thấy trực tiếp. Mỗi sân thêm vào = thêm bước cấu hình, thêm khả năng nhầm. Khi sân hỏng bất ngờ, app không cần update.
_Value Statement:_ "App của chúng tôi không quản lý sân — vì BTC thông minh hơn bất kỳ thuật toán phân sân nào. Chúng tôi tin tưởng BTC."

**[Feature — Revised] — #35 ✅ Smart 2-Trigger Match Notification**
_Concept:_ Mỗi trận đấu kích hoạt đúng 2 notification:
- **Trigger 1 — Khi trận BẮT ĐẦU:** "🏸 Trận #7 đang diễn ra: Hùng Béo / Linh Vịt vs An Đen / Tuấn Còm" → VĐV trận #8 biết còn 1 trận nữa.
- **Trigger 2 — Khi trận GẦN KẾT THÚC** (một đội đạt 18/21 hoặc 28/31): "⚡ Trận #7 sắp xong — Trận #8 chuẩn bị vào sân!"

Nội dung: **Số thứ tự trận + Tên đầy đủ 2 cặp đấu**. Gửi cho 4 VĐV của trận tiếp theo.
_Novelty:_ Notification không phải để BTC tiện — mà để VĐV tự điều phối. BTC nói ít hơn, VĐV chủ động hơn. Giảm tình trạng sân trống chờ người.
_PRD Implications:_ VĐV cần cài app và bật notification. Threshold "gần kết thúc" phải configurable theo từng loại luật. Cần onboarding flow riêng cho VĐV.

**[Anti-Feature] — #36 ❌ Không có Player Profile / Stats cá nhân**
_Lý do:_ BTC nhập tên nick ("Hùng Béo", "Linh Vịt") — không chuẩn hóa được. Player stats đòi hỏi consistent identity qua nhiều giải — quá phức tạp cho MVP.
_Value Statement:_ "Chúng tôi không lưu hồ sơ VĐV — vì mọi người trong CLB đã biết nhau. App không cần làm thứ mà cộng đồng đã tự làm tốt hơn."

**[Anti-Feature] — #37 ❌ Không có Tournament Template Marketplace**
_Lý do:_ 3 template cứng (Group+KO, Round Robin, Single KO) cover 95% giải phong trào. Marketplace = content moderation = support burden.
_Value Statement:_ "Ba template, không hơn. Vì complexity là kẻ thù của tốc độ — và tốc độ là thứ BTC cần nhất lúc 8 giờ sáng."

**[Deferred Feature] — #38 🔜 In-App Chat / Comment → V2+**
_Lý do:_ Mọi CLB đã có Zalo group. Trong MVP, tập trung vào thứ Zalo không làm được: quản lý bracket real-time.
_Value Statement:_ "Chúng tôi không có chat — vì Zalo của bạn đã làm việc đó tốt hơn chúng tôi."
_Roadmap:_ Phát triển trong tương lai khi có đủ user base để justify.

**[Anti-Feature] — #39 ❌ Không có Full Offline-First toàn diện**
_Lý do:_ Full offline = conflict resolution phức tạp khi 2 thiết bị có data khác nhau. Nhà thi đấu có 4G là đủ nếu app nhẹ. Cache scoring offline (Optimistic Local Commit — #16) là đủ.
_Value Statement:_ "App cần mạng — nhưng điểm số không bao giờ bị mất dù mạng chập chờn. Đó là cam kết thực tế, không phải cam kết marketing."

**[Feature — Revised] — #40 ✅ 2-Tier Admin/Referee Role System**
_Concept:_
- **Tầng 1 — Admin (BTC):** Toàn quyền — cấu hình giải, generate bracket, quản lý match queue, skip/move trận, invite trọng tài, override bất kỳ điểm nào.
- **Tầng 2 — Referee (Trọng tài):** Chỉ nhập điểm cho sân được phân công, có thể mời thêm trọng tài khác. Không thể sửa bracket, không thể xem cấu hình giải, không thể skip match queue.

_Lý do thực tế:_ Khi giải có 3+ sân, sân ồn ào, admin không thể chạy cập nhật điểm tất cả. Trọng tài tại sân cầm điện thoại riêng, nhập điểm real-time.
_Novelty:_ Không phải multi-admin đối xứng — mà là hierarchy rõ ràng: Admin quản lý tất cả, Referee chỉ chấm điểm.

**[Category: Concurrency] — #41 Per-Court Score Lock (Ownership Model)**
_Concept:_ Khi referee đang nhập điểm cho Trận X, màn hình Admin hiện "🔒 Trận X — Đang chấm bởi [Trọng tài A]". Admin không thể modify, nhưng có thể "Take Over" nếu cần (với confirm prompt).
_Novelty:_ Concurrency được giải quyết bằng ownership model đơn giản thay vì merge conflict phức tạp.

**[Category: Onboarding] — #42 Referee Quick Join (QR/Link)**
_Concept:_ Admin tạo giải xong → app generate 1 QR/link ngắn cho trọng tài. Referee scan → vào role ngay lập tức (không cần đăng ký tài khoản đầy đủ, chỉ cần nhập tên). Friction gần bằng 0.
_Novelty:_ Người không rành công nghệ vẫn có thể join và chấm điểm trong vòng 30 giây.

**[Category: Visibility] — #43 Admin Court Dashboard (Visibility Only)**
_Concept:_ Admin có màn hình "Tổng quan" — thấy: Trận nào đang có referee chấm điểm? Trận nào chưa có ai cầm? Chỉ là visibility, không phải control (không assign sân qua app).
_Novelty:_ Admin không cần di chuyển vật lý để biết mọi chuyện đang diễn ra ở 4 sân cùng lúc.

---

## Idea Organization and Prioritization

### Tổng quan toàn phiên

| Phase | Kỹ thuật | Số ý tưởng |
|---|---|---|
| Phase 1 | First Principles Thinking | 3 |
| Phase 2 | Role Playing (Cơn bão 8h sáng) | 2 |
| Phase 3 | Constraint Mapping | 4 |
| Phase 4 | Decision Tree Mapping | 6 |
| Phase 5 | Worst Case Scenario Analysis | 8 |
| Phase 6 | Emotional Journey Mapping | 10 |
| Phase 7 | Anti-Features Thinking | 10 |
| **Tổng** | | **43 ý tưởng** |

---

### Phân loại theo Impact/Effort cho MVP

#### 🔴 MUST HAVE — High Impact, Low/Medium Effort
*(Thiếu 1 trong các tính năng này → MVP fail)*

| # | Idea | Lý do |
|---|---|---|
| #2 | Smart Match Queueing + Skip/Move | Core operational flow |
| #4 | Walkover UI | Xử lý tình huống thực tế bắt buộc |
| #5 | Court Decoupling | Giữ app đơn giản, không config sân |
| #6 | High-Confidence Scoring UI | Fat-finger prevention là sinh tử |
| #11 | Hybrid Scoring Entry | Phục vụ cả 2 use case scoring |
| #12 | One-Click Manifest | Thời gian setup = tốc độ adoption |
| #14 | Paste-to-Register | Loại bỏ đau điểm nhập tên bằng tay |
| #16 | Optimistic Local Commit | Mạng 4G không ổn định |
| #17 | "Saved Locally" Toast | Tâm lý quan trọng hơn kỹ thuật |
| #40 | 2-Tier Admin/Referee System | 3+ sân → bắt buộc phải có |

#### 🟡 SHOULD HAVE — High Impact, Medium Effort
*(Làm được trong Sprint 1-2 sau MVP core)*

| # | Idea | Lý do |
|---|---|---|
| #7 | Subtle Rule Guidance | Giảm tranh cãi luật điểm |
| #8 | Semi-Auto Bracket Slotting | BTC cần control vòng Knockout |
| #15 | Public Realtime Link | VĐV xem kết quả không hỏi BTC |
| #18 | 60-Second Undo Window | Safety net quan trọng |
| #28 | Public Display QR Code | Giảm interrupt cho BTC |
| #30 | Score Sanity Check | Nhắc nhở thông minh |
| #35 | Smart 2-Trigger Notification | VĐV chủ động chuẩn bị |
| #41 | Per-Court Score Lock | Concurrency cho Multi-Admin |
| #42 | Referee Quick Join | Onboarding friction gần 0 |
| #43 | Admin Court Dashboard | Visibility cho 3+ sân |

#### 🟢 NICE TO HAVE — Medium Impact, Any Effort
*(V1.5 hoặc V2)*

| # | Idea | Lý do |
|---|---|---|
| #1 | Multi-stage Scoring Rules | Profile điểm theo giai đoạn |
| #3 | On-the-fly Bracket Logic | Linh hoạt thay đổi số đội tiếp |
| #9 | Roster Elasticity | Sửa tên/thay đội khi đang chạy |
| #19 | Admin Force Override (Hidden) | Escape hatch cho tình huống đặc biệt |
| #20 | Forfeit Team Action | Xử lý đội rút giải |
| #21 | Phantom Team Indicator | Tính minh bạch bracket |
| #24 | Readiness Checklist | Giảm lo lắng trước giải |
| #25 | Dry Run Mode | Phá rào cản adoption lần đầu |
| #26 | Full-Screen Operation Mode | Focus trong giờ cao điểm |
| #27 | Zero-Tap Match Calling | Speed optimization |
| #29 | "Ai đang ở sân?" Strip | Bộ nhớ ngoài cho BTC |
| #31 | Tournament Summary Card | Shareable kết quả |
| #32 | Tournament History Report | Retention hook |
| #33 | "Dùng lại giải này" Template | Switching cost tự nhiên |

#### ⚫ ANTI-FEATURES — Cố tình không làm ở MVP
*(Ghi lại để tránh scope creep)*

| # | Anti-Feature | Rationale |
|---|---|---|
| #34 | ❌ Court Management | BTC nhìn sân bằng mắt |
| #36 | ❌ Player Profile/Stats | Identity problem quá phức tạp |
| #37 | ❌ Template Marketplace | 3 templates là đủ |
| #38 | 🔜 In-App Chat → V2+ | Zalo đang làm tốt hơn |
| #39 | ❌ Full Offline-First | Practical tradeoff, cache là đủ |

---

### Top Priority per Phase: Key Insights cho PRD

1. **Instant Setup (Excel-like efficiency):** Paste-to-Register + One-Click Manifest + 3 Template = thời gian từ "Mở app" đến "Gọi trận đầu tiên" < 10 phút.
2. **Flexible Scoring UI:** Hybrid Entry + High-Confidence UI + Sanity Check + Undo = BTC không sợ nhập sai.
3. **Resilience Layer:** Optimistic Local Commit + "Saved Locally" Toast = không bao giờ mất điểm số.
4. **2-Tier Role System:** Admin + Referee = scalable cho giải 3+ sân mà không cần multi-admin đối xứng phức tạp.
5. **Smart Notification:** 2-Trigger = VĐV tự điều phối, BTC bớt gọi miệng.

### Thay đổi quan trọng so với PRFAQ gốc

> ⚠️ **Cần cập nhật PRFAQ:**
> - **Multi-admin: NOT out-of-scope** — 2-Tier Admin/Referee System là MUST HAVE khi giải có 3+ sân.
> - **Notification: NOT out-of-scope** — Smart 2-Trigger Notification là SHOULD HAVE (gắn với VĐV experience).
> - Hai thay đổi này ảnh hưởng đến architecture và cần được reflect trong PRD trước khi viết user stories.

---

*Session completed: 2026-04-08 | 43 ideas | 7 techniques | Extended session*
