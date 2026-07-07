# AI Assistance Log

This file records how AI tools help with Foku.

## Source of truth

The source of truth is:

1. Xcode project
2. GitHub repository
3. `/docs` folder

AI tools can help, but they should not randomly redesign the project.

## Rules for AI use

- Ask for one small task at a time.
- Paste relevant existing files before asking for code changes.
- Test AI-generated code in Xcode.
- Commit working changes often.
- Do not let AI add unrelated features.
- Do not let AI control XP, Bond, Momentum, progression, rewards, or pet state.
- Do not let AI add backend, monetization, or AI features unless specifically requested.

## 2026-07-07 — ChatGPT

### Task asked

Asked ChatGPT to help plan and set up the Foku project before creating the Xcode app.

### Useful output

- Created project structure plan.
- Created documentation structure.
- Helped with Git setup.
- Helped with GitHub authentication problem.
- Helped define build order.
- Helped separate IB version from future commercial version.

### What I accepted

- `/docs` structure
- GitHub from the beginning
- local-first app strategy
- no paid Apple Developer Program during IB stage
- Trust Mode first
- AI as optional enhancement only
- build app first, final documentation later

### What I changed manually

- Ran Terminal commands.
- Installed Homebrew.
- Installed GitHub CLI.
- Authenticated GitHub.
- Pushed repository.

### What I rejected or postponed

- backend
- cloud sync
- AI dialogue
- payments
- App Store release
- public website distribution

## Standard AI handoff prompt

You are helping me with Foku, a native macOS SwiftUI menu bar study app with a pixel-art pet. Do not redesign the whole app. Only help with the specific task I give. Follow the existing architecture. Keep the system rule-based and deterministic. Do not add AI-controlled logic, server features, monetization, or unrelated files unless I ask. Explain what each changed file does.

## Future AI log template

## YYYY-MM-DD — Tool used:

### Task asked

### Useful output

### What I accepted

### What I changed manually

### What I rejected

### Files affected

---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help replace the default Xcode "Hello, world!" app with the first Foku menu bar prototype.

### Useful output

- Generated a first `MenuBarExtra` prototype.
- Added a basic Foku popover.
- Added a temporary focus timer.
- Added start, pause, resume, complete, abandon, and reset controls.
- Helped debug why the wrong files were edited.
- Helped fix the `ObservableObject` / `@Published` build error by adding `import Combine`.

### What I accepted

- The first menu bar prototype structure.
- The temporary in-file `FocusSessionManager`.
- The basic timer and Trust Mode UI.
- The debugging commands for finding the real Xcode files.

### What I changed manually

- Ran the commands locally.
- Rebuilt the app in Xcode.
- Took evidence screenshots.

### What I rejected or postponed

- Real pixel art.
- Local persistence.
- XP, Bond, Momentum.
- Rule engine.
- State machine.
- Dashboard.
- AI features.
- Backend features.

### Files affected

- `Foku/Foku/FokuApp.swift`
- `Foku/Foku/ContentView.swift`

---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help clean up the first working menu bar prototype by separating the code into a more organized file structure.

### Useful output

- Suggested separating the prototype into `Models`, `Focus`, and `UI` folders.
- Generated separate Swift files for:
  - `FocusSessionState.swift`
  - `FocusSessionManager.swift`
  - `PopoverRootView.swift`
  - `TimerPanelView.swift`
- Helped identify that Xcode needed the new files added to the project target.

### What I accepted

- The early file separation.
- Keeping the current timer logic temporary but organized.
- Adding the new files to the Xcode target manually.

### What I changed manually

- Added the new folders/files to the Xcode project using `File → Add Files to "Foku"...`.
- Cleaned and rebuilt the project in Xcode.
- Confirmed that the app still runs.

### What I rejected or postponed

- More advanced architecture.
- Local persistence.
- XP, Bond, Momentum.
- Rule engine.
- Pixel-art animation.
- Dashboard.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help move the prototype from a simple timer toward real focus session tracking.

### Useful output

- Added an early `FocusSession` model.
- Updated `FocusSessionManager` to create and finish sessions.
- Added in-memory recent session tracking.
- Added a "Last session" section to the popover UI.
- Helped identify and fix duplicate Xcode folder/build references.
- Kept the implementation simple and local-first.

### What I accepted

- The first `FocusSession` structure.
- Temporary in-memory recent session tracking.
- The updated popover summary.
- Cleaning the Xcode project structure before taking evidence.
- Keeping persistence, XP, Bond, Momentum, and rule engine for later.

### What I changed manually

- Tested the app in Xcode.
- Confirmed that Start, Pause, Resume, and Complete work.
- Removed duplicate build references in Xcode.
- Added the needed Swift files back to the Foku target.
- Took evidence screenshots.

### What I rejected or postponed

