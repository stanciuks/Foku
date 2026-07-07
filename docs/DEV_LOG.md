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


---

## 2026-07-07 — Basic focus session model added

### What I worked on

- Added an early `FocusSession` model.
- Added session properties such as:
  - session ID
  - start time
  - end time
  - planned duration
  - actual duration
  - completed status
  - abandoned status
  - pause count
  - mode used
- Updated `FocusSessionManager` so it creates a session when focus starts.
- Updated the manager so completing or abandoning a session stores it in a temporary in-memory recent sessions list.
- Added a "Last session" section to the popover UI.
- Tested the flow:
  - Start Focus
  - Pause
  - Resume
  - Complete
- Cleaned duplicate Xcode folder references.
- Fixed the Xcode target so each new Swift file is included in Compile Sources exactly once.

### What worked

- The app still builds and runs.
- A new session is created when the timer starts.
- Pause count updates when the user pauses.
- Completing a session adds it to the recent sessions list.
- The popover shows a last session summary.
- The Xcode navigator is cleaner after removing duplicate folders.
- Duplicate build warnings were removed.

### Problems

- Sessions are currently stored only in memory.
- If the app quits, recent sessions are lost.
- Self-rating is not implemented yet.
- XP, Bond, Momentum, and rule engine logic are not implemented yet.
- Xcode initially showed duplicate folder references and duplicate build warnings after the new files were added.
- After removing duplicate references, some files had to be added back to the Foku target's Compile Sources list.

### Solution

- Removed duplicate folder references without moving files to Trash.
- Added the needed Swift files back to the Foku target.
- Confirmed that the app runs without red errors.
- Local persistence will be added later after the session model is stable.

### Evidence saved

- `evidence/session-model/14-session-tracking-completed.png`
- `evidence/session-model/15-session-tracking-files.png`


---

## 2026-07-07 — Self-rating step added

### What I worked on

- Added a `SelfRating` enum with three options:
  - Focused
  - Partly distracted
  - Did not really study
- Added self-rating storage to the `FocusSession` model.
- Updated `FocusSessionManager` so the latest finished session can be rated.
- Added a self-check panel that appears after a completed or abandoned session.
- Updated the last session summary so it shows the selected rating.
- Tested the flow:
  - Start Focus
  - Complete
  - Choose a self-rating

### What worked

- The self-check panel appears after a session ends.
- The user can choose a rating.
- The selected rating is saved in the latest in-memory session.
- The last session summary updates after the rating is selected.

### Problems

- Self-ratings are still stored only in memory.
- Ratings do not yet affect XP, Bond, or Momentum.
- There is no rule engine yet.

### Solution

- Keep self-rating as a simple first step.
- Use this later as an input for XP quality, Bond changes, Momentum changes, and rule-based pet reactions.

### Evidence saved

- `evidence/self-rating/16-self-rating-panel.png`
- `evidence/self-rating/17-self-rating-selected.png`


---

## 2026-07-07 — First XP and level system added

### What I worked on

- Added an early `UserProgress` model.
- Added total XP tracking.
- Added level tracking.
- Added XP progress inside the current level.
- Added XP needed for the next level.
- Added XP calculation based on:
  - planned session duration
  - completed or abandoned status
  - self-rating quality multiplier
- Updated the Foku popover to show:
  - Level
  - Total XP
  - XP progress bar
  - XP toward the next level
- Updated the last session summary so it shows XP earned.

### What worked

- XP updates after the user chooses a self-rating.
- Focused sessions earn the full calculated XP.
- Partly distracted sessions earn reduced XP.
- Sessions marked as "Did not really study" earn very low XP.
- Abandoned sessions are reduced using a completion multiplier.
- Level remains at 1 for now because the XP threshold is 100 XP.
- The last session summary shows the XP earned.

### Problems

- XP is still stored only in memory.
- XP is not saved after quitting the app.
- The XP rules are still inside `FocusSessionManager`, not a separate XP service or rule engine.
- Bond and Momentum are not implemented yet.

