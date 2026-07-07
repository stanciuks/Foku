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
