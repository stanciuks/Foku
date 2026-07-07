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