### Solution

- Keep this as the first simple XP prototype.
- Later, move XP calculation into a dedicated `XPService`.
- Later, make the rule engine decide when XP should be calculated.
- Add local persistence before relying on XP as long-term progress.

### Evidence saved

- `evidence/xp-levels/18-xp-before-rating-or-self-check.png`
- `evidence/xp-levels/19-xp-after-rating.png`


---

## 2026-07-07 — First Bond and Momentum prototype added

### What I worked on

- Added early Bond and Momentum values to Foku's progress system.
- Connected Bond and Momentum changes to the session self-rating step.
- Updated the popover UI so Bond and Momentum are visible next to XP and level progress.
- Tested the flow:
  - Start Focus
  - Complete session
  - Choose a self-rating
  - Observe XP, Bond, and Momentum updates

### What worked

- Bond updates after the user submits a self-rating.
- Momentum updates after the user submits a self-rating.
- The values are visible in the popover UI.
- The app still builds and runs.

### Problems

- Bond and Momentum are still stored only in memory.
- The update rules are still temporary and are not yet inside a dedicated rule engine.
- The values do not yet affect dialogue, unlockables, missions, or pet animations.

### Solution

- Keep Bond and Momentum as simple prototype values for now.
- Later, move their logic into dedicated services or deterministic rules.
- Later, connect them to Foku's emotional state, dialogue, missions, and unlockables.

### Evidence saved

- `evidence/bond-momentum/20-bond-momentum-before-rating.png`
- `evidence/bond-momentum/21-bond-momentum-after-rating.png`


---

## 2026-07-07 — Local persistence added

### What I worked on

- Added simple local persistence for Foku progress.
- Added a `FokuSaveData` model to store saved app data.
- Saved progress using local `UserDefaults` storage.
- Saved:
  - total XP
  - level
  - XP progress
  - Bond
  - Momentum
  - completed session count
  - recent sessions
- Loaded saved data when the app starts.
- Tested that progress stays after quitting and reopening the app.

### What worked

- XP stays saved after quitting and reopening.
- Bond stays saved after quitting and reopening.
- Momentum stays saved after quitting and reopening.
- Recent session data stays available after reopening.
- The app still works offline and does not need an account or server.

### Problems

- `UserDefaults` is simple and good for the prototype, but not the best long-term storage for larger history.
- There is not yet a full settings/reset/debug screen.
- The save system does not yet include migration logic for future data model changes.

### Solution

- Use `UserDefaults` for the first prototype because it is simple, local, and offline-capable.
- Later, move session history to a stronger local storage approach if needed.
- Keep the app local-first and privacy-safe.

### Evidence saved

- `evidence/local-persistence/22-local-persistence-before-quit.png`
- `evidence/local-persistence/23-local-persistence-after-reopen.png`


---

## 2026-07-07 — First deterministic rule engine added

### What I worked on

- Added the first deterministic rule engine.
- Moved the main reward decision into a named rule engine structure.
- Added `SessionRuleResult` so one rule result can contain:
  - XP earned
  - Bond change
  - Momentum change
  - message
  - rule summary
- Added `PetMood` so Foku can visually react to progress.
- Added a rule engine section to the popover.
- Updated the last session summary so it shows XP, Bond change, and Momentum change.
- Kept the system local-first and deterministic.
- Fixed the popover window height after the first version opened too small.

### What worked

- The app builds and runs.
- Completing and rating a session still updates XP, Bond, and Momentum.
- The rule engine section shows the rule result after rating.
- The pet mood changes based on saved Bond and Momentum values.
- Progress still saves locally after quitting and reopening the app.

### Problems

- The first generated popover frame used an invalid SwiftUI argument combination.
- After removing height completely, the menu window collapsed into a thin bar.
- The rule engine is still stored in the same model file, not separated into its own folder yet.
- The current rules are still early prototype values.

### Solution

