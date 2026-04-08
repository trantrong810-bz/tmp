# Stitch Prompts — Admin Flow Epic 1
## SaaS Tổ chức Giải Cầu Lông CLB

> **Based on:** PRD-club-badminton-tournament-app.md — Section 13.1 (Epic 1 & 2)
> **Viewport:** Mobile 390px (iOS first)
> **Stitch Mode:** Pro Mode (higher fidelity recommended)
> **Date:** 2026-04-08

---

## 🎨 Shared Design System (dùng chung cho tất cả prompt)

```
=== DESIGN SYSTEM ===

Platform: iOS Native Mobile App (390px)
Design Style: Dark mode, professional sports tournament management

Colors:
- Background: Deep Navy (#0D1B2A)
- Surface/Card: Dark Slate (#1A2E42)
- Primary/CTA: Electric Blue (#2196F3), gradient to #1565C0
- Accent/Score: Vivid Green (#00E676) for success, Amber (#FFA726) for warning
- Destructive: Coral Red (#EF5350)
- Text Primary: White (#FFFFFF)
- Text Secondary: Cool Gray (#90A4AE)
- Divider: Dark Border (#263547)

Typography:
- Font: Inter (system-ui fallback)
- Headlines: Bold 700, tight tracking
- Body: Regular 400, 16px base
- Labels: Medium 500, 12px caps for section headers

Component Styles:
- Buttons Primary: Full-width rounded (12px), Electric Blue gradient, bold white text
- Buttons Destructive: Coral Red, rounded 12px
- Buttons Ghost: Dark Slate background, Blue border, White text
- Inputs: Dark Slate background (#1A2E42), rounded 10px, Blue focus ring, White text
- Cards: Dark Slate (#1A2E42), rounded 16px, subtle drop shadow
- Navigation: Bottom Tab Bar, 4-5 icons, Dark Navy background
- List Items: Card style, 64px min height, left icon + right chevron
- Tags/Badges: Rounded pill, color-coded by status
- Status Tags: Active=Green pill, Idle=Gray pill, PENDING=Blue, IN_PROGRESS=Amber, DONE=Gray
```

---

## BATCH 1 — Tournament List & Tournament Setup (2 màn hình)

### Prompt 1A: Tournament List (Màn hình chính Admin)

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Vietnamese club tournament organizers, non-tech-savvy, use one hand, high stress environment
Brand feel: Dark, professional, fast, sports-grade efficiency
Market: Vietnam, mobile-first, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Tournament List (Admin Home)
Purpose: Admin sees all their tournaments at a glance and can create a new one
User context: Admin just opened the app, wants to jump into their active tournament fast

Layout structure:
1. Header bar: App logo left, avatar/profile icon right
2. Hero greeting: "Xin chào, [Name]! 👋" large bold text, subtitle shows date
3. Section "Đang diễn ra" (Active label, green dot): 1-2 tournament cards
4. Section "Sắp tới" (Upcoming): tournament cards
5. Section "Đã kết thúc" (Past, collapsed): smaller list
6. Floating Action Button (FAB): "+" button, bottom right, Electric Blue

Tournament Card elements:
- Tournament name: "Giải Cầu Lông CLB Hoàng Anh 2026" (bold, white)
- Date: "08/04/2026" (secondary text, calendar icon)
- Status badge: "Đang diễn ra" green pill OR "Sắp bắt đầu" blue pill
- Team count: "16 đội" with people icon
- Progress bar: showing matches completed (e.g., "8/24 trận") thin green bar
- Arrow chevron right on card edge

Key elements:
- FAB label: "Tạo Giải Mới"
- Empty state (no tournaments): Illustration + "Bạn chưa có giải nào. Tạo giải đầu tiên!" + blue CTA button
- Active tournament card should have a glowing Electric Blue left border accent

Key interactions:
- Tap card: Navigate to Tournament Detail
- Tap FAB: Navigate to Create Tournament form
- Pull down: Refresh

=== GENERATION INSTRUCTIONS ===

Generate this Tournament List home screen matching:
- Visual style: Dark professional sports app (like ESPN or FlashScore dark mode)
- Layout: Clean card list with bold status indicators
- All content in Vietnamese
- Show ONE active tournament card prominently at top
- FAB button prominent bottom-right

