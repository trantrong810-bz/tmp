# 🚀 AI Tools — Bộ Công Cụ AI Cho Lập Trình Viên

> **Một câu tóm gọn:** Đây là bộ công cụ giúp AI coding assistant (Gemini, Claude, Cursor...) trở nên **thông minh hơn 10 lần** — biết cách lập kế hoạch, viết code đúng chuẩn, review code, debug, và quản lý dự án tự động.

---

## 📖 Mục Lục

- [Đây là gì?](#-đây-là-gì)
- [Cài đặt nhanh (5 phút)](#-cài-đặt-nhanh-5-phút)
- [Cách sử dụng](#-cách-sử-dụng)
- [12 Lệnh chính](#-12-lệnh-chính)
- [Cấu trúc thư mục](#-cấu-trúc-thư-mục)
- [Hỗ trợ ngôn ngữ lập trình nào?](#-hỗ-trợ-ngôn-ngữ-lập-trình-nào)
- [Câu hỏi thường gặp (FAQ)](#-câu-hỏi-thường-gặp)
- [Xử lý lỗi](#-xử-lý-lỗi)

---

## 🤔 Đây là gì?

### Vấn đề

Khi bạn dùng AI assistant (Gemini, Claude...) để code, nó thường:
- ❌ Code bừa, không theo chuẩn project
- ❌ Không biết test, không verify kết quả
- ❌ Không biết kiến trúc, pattern nào phù hợp
- ❌ Bạn phải hướng dẫn lại từ đầu mỗi lần chat mới

### Giải pháp

**AI Tools** = Bộ "não bổ sung" cho AI assistant, gồm **3 hệ thống** kết hợp:

| Hệ thống | Vai trò | Ví dụ |
|-----------|---------|-------|
| **BMAD** | Quy trình — *"Làm gì trước, gì sau"* | Tạo PRD → Architecture → Sprint plan → Stories |
| **AG Kit** | Kiến thức — *"Làm như thế nào"* | Java patterns, React best practices, DDD |
| **Superpowers** | Kỷ luật — *"Phải test, phải verify"* | TDD, code review, debug có hệ thống |

**Kết quả:** Bạn chỉ cần gõ `/dev`, `/review`, `/test`... — AI tự biết phải làm gì, dùng tool nào, theo chuẩn nào.

---

## ⚡ Cài Đặt Nhanh (5 phút)

### Yêu cầu

- Git đã cài đặt
- AI coding assistant hỗ trợ đọc thư mục `.agent/` (Gemini Code Assist, Cursor, Cline, v.v.)
- Node.js (để cài BMAD) — *tùy chọn*

### Bước 1: Clone repo

```bash
git clone https://git.evotek.vn/evohcm/1.wip/ai-tools.git
cd ai-tools
```

### Bước 2: Cập nhật submodules

```bash
git submodule update --init --recursive
```

### Bước 3: Cài đặt BMAD (tùy chọn)

```bash
npx bmad-method install --yes
```

### Bước 4: Copy vào dự án của bạn

Cách đơn giản nhất — copy 2 thư mục này vào **root** của dự án bạn đang làm:

```
your-project/
├── .agent/          ← Copy từ ai-tools/.agent/
├── evo/             ← Copy từ ai-tools/evo/ (nếu muốn tùy chỉnh)
├── src/
├── pom.xml
└── ...
```

> **💡 Mẹo:** Chỉ cần thư mục `.agent/` là đủ để AI assistant hoạt động. Thư mục `evo/` dùng khi bạn muốn tùy chỉnh nâng cao.

### Bước 5: Bắt đầu sử dụng

Mở dự án trong IDE → mở AI chat → gõ `/help` → AI sẽ tự nhận diện project và hướng dẫn bạn.

---

## 🎯 Cách Sử Dụng

### Dùng cơ bản — Gõ lệnh, AI tự làm

Mở AI chat trong IDE và gõ:

```
/dev          → Viết code (tự detect story mode hoặc quick mode)
/test         → Chạy test (tự detect framework)
/review       → Review code (3 lớp kiểm tra)
/debug        → Debug có hệ thống (4 bước)
```

### Ví dụ thực tế

**Bạn muốn thêm tính năng mới:**
```
/dev thêm chức năng đăng nhập bằng Google OAuth
```
→ AI sẽ: đọc kiến trúc → viết test trước → code → verify → báo kết quả.

**Bạn muốn review code:**
```
/review
```
→ AI chạy 3 lớp review: tìm bug ẩn, edge cases, kiểm tra acceptance criteria.

**Bạn muốn debug lỗi:**
```
/debug trang dashboard load chậm
```
→ AI theo 4 bước: thu thập bằng chứng → xác định nguyên nhân → sửa → verify.

**Bạn muốn tạo sản phẩm từ đầu:**
```
/create
```
→ AI hướng dẫn qua toàn bộ lifecycle: brief → PRD → architecture → epics → stories.

---

## 📋 12 Lệnh Chính

| Lệnh | Chức năng | Khi nào dùng |
|-------|-----------|-------------|
| `/create` | Tạo sản phẩm từ đầu | Bắt đầu dự án mới |
| `/architecture` | Thiết kế kiến trúc | Cần quyết định tech stack, patterns |
| `/dev` | Viết code | Implement feature, fix bug |
| `/review` | Review code | Trước khi merge PR |
| `/test` | Chạy & viết test | Kiểm tra chất lượng code |
| `/debug` | Debug có hệ thống | Tìm & sửa lỗi phức tạp |
| `/enhance` | Thêm tính năng vào app có sẵn | Cải thiện sản phẩm đang chạy |
| `/plan` | Lập kế hoạch sprint | Chia nhỏ công việc, ước lượng |
| `/brainstorm` | Brainstorm ý tưởng | Cần sáng tạo, tìm giải pháp |
| `/orchestrate` | Phối hợp nhiều agent | Task phức tạp cần nhiều chuyên gia |
| `/status` | Xem tiến độ sprint | Theo dõi progress |
| `/help` | Xem hướng dẫn | Không biết bắt đầu từ đâu |

> **💡 Gõ `/help` bất kỳ lúc nào** để xem chi tiết từng lệnh và gợi ý lệnh tiếp theo.

---

## 📁 Cấu Trúc Thư Mục

```
ai-tools/
│
├── .agent/                  ← 🧠 "Não" của AI (AI đọc thư mục này)
│   ├── skills/              ← 177+ kỹ năng (BMAD + AG Kit + Superpowers)
│   ├── workflows/           ← 16 workflows (xử lý mỗi /lệnh)
│   ├── agents/              ← Chuyên gia ảo (backend, frontend, devops...)
│   ├── rules/               ← Quy tắc AI phải tuân theo
│   ├── policies/            ← Chính sách dự án
│   └── project-context.md   ← Thông tin dự án (AI đọc đầu tiên)
│
├── evo/                     ← ⚙️ Cấu hình & tùy chỉnh
│   ├── GEMINI.md            ← Bộ não chính của AI (tính cách, cách làm việc)
│   ├── evo-registry.yaml    ← Tự động nhận diện loại project
│   ├── agents/              ← Chuyên gia tùy chỉnh riêng
│   ├── workflows/           ← Logic xử lý 12 lệnh
│   ├── templates/           ← Mẫu tạo agent mới
│   └── setup.ps1            ← Script cài đặt
│
├── _upstream/               ← 📦 Source gốc (Git submodules, không sửa)
│   ├── antigravity-kit/     ← AG Kit (kiến thức domain)
│   ├── bmad-method/         ← BMAD (quy trình)
│   └── superpowers/         ← SP (kỷ luật code)
│
├── _bmad/                   ← 📝 BMAD modules (creative, game dev, testing...)
│
├── docs/                    ← 📄 Tài liệu dự án (cho con người đọc)
│   ├── 00-project/          ← Giới thiệu, glossary, conventions
│   ├── 01-business/         ← Product brief, business requirements
│   ├── 02-requirements/     ← SRS, UX design, NFR
│   ├── 03-architecture/     ← Architecture, domain model, API design
│   ├── 04-epics/            ← Epics, sprint plan, stories
│   └── 05-ux/               ← UX specifications
│
└── projects/                ← 📂 Thư mục chứa dự án con (nếu có)
```

### Quy tắc quan trọng

| Thư mục | Ai sửa? | Ghi chú |
|---------|---------|---------|
| `.agent/` | ❌ Không sửa trực tiếp | Auto-sync từ `evo/` và `_upstream/` |
| `evo/` | ✅ Bạn sửa ở đây | Thay đổi → chạy sync → `.agent/` tự cập nhật |
| `_upstream/` | ❌ Chỉ đọc | Cập nhật bằng `git submodule update` |
| `docs/` | ✅ Bạn + AI cùng sửa | Tài liệu đã duyệt, tiêu chuẩn ngành |

---

## 🌐 Hỗ Trợ Ngôn Ngữ Lập Trình Nào?

AI tự nhận diện project type qua file cấu hình:

| Loại project | File nhận diện | Chuyên gia AI |
|-------------|---------------|---------------|
| **Java / Spring Boot** | `pom.xml`, `build.gradle` | Java Backend Specialist |
| **React / Next.js** | `package.json` + `react` | Frontend Specialist |
| **Python** (Django, FastAPI) | `pyproject.toml`, `requirements.txt` | Backend Specialist |
| **Node.js** (Express, NestJS) | `package.json` + `express` | Backend Specialist |
| **React Native / Expo** | `package.json` + `react-native` | Mobile Developer |
| **Rust** | `Cargo.toml` | Backend Specialist |
| **DevOps** | `Dockerfile`, `docker-compose.yml` | DevOps Engineer |

> **Không thấy ngôn ngữ bạn dùng?** Bạn có thể tự thêm trong `evo/evo-registry.yaml` — chỉ cần 5 dòng YAML.

---

## ❓ Câu Hỏi Thường Gặp

### "Tôi mới hoàn toàn, bắt đầu từ đâu?"

1. Copy thư mục `.agent/` vào project của bạn
2. Mở AI chat → gõ `/help`
3. AI sẽ tự nhận diện project và gợi ý bước tiếp theo

### "Tôi chỉ cần code nhanh, không cần quy trình"

Gõ `@fast` trước yêu cầu. AI sẽ bỏ qua các bước deliberation và code trực tiếp.

### "AI có tự chạy test không?"

Có. Khi bạn dùng `/dev`, AI mặc định theo quy trình **TDD** (Test-Driven Development): viết test trước → code → verify.

### "Tôi muốn tùy chỉnh AI hoạt động khác đi"

Sửa file `evo/GEMINI.md` — đây là "bộ não" quy định cách AI suy nghĩ và hành động.

### "Các override nhanh"

| Lệnh | Tác dụng |
|-------|----------|
| `@fast` | Bỏ suy nghĩ, làm ngay |
| `@deep` | Phân tích sâu, kiến trúc |
| `@explain` | Giải thích mọi quyết định |
| `help` | Gợi ý lệnh tiếp theo |

---

## 🔧 Xử Lý Lỗi

| Vấn đề | Cách sửa |
|--------|----------|
| Gõ `/lệnh` nhưng AI không hiểu | Kiểm tra thư mục `.agent/workflows/` có files không |
| AI không nhận project type | Kiểm tra `evo/evo-registry.yaml` có detect_files đúng không |
| BMAD skills bị mất | Chạy `npx bmad-method install --yes` |
| Sau khi sync, agent vẫn cũ | Kiểm tra `evo/agents/` có file mới chưa |

---

## 📊 Tổng Quan Nhanh

```
177+ skills  ·  16 workflows  ·  20+ agents  ·  7 project types
3 hệ thống (BMAD + AG Kit + Superpowers) = 1 giao diện thống nhất
```

---

*Maintained by Evo team · Phiên bản hiện tại: 2.0.0*