- Changed the popover frame to a valid fixed size.
- Kept the rule engine simple for now.
- Later, the rule engine can be moved into a dedicated `Rules` folder or service file.
- Later, the rules can become clearer and easier to test.

### Evidence saved

- `evidence/rule-engine/24-rule-engine-before-rating.png`
- `evidence/rule-engine/25-rule-engine-after-rating.png`


---

## 2026-07-07 — Daily stats, streaks, and scrollable popover added

### What I worked on

- Added daily study stats to the local progress model.
- Added today's completed sessions.
- Added today's focused minutes.
- Added today's XP.
- Added current streak.
- Added best streak.
- Added day tracking using a local `yyyy-MM-dd` day key.
- Updated the app so daily stats reset when a new day starts.
- Updated the app so a completed session can update the current streak.
- Updated the popover UI to show a new Today section.
- Added a `ScrollView` to the popover because the content became taller than the fixed menu window.

### What worked

- Completing and rating a session updates today's session count.
- Completing and rating a session updates today's XP.
- Current streak becomes 1 after the first completed session of the day.
- Best streak also updates.
- The popover is now scrollable, so all sections can be reached.
- Existing XP, Bond, Momentum, rule engine, and persistence still work.

### Problems

- Focused minutes show 0 if the session is completed immediately because minutes are rounded down.
- The popover is getting crowded.
- The streak logic is still simple and should be tested more later.
- There is no dashboard yet.

### Solution

- Keep the current daily stats as a prototype.
- Use screenshots to show the first working version.
- Later, create a proper dashboard window for larger stats.
- Later, improve the UI layout so the menu bar popover stays simple.

### Evidence saved

- `evidence/daily-stats/26-daily-stats-before-rating.png`
- `evidence/daily-stats/27-daily-stats-after-rating.png`
- `evidence/daily-stats/28-scrollable-popover.png`


---

## 2026-07-07 — Dashboard window prototype added

### What I worked on

- Added a separate Foku Dashboard window.
- Added a second app scene using `WindowGroup`.
- Added an "Open Dashboard" button inside the menu bar popover.
- Added a larger dashboard layout for progress information.
- Moved larger overview information into a better space instead of forcing everything into the small menu bar popover.
- Added dashboard cards for:
  - Progress
  - Pet state
  - Today
  - Streaks
  - Rule transparency

### What worked

- The menu bar popover still opens.
- The "Open Dashboard" button opens a separate dashboard window.
- The dashboard shows saved XP, level, Bond, Momentum, today stats, streaks, and rule summary.
- The dashboard uses the same local session manager as the menu bar popover.
- Local persistence still works.

### Problems

- The dashboard is still a prototype.
- There are no charts yet.
- The dashboard layout is basic.
- The dashboard currently lives in `PopoverRootView.swift`; it should later be moved into its own file.
- There is no weekly or monthly view yet.

### Solution

- Keep the dashboard simple for now.
- Use this as evidence that Foku is becoming more than a timer.
- Later, separate dashboard UI into its own file and add better visual design.

### Evidence saved

- `evidence/dashboard/29-dashboard-button.png`
- `evidence/dashboard/30-dashboard-window.png`


---

## 2026-07-07 — Session duration controls added

### What I worked on

- Added focus length options to the timer panel.
- Added preset duration buttons:
  - 5 minutes
  - 15 minutes
  - 25 minutes
  - 45 minutes
- Added `setPlannedDuration(_:)` to `FocusSessionManager`.
- Made the selected duration update the timer before a session starts.
- Locked duration changes while a session is running or paused.
- Added a small message when the focus length is changed.

### What worked

- The timer changes when a duration button is selected.
- The selected duration is used when starting a new focus session.
- Duration buttons are disabled while studying.
- The app still builds and runs.
- XP calculation still uses the planned duration of the session.

### Problems

- Duration options are currently hardcoded.
- There is no custom duration input yet.
- The duration buttons make the popover slightly busier.

### Solution

- Keep simple preset durations for now.
- Add custom duration only later if needed.
- Use this feature to support short restart sessions and longer study blocks.

