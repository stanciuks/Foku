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