- Local persistence.
- Self-rating.
- XP calculation.
- Bond and Momentum.
- Rule engine.
- Dashboard.
- Focus Guard.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a self-rating step after each session.

### Useful output

- Added a `SelfRating` enum.
- Added self-rating to the `FocusSession` model.
- Updated `FocusSessionManager` so the latest session can be rated.
- Added a self-check panel to the popover.
- Kept the feature deterministic and local-first.

### What I accepted

- The three self-rating options.
- The self-check panel appearing after a session ends.
- The idea that self-rating will later influence XP, Bond, and Momentum.
- Keeping the current version in-memory only.

### What I changed manually

- Tested the feature in Xcode.
- Completed a session and selected a self-rating.
- Took evidence screenshots.

### What I rejected or postponed

- XP calculation from rating.
- Bond changes from rating.
- Momentum changes from rating.
- Rule engine integration.
- Local persistence.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add the first XP and level calculation based on self-rating.

### Useful output

- Added an early `UserProgress` model.
- Added total XP and level values.
- Added a simple level progress bar.
- Added XP calculation from session duration, completion status, and self-rating.
- Updated the popover UI so XP and level progress are visible.

### What I accepted

- The first simple XP formula.
- The level threshold of 100 XP for the early prototype.
- The use of self-rating multipliers:
  - Focused = 1.0
  - Partly distracted = 0.7
  - Did not really study = 0.1
- The idea that abandoned sessions should earn reduced XP instead of removing XP.

### What I changed manually

- Tested the app in Xcode.
- Completed a session and selected a self-rating.
- Confirmed that Total XP and Last session XP updated correctly.
- Took evidence screenshots.

### What I rejected or postponed

- Local persistence for XP.
- Separate `XPService`.
- Rule engine integration.
- Bond system.
- Momentum system.
- Dashboard.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add the first Bond and Momentum prototype after XP and self-rating were working.

### Useful output

- Added early Bond and Momentum values.
- Connected Bond and Momentum updates to the self-rating step.
- Updated the popover UI so the user can see Bond and Momentum.
- Kept the feature deterministic and local-first.

### What I accepted

- Treating Bond as the relationship/connection score with Foku.
- Treating Momentum as the recent consistency/study rhythm score.
- Keeping both systems simple before adding the full rule engine.

### What I changed manually

- Tested the app in Xcode.
- Completed a session and submitted a self-rating.
- Confirmed that Bond and Momentum update.
- Took evidence screenshots.

### What I rejected or postponed

- Dedicated BondService and MomentumService.
- Rule engine integration.
- Local persistence.
- Missions and unlockables based on Bond/Momentum.
- Dialogue changes based on Bond/Momentum.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add simple local persistence so Foku progress stays saved after quitting and reopening the app.

### Useful output

- Added a `FokuSaveData` model.
- Added local save/load logic using `UserDefaults`.
- Connected saving to XP, Bond, Momentum, completed sessions, and recent sessions.
- Kept the implementation local-first and offline-capable.

### What I accepted

- Using `UserDefaults` for the first prototype.
- Saving the current progress model and recent sessions.
- Loading saved progress when `FocusSessionManager` starts.
- Keeping more advanced storage for later.

### What I changed manually

- Tested the app in Xcode.
- Completed a session and selected a self-rating.
- Quit and reopened the app.
- Confirmed that XP, Bond, and Momentum stayed saved.
- Took evidence screenshots.

### What I rejected or postponed

- Cloud sync.
- User accounts.
- Server database.
- Large session-history database.
- Data migration system.
- Full settings/reset screen.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add the first deterministic rule engine to Foku.

### Useful output

- Added `SessionRuleResult`.
- Added `DeterministicRuleEngine`.
- Added rule-based XP, Bond, and Momentum changes.
- Added pet mood states.
- Added a visible rule summary to the popover.
- Helped fix the SwiftUI popover sizing bug.

### What I accepted

- Keeping rewards rule-based rather than AI-based.
- Showing the rule summary inside the app for transparency.
- Adding pet mood as a deterministic result of Bond and Momentum.
- Keeping the first rule engine simple and local.

### What I changed manually

- Tested the app in Xcode.
- Fixed the collapsed menu window by using a fixed valid frame height.
- Completed and rated a session.
- Confirmed XP, Bond, Momentum, rule summary, and pet mood work.
- Took evidence screenshots.

### What I rejected or postponed

- AI-generated rewards.
- Complex rule configuration.
- Unit tests for the rule engine.
- Moving the rule engine into a separate file.
- Strict Mode and Focus Guard integration.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add daily stats, streaks, and fix the popover after it became too tall.

### Useful output

- Added `DailyStudyStats`.
- Added current streak and best streak values.
- Added daily reset logic using a local day key.
- Added streak update logic after completed sessions.
- Added the Today section to the popover.
- Added a `ScrollView` to make the popover content reachable.