Viewport: Mobile 390px
```

---

### Prompt 1B: Tạo Giải Đấu — Create Tournament Form

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Vietnamese club organizers, need to create tournament in under 10 minutes
Brand feel: Dark, professional, efficient, step-by-step guided
Market: Vietnam, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Create Tournament (Step 1 of 3 — Basic Info)
Purpose: Admin fills in tournament name, date, and optional logo/banner to create a new tournament
User context: Admin tapped FAB from home, starting fresh tournament setup. No complex steps yet — just the basics.

Layout structure:
1. Navigation bar: "← Quay lại" left arrow, "Tạo giải" title center
2. Step indicator: "Bước 1/3 — Thông tin cơ bản" with 3-dot progress chips at top
3. Form section "Thông tin giải đấu":
   - Input: Tên giải* (required) — large text input, placeholder "VD: Giải CLB Hoàng Anh 2026"
   - Input: Ngày thi đấu (optional) — date picker field, calendar icon on right
   - Textarea: Mô tả giải (optional) — 3-line expandable, placeholder "Giải đấu dành cho..."
4. Media section "Hình ảnh (tuỳ chọn)":
   - Logo upload: Square tile 80x80px, dashed border, camera icon, label "Logo"
   - Banner upload: Wide tile 160x80px, dashed border, camera icon, label "Banner"
   - Helper text: "Sẽ hiển thị trên trang public của giải"
5. Bottom sticky CTA: "Tiếp tục →" full-width Electric Blue button

Key elements:
- Required field asterisk (*) in Coral Red next to label
- Step chips: Step 1 filled blue, Step 2 gray, Step 3 gray
- Input labels: Small caps gray label above each input
- "Tên giải" input: keyboard open state shown, has typed text "Giải CLB Hoàng Anh 2026"
- CTA button: Disabled state grayed if Tên giải empty, active blue when filled

Key interactions:
- Tap date field: Native date picker sheet slides up
- Tap logo/banner tile: Photo picker opens
- Tap "Tiếp tục": Validates required field then goes to Step 2 (Create Events)

=== CURRENT STATE NOTES ===

- All inputs: Dark Slate background, no white backgrounds
- Step progress: Custom pill chips, not default radio buttons
- Upload tiles: Dashed border in secondary gray, icon centered

=== GENERATION INSTRUCTIONS ===

Generate Step 1 of Create Tournament form matching:
- Visual style: Dark form, clean fields, clear hierarchy
- Layout: Scrollable form, sticky bottom CTA
- Vietnamese labels, professional feel
- Show keyboard-up state with "Tên giải" field focused and filled

Viewport: Mobile 390px
```

---

## BATCH 2 — Event Setup & Team Management (2 màn hình)

