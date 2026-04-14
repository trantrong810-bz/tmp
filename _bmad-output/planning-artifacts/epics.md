---
stepsCompleted: ['step-01-validate-prerequisites', 'step-02-design-epics']
inputDocuments: ['input/PRD-club-badminton-tournament-app.md', '_bmad-output/planning-artifacts/ux-stitch-prompts-admin-epic1.md']
---

# TourneyRun - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for TourneyRun, decomposing the requirements from the PRD, UX Design if it exists, and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

FR1: Admin can create tournaments with name (required), start date, end date, location, logo, banner, and description (optional).
FR2: Admin can create, edit, or delete Events (e.g., Men's Doubles) within a tournament.
FR3: Admin must assign a Scoring Rule Preset (1 Set 21, 1 Set 31, Best of 3) to each Event.
FR4: Admin can input team names manually or paste a multi-line list (from Excel/Zalo) for text parsing.
FR5: Admin can reorder teams via Random Seeding or Manual Drag & Drop.
FR6: System can generate brackets based on 3 Templates (Group Stage -> Knockout, Round Robin, Single Knockout) or Custom Format.
FR7: Admin can regenerate brackets with versioning and rollback capabilities.
FR8: System generates a Global Match Queue spanning all events with proper dependencies.
FR9: Admin can skip, move down, or pin matches in the Match Queue.
FR10: User (Admin/Referee) can input match score in Interactive Mode (tap to add points) or Quick Result Mode.
FR11: Admin/Referee can confirm the score with a 60-second Undo Window functionality.
FR12: System supports Walkover (absent team) and Forfeiting (team withdraws) which auto-updates brackets.
FR13: Admin can add Referees via email, phone, or username.
FR14: Multiple Referees can score the same match concurrently using last-write-wins logic over WebSocket.
FR15: Admin can view an active Referee Dashboard displaying Idle/Active status.
FR16: System sends Push Notifications to Followers when a match begins (Trigger 1) and nears completion (Trigger 2).
FR17: System creates a public read-only web link/QR for viewers to see realtime Queue, Results, Bracket, Standings.
FR18: System stores scores locally and automatically exports an Excel backup to local storage every 1 minute.

### NonFunctional Requirements

NFR1: Generate bracket must execute in < 3 seconds.
NFR2: Save score to local commit must execute in < 0.5 seconds (optimistic UI).
NFR3: Sync score to server must execute in < 1 second.
NFR4: Background Excel export process must not cause lag or increase "Save score" latency beyond 1 second.
NFR5: New Admin learning curve should be < 10 minutes.
NFR6: Push notification latency should be < 5 seconds after trigger.
NFR7: WebSocket connections must reconnect automatically without user interruption.

### Additional Requirements

- No architecture document found, proceeding with general best practices for SaaS applications.

### UX Design Requirements

UX-DR1: Implement dark mode professional sports theme (Deep Navy #0D1B2A, Surface #1A2E42, Primary Electric Blue #2196F3).
UX-DR2: Create Tournament Card component containing status badge, team count, and progress bar with active glowing border.
UX-DR3: Create 3-step progress navigation chip component for Tournament Creation forms.
UX-DR4: Implement image upload UI with square/dashed border patterns for Logo/Banner.
UX-DR5: Implement modal bottom-sheet for Adding/Editing Events with card-style radio options.
UX-DR6: Implement "Quick Import" Zalo/Excel textarea with real-time parsed confirmation state below it.
UX-DR7: Implement interactive drag-and-drop handles with 6 dots, elevated shadow states and blue border highlight on drag.
UX-DR8: Implement mini bracket wireframe preview at the bottom of the Format Selection step.

### FR Coverage Map

### FR Coverage Map

FR1: Epic 1 - Tạo thông tin giải cơ bản (kèm Logo, Banner...)
FR2: Epic 1 - Quản lý các Event (Đôi nam, Đôi nam nữ...)
FR3: Epic 1 - Cấu hình luật điểm cho từng Event
FR4: Epic 1 - Nhập danh sách đội (Quick Import Zalo/Excel)
FR5: Epic 1 - Chọn thứ tự hạng hạt giống (Seeding)
FR6: Epic 1 - Generate Bracket (Template hoặc Custom)
FR7: Epic 1 - Regenerate Bracket & Rollback
FR8: Epic 2 - Generate Global Match Queue
FR9: Epic 2 - Quản lý Match Queue
FR10: Epic 2 - Input điểm (Interactive / Quick Mode)
FR11: Epic 2 - Confirm điểm & Undo trong 60s
FR12: Epic 2 - Xử lý Walkover / Forfeit
FR18: Epic 2 - Cache local & Background Excel Export
FR13: Epic 3 - Add Referees vào giải
FR14: Epic 3 - Multi-referee realtime scoring
FR15: Epic 3 - Admin Referee Dashboard
FR16: Epic 4 - Push Notification theo trigger
FR17: Epic 4 - Public Viewer Page & QR Code

## Epic List

### Epic 1: Tournament Setup & Bracket Generation
Admin có thể tạo ra một giải đấu hoàn chỉnh từ việc nhập thông tin, cấu hình nội dung thi đấu, up danh sách đội cực nhanh và generate ra sơ đồ nhánh đấu hoàn chỉnh.
**FRs covered:** FR1, FR2, FR3, FR4, FR5, FR6, FR7.

### Epic 2: Live Tournament Operation & Local Scoring
Admin (hoặc trọng tài chính) có thể điều phối trận đấu, chạm màn hình nhập điểm nhanh và lưu điểm an toàn kèm Excel Backup chạy ngầm.
**FRs covered:** FR8, FR9, FR10, FR11, FR12, FR18.

### Epic 3: Multi-Referee Coordination
Admin phát triển giải lớn bằng cách phân quyền cho nhiều trọng tài cầm điện thoại nhập điểm đồng thời và monitoring họ từ xa.
**FRs covered:** FR13, FR14, FR15.

### Epic 4: Audience Engagement & Smart Notifications
VĐV và khán giả Follow giải hoặc xem public link để nhận notification realtime về trận đấu của mình.
**FRs covered:** FR16, FR17.

<!-- Repeat for each epic in epics_list (N = 1, 2, 3...) -->

## Epic 1: Tournament Setup & Bracket Generation

Admin có thể tạo ra một giải đấu hoàn chỉnh từ việc nhập thông tin, cấu hình nội dung thi đấu, up danh sách đội cực nhanh và generate ra sơ đồ nhánh đấu hoàn chỉnh.

### Story 1.1: Quản lý Danh sách giải & Setup thông tin cơ bản

As a Tournament Admin,
I want to view my active tournaments and input basic info for a new tournament,
So that I can start setting up a new event smoothly with clearly specified timelines and visual banners.

**Acceptance Criteria:**

**Given** the Admin is on the TourneyRun home screen
**When** the screen loads
**Then** the system displays a list of tournament cards showing status, date, team count, and a glowing Electric Blue border for the active tournament
**And** a Floating Action Button (FAB) "+" is visible.

**Given** the Admin taps the FAB "+" button
**When** the "Tạo Giải" (Step 1 of 3) screen opens
**Then** the global 3-step progress chip UI shows Step 1 as active
**And** the system displays a form with: Tên giải (required), Ngày bắt đầu, Ngày kết thúc, Địa điểm.

**Given** the Admin interacts with the media section in Step 1
**When** tapping the image upload dashed-tiles
**Then** the native photo picker opens allowing the Admin to upload a Logo and a Banner.

**Given** the Admin fills out the required "Tên giải" field
**When** tapping the "Tiếp tục" CTA at the bottom
**Then** the system saves the basic tournament Draft to the local database and advances to Step 2
**And** if "Tên giải" is empty, the "Tiếp tục" button remains disabled.

### Story 1.2: Cấu hình Event & Luật điểm

As a Tournament Admin,
I want to create multiple competitive events and assign scoring rules,
So that I can manage different categories (e.g., Men's Doubles) with specific win conditions.

**Acceptance Criteria:**

**Given** the Admin is on Step 2 of the Tournament Creation
**When** they tap the "Thêm Nội Dung" ghost button
**Then** a half-screen Bottom Sheet modal slides up for Event Setup.

**Given** the Event Setup modal is open
**When** the Admin enters the Event Name and selects a Scoring Rule Preset (1 Set 21, 1 Set 31, Best of 3) via card-style radio options
**Then** tapping "Lưu Nội Dung" saves the Event and closes the modal, displaying the Event as a card in the list.

**Given** there is at least one Event created
**When** the Admin taps the edit or delete icon on an Event card
**Then** the system allows modifying the Event details or removing it from the configuration.

### Story 1.3: Nhập danh sách đội (Quick Import Parser)

As a Tournament Admin,
I want to paste a multi-line list of teams from Excel or Zalo,
So that I can enter up to 32 teams instantly without manual typing.

**Acceptance Criteria:**

**Given** the Admin is managing teams within an Event
**When** the Admin pastes a multi-line text into the "Dán danh sách từ Excel / Zalo" textarea
**And** taps the "Nhận diện danh sách" button
**Then** the system parses each line as a distinct team name
**And** displays a green success indicator with the count of successfully recognized teams (max 32).

**Given** the teams have been parsed
**When** reviewing the list below the import box
**Then** the system displays team cards with inline edit and delete actions for manual adjustments.

**Given** the Admin wishes to add a single team manually
**When** tapping the "Thêm thủ công" button
**Then** the system provides a simple form to append one team to the roster.

### Story 1.4: Xếp hạng Hạt giống (Seeding)

As a Tournament Admin,
I want to reorder the teams using drag-and-drop or random shuffle,
So that the bracket is generated with fair match-ups and properly distributed top seeds.

**Acceptance Criteria:**

**Given** the Admin navigates to the Seeding screen
**When** viewing the team list
**Then** the top 4 seeds are highlighted with filled blue circle indicators, while others have gray outlines.

**Given** the Admin wants to reorder teams manually
**When** pressing and dragging the 6-dot drag handle on a team row
**Then** the row elevates with a drop shadow and blue border, allowing the Admin to place it at a new seed position.

**Given** the Admin prefers automated seeding
**When** tapping the "Xáo ngẫu nhiên" (Random Shuffle) button
**Then** the system animates all team rows and randomizes their order immediately.

### Story 1.5: Generate Bracket & Template Selection

As a Tournament Admin,
I want to select a tournament format template,
So that the system can automatically generate the correct competition bracket and match dependencies.

**Acceptance Criteria:**

**Given** the Admin has finalized the team seeding
**When** advancing to the Format Selection screen
**Then** the system displays 3 preset templates (Group Stage -> Knockout, Round Robin, Single Knockout) and 1 Custom Format option.

**Given** the Admin selects a template (e.g., Vòng Bảng -> Knockout)
**When** the card is tapped
**Then** it becomes highlighted with a blue border and check icon
**And** a mini bracket wireframe preview appears at the bottom explaining the structure.

**Given** a format is selected
**When** the Admin taps the "✨ Generate Bracket" button
**Then** the system processes the teams, generates the actual bracket structure in the database, and locks the tournament setup phase.

## Epic 2: Live Tournament Operation & Local Scoring

Admin (hoặc trọng tài chính) có thể điều phối trận đấu, chạm màn hình nhập điểm nhanh và lưu điểm an toàn kèm Excel Backup chạy ngầm.

### Story 2.1: Quản lý Global Match Queue

As a Tournament Admin,
I want to view and manage an automated Global Match Queue,
So that I can easily call matches without worrying about court numbers or scheduling conflicts.

**Acceptance Criteria:**

**Given** the tournament bracket has been generated
**When** the Admin navigates to the Match Queue screen
**Then** the system automatically generates a list of matches ordered by dependency and logical progression.

**Given** the Admin is viewing the Match Queue
**When** a specific match needs to be delayed or prioritized
**Then** the Admin can apply Skip, Move Down, or Pin actions to reorder that specific match in the queue without breaking the tournament logic.

### Story 2.2: Giao diện nhập điểm trực tiếp (Interactive Scoring)

As a Referee,
I want to use a reliable, large-button interface to tap scores for each rally,
So that I can accurately track points without looking too closely at the device.

**Acceptance Criteria:**

**Given** a Referee taps on a "PENDING" match in the queue
**When** the Scoring Screen loads
**Then** it displays the corresponding Scoring Rule Preset (e.g., "1 Set 21") at the top
**And** provides large [+] buttons (3-4 times larger than [-]) for point incrementing.

**Given** the Referee taps [+] to add a point
**When** the score increments
**Then** the data commits optimistically to local cache in < 0.5s
**And** an offline indicator "Saved Locally" briefly appears if internet is disconnected.

### Story 2.3: Confirm kết quả & 60-Second Undo Window

As a Referee,
I want to finalize exactly who won with a safety net for mistakes,
So that I can confidently lock the result and update the bracket.

**Acceptance Criteria:**

**Given** the required win condition is reached based on the Scoring Rule
**When** the Referee taps the "Kết thúc trận" button
**Then** the system validates the score
**And** if validation passes, it starts a 60-second Undo Window countdown before finalizing.

**Given** the 60-second Undo Window has completed or has been bypassed by the Admin
**When** the match officially becomes "DONE"
**Then** the bracket and related standings update automatically, unlocking dependent future matches.

### Story 2.4: Xử lý Walkover và Forfeit

As a Tournament Admin,
I want to record team absences or withdrawals quickly,
So that the tournament can proceed without waiting for an unplayable match.

**Acceptance Criteria:**

**Given** a team fails to show up
**When** the Admin taps the "Vắng mặt" (Walkover) button
**Then** the system immediately marks the match as complete without requiring manual 0-21 input, auto-advancing the opposing team.

**Given** a team withdraws completely from the tournament
**When** the Admin assigns "Rút lui" (Forfeit) to that team
**Then** all subsequent pending matches involving that team automatically resolve as default wins for the opponents.

### Story 2.5: Excel Data Backup (Resilience)

As a Tournament Admin,
I want the app to periodically save an Excel backup of all results to my local device,
So that I won't lose tournament data even if the venue's network goes completely dark.

**Acceptance Criteria:**

**Given** the app is running during an active tournament
**When** 1 minute passes since the last backup
**Then** a background process quietly exports an Excel file containing all matches and results to the local device storage.

**Given** the background Excel export is occurring
**When** a Referee is actively inputting scores
**Then** the export process does not trigger any UI lag or increase the score-save latency above 1 second.

## Epic 3: Multi-Referee Coordination

Admin phân quyền cho nhiều trọng tài cầm điện thoại nhập điểm đồng thời và monitoring họ từ xa.

### Story 3.1: Quản lý Trọng tài (Referee Onboarding)

As a Tournament Admin,
I want to search and invite referees using their ID credentials,
So that they gain temporary scoring privileges for my tournament.

**Acceptance Criteria:**

**Given** the Admin is on the Referee Management screen
**When** they search for an exact Email, Phone, or Username
**Then** they can tap an "Add" button to immediately grant that user Referee privileges for the current tournament.

**Given** a user has been granted Referee privileges
**When** they log into their account
**Then** they can see the assigned tournament under "My Tournaments" without needing Admin setup capabilities.

### Story 3.2: Đồng bộ điểm đa luồng (Concurrent Real-time Scoring)

As an Admin and Referee,
I want the match scores to sync seamlessly across all devices looking at the same match,
So that we can collaboratively score matches from different angles or devices.

**Acceptance Criteria:**

**Given** multiple Referees open the same active match screen
**When** one Referee changes the score
**Then** the new score reflects in real-time across all viewing screens via WebSocket.

**Given** multiple Referees tap to increase the score at the exact same time
**When** the server receives the requests
**Then** the system relies on "Last-Write-Wins" logic without locking the screen, trusting organizers to resolve human disputes verbally on the court.

### Story 3.3: Admin Referee Dashboard

As a Tournament Admin,
I want to monitor which referee is scoring which match in real-time,
So that I can oversee the event's pace without walking to every court.

**Acceptance Criteria:**

**Given** the Admin opens the Referee Dashboard
**When** viewing the connected referee list
**Then** they can see each referee's status as "Active [Match X]" or "Idle".

**Given** the system determines Active status
**When** calculating the state
**Then** it defines "Active" as having submitted at least 1 score update within the last 5 minutes.

## Epic 4: Audience Engagement & Smart Notifications

VĐV và khán giả Follow giải hoặc xem public link để nhận notification realtime về trận đấu của mình.

### Story 4.1: Public Viewer Page & QR Code Stream

As a Viewer,
I want to scan a QR code to see the bracket and live results without logging in,
So that I can effortlessly stay updated on tournament progress from my seat.

**Acceptance Criteria:**

**Given** the Admin has created a tournament
**When** they generate the Public Link or QR Code
**Then** any external user can access a read-only Web interface displaying the Match Queue, recent results, and live Bracket.

**Given** a Viewer is on the Public Viewer Page
**When** looking at the UI
**Then** they see a prompt/CTA encouraging them to "Follow Giải Đấu" for push notifications, leading them to the app install or login.

### Story 4.2: Match Follower Subscription & Push Config

As an Authenticated Viewer or Player,
I want to subscribe to a tournament's updates,
So that my device receives push notifications avoiding the need to constantly check the screen.

**Acceptance Criteria:**

**Given** a logged-in user views a tournament
**When** they tap the "Follow Giải Đấu" button
**Then** their device token is securely mapped to the tournament ID in the database.

**Given** the user accepts Notification permissions
**When** the backend queues a push payload via APNs/FCM
**Then** the notification is delivered with a latency of less than 5 seconds.

### Story 4.3: Tự động Trigger Notifications

As a Player,
I want the system to alert me at match start and during match point,
So that I never miss my scheduled game or a critical final set.

**Acceptance Criteria:**

**Given** a match in PENDING state
**When** a Referee inputs the very first point (state changes to IN_PROGRESS)
**Then** the server dispatched "Trigger 1" push notification idempotently to all followers: "Trận [STT]: [Đội A] vs [Đội B] vừa bắt đầu!".

**Given** a match is in the deciding set
**When** the score reaches a specific threshold (e.g., 18 for a 21-point set, or 28 for a 31-point set)
**Then** the server dispatches "Trigger 2" push notification idempotently: "Set quyết định Trận [STT] đã đến điểm X! Tay vợt trận tiếp theo hãy chuẩn bị."