### What I accepted

- Tracking today's sessions, minutes, and XP.
- Tracking current streak and best streak.
- Rounding focused minutes down for now.
- Making the popover scrollable instead of increasing the window too much.

### What I changed manually

- Tested the app in Xcode.
- Completed and rated a session.
- Confirmed daily stats and streaks update.
- Confirmed the popover is scrollable.
- Took evidence screenshots.

### What I rejected or postponed

- A full dashboard window.
- More detailed weekly statistics.
- Charts.
- Calendar view.
- More advanced streak rules.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a separate dashboard window for Foku.

### Useful output

- Added a `WindowGroup` scene for the dashboard.
- Added an "Open Dashboard" button in the menu bar popover.
- Added a dashboard UI with separate cards.
- Used the existing `FocusSessionManager` so the dashboard shows the same local state.
- Kept the menu bar popover and dashboard connected.

### What I accepted

- Adding a separate dashboard window.
- Showing larger statistics outside the small popover.
- Adding cards for progress, pet state, today stats, streaks, and rule transparency.
- Keeping the dashboard prototype simple.

### What I changed manually

- Tested the app in Xcode.
- Opened the menu bar popover.
- Clicked the Open Dashboard button.
- Confirmed that the dashboard window opened.
- Took evidence screenshots.

### What I rejected or postponed

- Charts.
- Weekly analytics.
- Monthly analytics.
- More advanced dashboard design.
- Moving dashboard UI into a separate Swift file.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add session duration controls to Foku.

### Useful output

- Added duration buttons to the timer panel.
- Added preset focus lengths.
- Added a `setPlannedDuration(_:)` method.
- Made duration choices affect the timer.
- Disabled duration changes during active sessions.

### What I accepted

- Preset duration options of 5, 15, 25, and 45 minutes.
- Locking duration changes while a session is running or paused.
- Keeping the feature simple and deterministic.

### What I changed manually

- Tested the app in Xcode.
- Selected different focus lengths.
- Started a session.
- Confirmed the duration buttons were disabled while studying.
- Took evidence screenshots.

### What I rejected or postponed

- Custom typed duration.
- Saved preferred duration.
- More advanced session templates.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add recent session history to the dashboard.

### Useful output

- Added a Recent sessions card.
- Added rows for saved recent sessions.
- Added date/time formatting for session history.
- Displayed XP, Bond change, Momentum change, rating, and rule summary.
- Made the dashboard scrollable.

### What I accepted

- Showing the latest five recent sessions.
- Keeping session history inside the dashboard.
- Showing rule summaries in the history for transparency.
- Keeping the first history version simple.

### What I changed manually

- Tested the app in Xcode.
- Opened the dashboard.
- Completed and rated another session.
- Confirmed the new session appeared in the Recent sessions card.
- Took evidence screenshots.

### What I rejected or postponed

- Full history database.
- Search or filtering.
- Weekly grouping.
- Export.
- Moving dashboard UI into a separate file.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add privacy and Trust Mode transparency to Foku.

### Useful output

- Added Trust Mode text.
- Added a Privacy section to the popover.
- Added a Privacy & modes card to the dashboard.
- Added a clear statement that Focus Guard is not enabled in this prototype.
- Added a clear statement that websites, messages, files, screen content, keyboard activity, and browsing history are not collected.

### What I accepted

- Showing privacy information directly inside the UI.
- Keeping the current mode as Trust Mode.
- Making privacy text static for this prototype.
- Making optional Focus Guard a later feature.

### What I changed manually

- Tested the app in Xcode.
- Opened the popover.
- Opened the dashboard.
- Confirmed that the privacy sections appear.
- Took evidence screenshots.

### What I rejected or postponed

- Focus Guard.
- Strict Mode.
- Settings screen.
- Permission prompts.
- App monitoring.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a study intention or topic field to sessions.

### Useful output

- Added a text field for study intention.
- Added intention storage to `FocusSession`.
- Added intention display in the popover and dashboard history.
- Locked the intention field during active sessions.
- Fixed backward compatibility for older saved sessions without the new intention field.

### What I accepted

- Using a simple plain text intention field.
- Saving the intention locally with each session.
- Showing the intention in session history.
- Keeping intention locked once the session starts.
- Using backward-compatible decoding.

### What I changed manually

- Tested the app in Xcode.
- Typed a study intention.
- Started and completed a session.
- Rated the session.
- Confirmed that the intention appeared in the last session and dashboard history.
- Confirmed that the old `keyNotFound: intention` warning disappeared.
- Took evidence screenshots.

### What I rejected or postponed

- AI-generated session goals.
- Subject tagging.
- Custom templates.
- Searching or filtering by intention.