### Prompt 2A: Quản lý Event & Scoring Rule Preset

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Badminton club organizers in Vietnam
Brand feel: Dark, professional, sports management precision
Market: Vietnam, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Create Tournament Step 2 — Event Setup (Nội dung thi đấu)
Purpose: Admin creates one or more Events (e.g. Men's Doubles, Mixed Doubles), and sets the scoring rule for each event
User context: Admin had just filled tournament basic info, now defining the competition events before entering teams

Layout structure:
1. Navigation: "← Quay lại" left, "Tạo giải" title, step indicator "Bước 2/3"
2. Section header: "Nội dung thi đấu" in caps gray label
3. Event cards list (2 already created):
   Card A: 
     - Event name: "Đôi Nam (Trung Bình)"
     - Scoring rule badge: "Best of 3 — Set 21" in Blue pill
     - Right side: Edit pencil icon + red trash icon
   Card B:
     - Event name: "Đôi Nam Nữ"
     - Scoring rule badge: "1 Set 21" in Blue pill
     - Right side: Edit pencil icon + red trash icon
4. Add Event button: "＋ Thêm Nội Dung" ghost button, dashed blue border, full-width
5. Bottom CTA: "Tiếp tục →" full-width Electric Blue

--- OVERLAY / MODAL STATE (show on same screen) ---
Bottom Sheet Modal (half-screen) for "Thêm / Sửa Event":
  - Modal handle bar at top
  - Title: "Nội dung thi đấu"
  - Input: "Tên nội dung*" — filled with "Đôi Nam Mạnh"
  - Section: "Luật điểm*" — 3 card-style radio options:
      Option 1: "1 Set 21" (selected, has blue check border) — sublabel "Cách biệt 2, tối đa 30"
      Option 2: "1 Set 31 (chạm)" — sublabel "Chạm đúng 31 là thắng"
      Option 3: "Best of 3 (Set 21)" — sublabel "Thắng 2 trong 3 set"
  - CTA button at modal bottom: "Lưu Nội Dung" blue full-width

Key elements:
- Event card: Shows name + scoring rule as colored pill badge
- Scoring rule selection: Card-style radio buttons with blue selection ring
- Add button: Dashed border ghost style
- Ability to see both existing events AND the modal at the same time

=== GENERATION INSTRUCTIONS ===

Generate Step 2 Event Setup screen showing:
- 2 existing event cards in list
- Bottom sheet modal open showing "Add/Edit Event" form
- Scoring rule radio card selection visible
- Vietnamese labels throughout
- Dark theme, professional

Viewport: Mobile 390px
```

---

### Prompt 2B: Nhập danh sách đội — Team Management

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Vietnamese club organizers, need to input 8-32 teams quickly — paste from Excel/Zalo
Brand feel: Dark, efficient, fast data entry, minimal friction
Market: Vietnam, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Team Management — Nhập danh sách đội
Purpose: Admin adds teams to an event. Primary method: Paste a multi-line list from Zalo/Excel. Secondary: manual add one by one.
User context: Admin just configured events, now needs to enter 16 team names fast before the tournament

Layout structure:
1. Navigation: "← Sự kiện" back, "Đội thi đấu" title, event badge "Đôi Nam TB"
2. Counter + toggle: "16/32 đội" counter on left, "Thêm nhanh" toggle button on right (active state)
3. "QUICK IMPORT" paste box:
   - Label: "Dán danh sách từ Excel / Zalo"
   - Large textarea (6 lines visible), gray placeholder: "Mỗi dòng một đội. Ví dụ:\nHùng / Nam\nMinh / Đức\nSơn / Tuấn..."
   - Below textarea: "Nhận diện 16 tên đội" success green text (when content is pasted)
   - Parse button: "→ Nhận diện danh sách" blue ghost button
4. Teams list preview (after parse):
   - Section header: "Danh sách đã nhận diện (16 đội)" with green check icon
   - List of team items: 
       #1 "Hùng / Nam" — right side: edit icon + delete icon
       #2 "Minh / Đức" — right side: edit icon + delete icon
       #3 "Sơn / Tuấn" — right side: edit icon + delete icon
       ... [more items scrollable]
5. Add single button: "＋ Thêm thủ công" small ghost link below list
6. Bottom CTA: "Tiếp tục → Seeding" full-width blue button

Key elements:
- Quick Import textarea: Dark Slate background, content already pasted in (show 5-6 lines of names)
- Success state: green "✔ Nhận diện 16 tên đội" below textarea
- Team list items: Number prefix, team name bold, right actions inline
- Event badge in nav: Small pill "Đôi Nam TB" in blue
- Counter "16/32" in green when teams are added

Key interactions:
- Paste text → tap "Nhận diện" → list renders below
- Individual item has inline edit/delete
- "Thêm thủ công" shows single add form

=== CURRENT STATE NOTES ===

- Textarea: Dark Slate, no white backgrounds
- Parse success state: Green text + checkmark, NOT a modal or alert
- Team list items: Card-style, same height, consistent spacing

=== GENERATION INSTRUCTIONS ===

Generate Team Management screen showing:
- Quick Import textarea with content already pasted (5-6 team names visible)
- Green success indicator showing "16 đội đã nhận diện"
- Preview list of first 4-5 teams below
- Sticky bottom CTA button "Tiếp tục → Seeding"
- Vietnamese labels, dark professional sports theme

Viewport: Mobile 390px
```

---

## BATCH 3 — Seeding & Generate Bracket (2 màn hình)

### Prompt 3A: Seeding Screen

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Vietnamese club organizers, drag & drop reordering before tournament
Brand feel: Dark, tactile, interactive, sports management
Market: Vietnam, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Seeding — Hạng hạt giống
Purpose: Admin reorders team list to set seeding before bracket generation. Can random shuffle or drag-drop manually.
User context: Teams have been entered. Admin now sets seed order. Most of the time they just hit Random.

Layout structure:
1. Navigation: "← Đội" back, "Seeding" title, event badge "Đôi Nam TB"
2. Action bar (2 buttons side by side):
   - Left: "🔀 Xáo ngẫu nhiên" ghost button with shuffle icon (Amber border, white text)
   - Right: "Reset" ghost button text only
3. Instruction text: "Kéo để thay đổi thứ tự hạng hạt giống" (small gray pills text)
4. Drag-and-drop list (16 items):
   - Item row structure: 
       Left: drag handle (6 dots) in gray
       Center left: Seed number circle "#1" filled blue (top 4: Blue, rest: Gray outline)
       Center: Team name "Hùng / Nam" bold white, sub "Đội mạnh nhất" optional gray sub
       Right: "CLB Hoàng Anh" small gray club badge (if any)
   - Item being dragged: floats with shadow, blue border highlight, slightly scaled up
5. Bottom CTA: "Generate Bracket →" full-width Electric Blue button

Key elements:
- Drag handle: 6 dots in a 2x3 grid, Gray (#90A4AE)
- Seed #1-4 circles: Filled blue (top seeds)
- Seed #5+ circles: Gray outline
- Active drag state: Item has elevation shadow + blue left border
- Random shuffle button: Triggers animation — items visibly shuffle with ease transition
- "CLB Hoàng Anh" label: Small pill badge, secondary gray

Key interactions:
- Drag item up/down: Reorder list
- Tap "Xáo ngẫu nhiên": Animated reorder
- Tap "Generate Bracket": Validate then show bracket generation screen

=== GENERATION INSTRUCTIONS ===

Generate Seeding screen showing:
- Full list with drag handles visible
- Top 4 seeds in Blue numbered circles
- One item shown in "being dragged" elevated state (item #3 floating slightly)
- "Xáo ngẫu nhiên" button prominently visible top
- Vietnamese labels, dark theme, tactile drag UI

Viewport: Mobile 390px
```

---

### Prompt 3B: Generate Bracket — Chọn Format

```
=== PROJECT CONTEXT ===

App: TourneyRun — Tournament management app for badminton club organizers
Target: Vietnamese club organizers, quick bracket creation for 8-32 team tournaments
Brand feel: Dark, confident, one-tap setup, visual bracket preview
Market: Vietnam, iOS

=== DESIGN SYSTEM ===

[Paste shared design system block above]

=== SCREEN DETAILS ===

Screen: Generate Bracket — Chọn Format Thi Đấu
Purpose: Admin selects tournament format (3 presets or custom) before generating the bracket
User context: Admin finished seeding, now making the most important structural decision

Layout structure:
1. Navigation: "← Seeding" back, "Chọn Format" title
2. Section header: "3 Template Nhanh" in caps gray
3. Template cards (3 cards, radio-select style, stacked):
   Card 1 — "Vòng Bảng → Loại Trực Tiếp" (selected state, blue border + check icon):
     - Icon: Two overlapping bracket shapes
     - Name: Bold "Vòng Bảng → Knockout"
     - Description: "Phổ biến nhất. Chia bảng đấu vòng tròn, lấy Nhất/Nhì vào Knockout"
     - Badge: "Khuyến nghị" green pill
   Card 2 — "Vòng Tròn (Round Robin)" (unselected):
     - Icon: Circle with arrows
     - Name: "Vòng Tròn"
     - Description: "Tất cả đấu với tất cả, xếp hạng cuối giải"
   Card 3 — "Loại Trực Tiếp (Knockout)" (unselected):
     - Icon: Tournament bracket icon
     - Name: "Loại Kép / Loại Đơn"
     - Description: "Loại trực tiếp từ vòng 1, nhanh gọn"
4. Section header: "Custom Format" in caps gray
5. Custom format card (ghost/outline style):
   - Icon: Settings/gear icon
   - Name: "Tùy Chỉnh"
   - Description: "Ghép tự do League + Group + Knockout theo ý muốn"
   - Badge: "Nâng cao" amber pill
6. Bracket preview section (at bottom, when a template selected):
   - Mini bracket wireframe preview: Shows 4 groups of 4 → 8 team bracket
   - Text: "Xem trước: 16 đội → 4 bảng × 4 đội → 8 đội vào Knockout"
7. Bottom CTA: "✨ Generate Bracket" full-width Electric Blue button

Key elements:
- Selected card: Blue border ring, blue check icon top-right corner, slightly lighter background
- "Khuyến nghị" badge on Card 1: Small green pill
- "Nâng cao" badge on Custom: Small amber warning pill
- Mini bracket preview: Thin blue lines showing bracket structure diagram (8-16 node)
- CTA button has sparkle icon: "✨ Generate Bracket"

=== GENERATION INSTRUCTIONS ===

Generate Format Selection screen showing:
- 3 template cards, Card 1 "Vòng Bảng → Knockout" selected with blue border
- Custom format card below as ghost style option
- Mini bracket wireframe preview visible at bottom
- "Generate Bracket" prominent blue CTA at very bottom
- Vietnamese labels, confident professional sports feel

Viewport: Mobile 390px
```

---

## 📋 Stitch Execution Checklist

### Batch 1 (Màn hình 1A + 1B)
- [ ] Tournament List home screen
- [ ] Create Tournament Step 1 form

### Batch 2 (Màn hình 2A + 2B)
- [ ] Event Setup with bottom sheet modal
- [ ] Team Management with Quick Import

### Batch 3 (Màn hình 3A + 3B)
- [ ] Seeding drag-and-drop screen
- [ ] Generate Bracket format picker

### Stitch Settings
- **Mode:** Pro Mode (higher fidelity)
- **Viewport:** Mobile 390px cho tất cả
- **Variants:** Generate 2-3 variants mỗi màn hình, pick best
- **Export:** Screenshot → lưu vào `_bmad-output/planning-artifacts/ux-designs/admin-epic1/`

### After Generation
- [ ] Review against PRD Acceptance Criteria (Section 13.1)
- [ ] Check: nút [+] score có đủ to không? (sẽ cần ở màn hình scoring Epic 4)
- [ ] Export to Figma OR HTML/CSS as reference for dev