### Evidence saved

- `evidence/session-duration/31-duration-options.png`
- `evidence/session-duration/32-duration-locked-during-session.png`


---

## 2026-07-07 — Recent session history added to dashboard

### What I worked on

- Added a Recent sessions card to the Foku Dashboard.
- Displayed the latest saved sessions from local storage.
- Added session rows showing:
  - completed or abandoned status
  - session date and time
  - actual minutes and planned minutes
  - self-rating
  - XP earned
  - Bond change
  - Momentum change
  - rule summary
- Made the dashboard scrollable so the session history can fit below the existing cards.

### What worked

- The dashboard opens normally.
- Recent sessions are visible in the dashboard.
- Completing and rating a new session adds it to the history list.
- Saved recent sessions still load after reopening the app.
- The dashboard now gives a clearer overview of real study activity.

### Problems

- The session history is still basic.
- It only shows the latest sessions, not a full searchable history.
- There are no filters yet.
- The dashboard view still lives inside `PopoverRootView.swift`.

### Solution

- Keep the first history view simple.
- Store only recent sessions for now.
- Later, move the dashboard into its own file and add better history filtering.

### Evidence saved

- `evidence/session-history/33-session-history-dashboard.png`
- `evidence/session-history/34-session-history-after-new-session.png`


---

## 2026-07-07 — Privacy and Trust Mode transparency added

### What I worked on

- Added a Privacy section to the menu bar popover.
- Added a Privacy & modes card to the dashboard.
- Added clear Trust Mode text explaining what Foku saves locally.
- Added text explaining that Focus Guard is not enabled in this prototype.
- Added text explaining that Foku does not collect websites, messages, files, screen content, keyboard activity, or browsing history.
- Updated the mode label so it says Trust Mode instead of only Trust.

### What worked

- The popover shows a Privacy section.
- The dashboard shows a Privacy & modes card.
- The app clearly communicates that current tracking is local and limited.
- Existing timer, XP, Bond, Momentum, rule engine, daily stats, dashboard, and session history still work.

### Problems

- Focus Guard is not implemented yet.
- There is no settings screen yet.
- Privacy text is currently static.
- The dashboard UI is becoming large and should later be split into separate Swift files.

### Solution

- Keep Trust Mode as the clear default.
- Show privacy information before adding any optional monitoring features.
- Later, add a real settings screen for Trust Mode, Focus Guard, and Strict Mode.

### Evidence saved

- `evidence/privacy-mode/35-popover-privacy-section.png`
- `evidence/privacy-mode/36-dashboard-privacy-card.png`


---

## 2026-07-07 — Study intention field added

### What I worked on

- Added a study intention field before starting a focus session.
- Added `sessionIntention` to `FocusSessionManager`.
- Added `intention` to the `FocusSession` model.
- Saved the typed intention into each new session.
- Locked the intention field while a session is running or paused.
- Showed the intention in the last session section.
- Showed the intention in the dashboard recent session history.
- Added backward-compatible decoding for older saved sessions that did not have an intention field yet.

### What worked

- The user can type a study intention before starting a session.
- The intention is saved with the session.
- The intention appears in the last session section.
- The intention appears in dashboard session history.
- The intention field is locked during an active session.
- Older locally saved sessions no longer break decoding because missing intention values default to an empty string.

### Problems

- Older saved sessions created before this update did not contain the new `intention` key.
- Xcode still shows some unrelated yellow system logs such as `com.apple.linkd.autoShortcut`, but these are not app-breaking errors.
- The intention is plain text only.
- There are no tags or subject categories yet.

### Solution

- Added custom decoding for `FocusSession`.
- Used `decodeIfPresent` for the new intention field.
- Kept intention simple and local-only.
- Later, subject tags or templates can be added.

### Evidence saved

- `evidence/session-intention/37-intention-field.png`
- `evidence/session-intention/38-intention-locked-during-session.png`
- `evidence/session-intention/39-intention-in-history.png`
