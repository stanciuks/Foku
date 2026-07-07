# Foku Development Log

This is a rough log, not the final IB report.

## 2026-07-07

### What I worked on

- Started early development planning for Foku before the formal IB documentation period begins in September 2026.
- Created the main Foku folder.
- Created the `/docs` folder.
- Added starter documentation files.
- Added starter Swift files.
- Initialized Git.
- Made the first commit.
- Configured Git username and email.
- Connected the local repository to GitHub.
- Pushed the project to GitHub.
- Replaced the documentation with a cleaner updated version.

### What worked

- Git was initialized successfully.
- The first commit worked.
- GitHub authentication was solved using Homebrew and GitHub CLI.
- The repository is visible on GitHub.

### Problems

- GitHub password authentication did not work because GitHub no longer supports normal account passwords for Git operations.
- Homebrew was not installed at first, so `brew install gh` did not work immediately.

### Solution

- Installed Homebrew.
- Installed GitHub CLI.
- Used `gh auth login`.
- Pushed the repository successfully.

### Evidence to save

- GitHub repository screenshot.
- Terminal output showing commits and push.
- Project folder screenshot.

## Current first development goal

Create the first real macOS app prototype:

- Xcode app named Foku
- SwiftUI
- MenuBarExtra
- popover
- placeholder pet
- timer
- focus session controls

## Future log template

## YYYY-MM-DD

### What I worked on

### What worked

### Problems

### Solution

### Evidence to save

---

## 2026-07-07 — Setup evidence saved

### What I worked on

- Took setup evidence screenshots after creating the Foku repository and documentation structure.
- Saved screenshots showing the GitHub repository, documentation folder, decisions file, commit history, and local project folder.

### Evidence saved

- `evidence/setup/01-github-repo-main.png`
- `evidence/setup/02-github-docs-folder.png`
- `evidence/setup/03-github-decisions.png`
- `evidence/setup/04-github-commits.png`
- `evidence/setup/05-local-foku-folder.png`

---

## 2026-07-07 — Xcode installed and configured

### What I worked on

- Installed Xcode so Foku can be developed as a native macOS SwiftUI application.
- Selected the installed Xcode developer directory using `xcode-select`.
- Checked the installed Xcode version using `xcodebuild -version`.
- Opened Xcode successfully.

### What worked

- Xcode was installed and selected as the active developer tool.
- `xcodebuild -version` confirmed that Xcode is available from Terminal.
- Xcode opened successfully.

### Problems

- Earlier, the app project could not be created because Xcode was not installed yet.

### Solution

- Installed and configured Xcode before continuing with the app creation stage.

### Evidence saved

- `evidence/xcode-setup/06-xcodebuild-version.txt`
- `evidence/xcode-setup/07-xcode-opened.png`

---

## 2026-07-07 — Initial Xcode app created

### What I worked on

- Created the initial Xcode macOS app project named Foku.
- Used SwiftUI as the interface.
- Saved the Xcode project inside the existing Foku project folder.
- Ran the default macOS app once to confirm that the basic Xcode project builds successfully.

### What worked

- Xcode successfully created the app project.
- The default app ran locally on macOS.

### Problems

- None at this stage.

### Solution

- No fix was needed.

### Evidence saved

- `evidence/xcode-initial/08-xcode-initial-file-list.png`
- `evidence/xcode-initial/09-default-xcode-app-running.png`

---

## 2026-07-07 — First menu bar prototype created

### What I worked on

- Replaced the default "Hello, world!" macOS app with the first Foku menu bar prototype.
- Added `MenuBarExtra` so Foku appears in the macOS menu bar.
- Added a popover interface with a placeholder Foku pet.
- Added a basic 25-minute focus timer.
- Added controls for starting, pausing, resuming, completing, abandoning, and resetting a session.
- Added a simple Trust Mode label.
- Added a completed session counter.

### What worked

- The app successfully changed from a normal default window app into a menu bar app.
- The menu bar item opened a Foku popover.
- The timer and session controls worked.

### Problems

- At first, the "Hello, world!" window still appeared because the command edited the wrong Swift files.
- The real Xcode project files were inside `Foku/Foku/`, while the first command edited files one folder above.
- After editing the real files, the build failed because `ObservableObject` / `@Published` needed the correct import.

### Solution

- Found the real Xcode files using Terminal search commands.
- Replaced `Foku/Foku/FokuApp.swift` and `Foku/Foku/ContentView.swift`.
- Added `import Combine`.
- Cleaned/rebuilt the project in Xcode.
- Confirmed that the menu bar prototype ran successfully.

### Evidence saved

- `evidence/menu-bar-prototype/10-foku-menu-bar-visible.png`
- `evidence/menu-bar-prototype/11-foku-popover-idle.png`
- `evidence/menu-bar-prototype/12-foku-timer-running.png`

---

## 2026-07-07 — Menu bar prototype code refactored

### What I worked on

- Refactored the first menu bar prototype so the code is no longer all inside `ContentView.swift`.
- Created separate folders for the early app structure:
  - `Models`
  - `Focus`
  - `UI`
- Moved the temporary session state into `FocusSessionState.swift`.
- Moved timer/session logic into `FocusSessionManager.swift`.
- Moved the popover interface into `PopoverRootView.swift`.
- Moved the timer controls into `TimerPanelView.swift`.
- Kept `FokuApp.swift` responsible for app startup and the menu bar scene.

### What worked

- The app still builds and runs after the refactor.
- The menu bar prototype still opens the Foku popover.
- The timer and basic controls still work.

### Problems

- After creating the folders/files from Terminal, Xcode did not automatically know about the new Swift files.
- This caused errors like `Cannot find PopoverRootView in scope` and `Cannot find FocusSessionManager in scope`.

### Solution

- Added the new `Models`, `Focus`, and `UI` folders to the Xcode project target using:
  - `File → Add Files to "Foku"...`
- Made sure the Foku target was checked.
- Cleaned and rebuilt the project.
- Confirmed that the app works again.

### Evidence saved

- `evidence/refactor/13-xcode-refactored-file-structure.png`
