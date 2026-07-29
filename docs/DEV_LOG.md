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


---

## 2026-07-07 — Daily missions prototype added

### What I worked on

- Added the first daily missions prototype.
- Added `DailyMission` to represent a simple daily goal.
- Added `DailyMissionEngine` to calculate mission completion deterministically.
- Added three starter missions:
  - Complete one focus session
  - Earn 30 XP
  - Set a study intention
- Added a Daily missions section to the menu bar popover.
- Added a Daily missions card to the dashboard.
- Connected mission completion to saved local progress and recent sessions.

### What worked

- Daily missions appear in the popover.
- Daily missions appear in the dashboard.
- Missions show as completed when the saved local data already meets the requirements.
- The missions are calculated from real local progress instead of being fake static UI.
- Existing timer, XP, Bond, Momentum, daily stats, streaks, intention, privacy, dashboard, and session history still work.

### Problems

- Missions are currently hardcoded.
- There are only three missions.
- There is no mission reward yet.
- Because local progress is already saved, the first evidence screenshots show completed missions rather than empty missions.

### Solution

- Keep the first mission system simple and deterministic.
- Use the current saved data as evidence that missions connect to real local progress.
- Later, add mission rewards, more mission types, and a clearer mission reset explanation.

### Evidence saved

- `evidence/daily-missions/40-daily-missions-popover.png`
- `evidence/daily-missions/41-daily-missions-dashboard.png`


---

## 2026-07-07 — Settings and local data controls added

### What I worked on

- Added a Settings & local data card to the dashboard.
- Added a local data reset function to `FocusSessionManager`.
- Added a visible explanation that prototype data is saved locally using UserDefaults.
- Added a reset button for clearing local prototype progress.
- Added a confirmation alert before reset.
- Added text explaining that reset does not delete source code, Git commits, screenshots, or documentation.

### What worked

- The dashboard shows the Settings & local data card.
- The card explains that saved data is local to this Mac.
- The Reset local prototype data button is visible.
- The reset action has a confirmation alert to avoid accidental data loss.
- Existing app features still work.

### Problems

- Data is still saved in UserDefaults rather than a more structured local database.
- The settings card is still basic.
- Reset is all-or-nothing and cannot reset only one category.
- There is not yet a full settings window.

### Solution

- Keep this as a safe prototype data-control feature.
- Use the reset control later to test first-run behavior and empty daily missions.
- Later, add a fuller settings screen with more precise controls.

### Evidence saved

- `evidence/settings-data/42-settings-local-data-card.png`
- `evidence/settings-data/43-reset-confirmation-alert.png`


---

## 2026-07-07 — Current build summary created

### What I worked on

- Created a current build summary document.
- Summarized the working prototype features.
- Listed the current evidence folders.
- Listed current limitations.
- Identified cleanup and refactoring as the next recommended work.

### Why this matters

The prototype now has many connected features. A summary document makes it easier to explain what has been built, what evidence exists, and what still needs improvement.

### Evidence

- `docs/CURRENT_BUILD_SUMMARY.md`


---

## 2026-07-07 — Refactor: DashboardView moved into its own file

### What I worked on

- Refactored the UI code by moving `DashboardView` out of `PopoverRootView.swift`.
- Created a separate `DashboardView.swift` file.
- Kept `PopoverRootView.swift` focused on the menu bar popover.
- Kept the dashboard behavior the same after the refactor.
- Tested that the popover still opens.
- Tested that the dashboard still opens from the popover.

### What worked

- The app still builds and runs.
- The menu bar popover still works.
- The Open Dashboard button still opens the dashboard window.
- Dashboard data still appears correctly.
- The code structure is cleaner than before.

### Problems

- Xcode still shows unrelated yellow macOS system logs such as `com.apple.linkd.autoShortcut`.
- The popover file is still fairly large and can be refactored more later.
- Dashboard cards still live together in one dashboard file.

### Solution

- Ignore unrelated yellow system logs for now because there are no red Swift build errors.
- Keep this refactor small and safe.
- Continue refactoring one file at a time.

### Evidence saved

- `evidence/refactor-dashboard/44-dashboard-file-structure.png`
- `evidence/refactor-dashboard/45-dashboard-after-refactor.png`


---

## 2026-07-07 — Refactor: SelfRatingPanelView moved into its own file

### What I worked on

- Refactored the UI code by moving `SelfRatingPanelView` out of `PopoverRootView.swift`.
- Created a separate `SelfRatingPanelView.swift` file.
- Kept the self-rating behavior the same.
- Tested that the self-rating panel still appears after completing a session.

### What worked

- The app still builds and runs.
- The menu bar popover still works.
- Completing a session still shows the self-rating panel.
- Choosing a self-rating still updates XP, Bond, Momentum, missions, and session history.
- `PopoverRootView.swift` is now smaller and easier to understand.

### Problems

- `PopoverRootView.swift` is still fairly large.
- More UI components can still be separated later.
- No visual redesign was done in this refactor.

### Solution

- Keep this as a small behavior-preserving refactor.
- Continue moving one component at a time instead of changing too much at once.

### Evidence saved

- `evidence/refactor-self-rating/46-self-rating-file-structure.png`
- `evidence/refactor-self-rating/47-self-rating-after-refactor.png`


---

## 2026-07-07 — Refactor: rule engines moved into their own file

### What I worked on

- Refactored rule logic out of `FocusSessionState.swift`.
- Created a separate `RuleEngines.swift` file.
- Moved `DeterministicRuleEngine` into `RuleEngines.swift`.
- Moved `DailyMissionEngine` into `RuleEngines.swift`.
- Kept simple data models in `FocusSessionState.swift`.
- Fixed a missing `DailyMission` model after the first refactor attempt.
- Tested that XP, Bond, Momentum, rule summaries, and daily missions still work.

### What worked

- The app builds and runs again.
- Completing and rating a session still updates XP.
- Bond and Momentum still update.
- Daily missions still appear.
- Rule summary still appears.
- The model file is cleaner because engine logic is now separated.

### Problems

- The first refactor attempt accidentally removed the `DailyMission` model.
- Xcode showed red errors because `RuleEngines.swift` could not find `DailyMission`.
- This was fixed by restoring the `DailyMission` model in `FocusSessionState.swift`.

### Evidence saved

- `evidence/refactor-rule-engines/48-rule-engines-file-structure.png`
- `evidence/refactor-rule-engines/49-rule-engine-after-refactor.png`


---

## 2026-07-07 — Demo checklist created

### What I worked on

- Created a demo checklist for the current Foku prototype.
- Listed the exact demo order.
- Added a short presentation script.
- Added notes for what to show in the popover and dashboard.
- Added fallback notes for common demo issues.

### Why this matters

The prototype now has enough features that it needs a clear demonstration plan. The checklist will help explain the app consistently during Personal Project documentation and presentation preparation.

### Document created

- `docs/DEMO_CHECKLIST.md`


---

## 2026-07-07 — Personal Project progress reflection draft created

### What I worked on

- Created an early Personal Project progress reflection draft.
- Summarized the current Foku prototype.
- Reflected on technical problems and solutions.
- Reflected on responsible AI use.
- Listed current limitations and future improvements.

### Why this matters

The final Personal Project report will be written later, but this draft preserves the development process while it is still fresh.

### Document created

- `docs/PERSONAL_PROJECT_PROGRESS_REFLECTION.md`


---

## 2026-07-09 — Feature: simple pixel-art Foku pet

### What I worked on

- Added a new `PixelPetView.swift` file.
- Replaced the old text-based diamond pet placeholder with a simple pixel-art pet view.
- Connected the pixel pet to the existing `PetMood` system.
- Confirmed that the pet appears in the menu bar popover and dashboard.

### What worked

- The app still builds and runs.
- The old diamond placeholder was replaced.
- The pixel pet appears in the popover.
- The pixel pet appears in the dashboard.
- The pet still uses the deterministic mood state from the app.

### Problems

- The first replacement script did not update the UI because the old placeholder was written as `petMood.face`, not `petMood.symbol`.
- The issue was found by searching for pet mood references in the UI files.
- A second replacement script fixed the correct references.

### Solution

- Added `PixelPetView`.
- Replaced `Text(sessionManager.petMood.face)` with `PixelPetView(mood: sessionManager.petMood)`.
- Kept the mood logic unchanged.

### Evidence saved

- `evidence/pixel-pet/50-pixel-pet-popover.png`
- `evidence/pixel-pet/51-pixel-pet-dashboard.png`


---

## 2026-07-09 — Feature: subject tags for study intentions

### What I worked on

- Added a new `SubjectTagPickerView.swift` file.
- Added subject tag buttons near the study intention field.
- Kept the first version simple by storing the subject tag as part of the intention text.
- Confirmed that clicking a subject adds a prefix such as `[Biology]`, `[Math]`, or `[History]`.
- Confirmed that the feature works with the existing session history system.

### What worked

- The app builds and runs.
- Subject tag buttons appear in the menu bar popover.
- Selecting a subject updates the study intention.
- Existing intention storage and session history can already save the subject tag.
- No new database or persistence system was needed for this version.

### Problems

- This is a simple first version.
- Subject tags are stored inside the intention text instead of as a separate model field.
- This is acceptable for the prototype, but a future version could store `subjectTag` separately.

### Solution

- Use a lightweight subject tag picker.
- Store the tag as a visible prefix in the intention text.
- Keep the feature compatible with the current local persistence model.

### Evidence saved

- `evidence/subject-tags/52-subject-tags-popover.png`
- `evidence/subject-tags/53-subject-tag-history.png`


---

## 2026-07-18 — Feature: weekly stats dashboard card

### What I worked on

- Added a new `WeeklyStatsView.swift` file.
- Added a weekly stats section to the dashboard.
- The dashboard now shows this week's completed sessions, focused minutes, active days, average minutes per active day, and best day.
- Confirmed that the weekly stats card appears in the dashboard.

### What worked

- The app builds and runs.
- The weekly stats view appears in the dashboard.
- Weekly stats are calculated locally from saved completed sessions.
- No server, account, or cloud storage was needed.

### Problems

- The first script created `WeeklyStatsView.swift`, but it did not insert it into `DashboardView.swift`.
- Xcode showed a question mark next to the new file because Git had not tracked it yet.
- A second script inserted the view into the dashboard.

### Solution

- Keep `WeeklyStatsView` as a separate UI file.
- Insert the weekly stats section near the top of the dashboard.
- Commit the new file so the Git question mark disappears.

### Evidence saved

- `evidence/weekly-stats/54-weekly-stats-dashboard.png`
- `evidence/weekly-stats/55-weekly-stats-file-structure.png`


---

## 2026-07-18 — Feature: subject breakdown dashboard section

### What I worked on

- Added a new `SubjectBreakdownView.swift` file.
- Added a subject breakdown section to the dashboard.
- Built on the subject tag feature by reading subject prefixes from study intentions.
- The dashboard now shows top subject, number of subjects, minutes per subject, and sessions per subject.

### What worked

- The app builds and runs.
- The subject breakdown section appears in the dashboard.
- Subject stats are calculated locally from completed tagged sessions.
- No server, account, or cloud storage was needed.
- The feature works with the existing subject tag prototype.

### Problems

- This version still stores the subject tag as part of the intention text.
- This is acceptable for the prototype, but later subject tags could become a separate field in the session model.

### Solution

- Keep the first subject breakdown version simple.
- Read known subject prefixes such as `[Biology]`, `[Math]`, and `[History]`.
- Calculate dashboard subject analytics locally from recent sessions.

### Evidence saved

- `evidence/subject-breakdown/56-subject-breakdown-dashboard.png`
- `evidence/subject-breakdown/57-subject-breakdown-file-structure.png`


---

## 2026-07-18 — Feature: 7-day focus chart

### What I worked on

- Added a new `WeeklyFocusChartView.swift` file.
- Added a 7-day focus chart section to the dashboard.
- The chart shows completed focus minutes for the last 7 days.
- Confirmed that the chart appears in the dashboard.

### What worked

- The app builds and runs.
- The dashboard shows a visual 7-day focus chart.
- Focus minutes are calculated locally from completed sessions.
- The chart fits the local-first and Trust Mode design.

### Problems

- This is a simple first chart.
- It shows only minutes, not subject-specific bars or trends yet.
- Styling is still prototype-level.

### Solution

- Add a lightweight SwiftUI bar chart.
- Calculate values directly from local session history.
- Keep the chart separate in its own UI file.

### Evidence saved

- `evidence/weekly-focus-chart/58-weekly-focus-chart-dashboard.png`
- `evidence/weekly-focus-chart/59-weekly-focus-chart-file-structure.png`


---

## 2026-07-18 — Feature: achievements and dashboard layout polish

### What I worked on

- Added a new `AchievementsView.swift` file.
- Added an achievements section to the dashboard.
- Added prototype milestones such as First Focus, Getting Consistent, One Focus Hour, Subject Explorer, and Three Active Days.
- Polished the dashboard layout after the first version became too cramped.
- Replaced cramped horizontal dashboard rows with adaptive grid layout.
- Increased the dashboard default window size.
- Improved achievement text wrapping.

### What worked

- The app builds and runs.
- The achievements section appears in the dashboard.
- Achievements are calculated locally from saved session history.
- The dashboard cards now wrap into wider rows.
- The dashboard is more readable than the first cramped version.
- The feature still follows the local-first and deterministic design.

### Problems

- The first achievements layout looked too compressed because too many dashboard cards were placed in one horizontal row.
- Text inside achievement cards was difficult to read.
- The dashboard needed a layout improvement before saving final evidence.

### Solution

- Switched the dashboard card layout to adaptive grids.
- Increased the dashboard minimum/default size.
- Improved text wrapping in `AchievementsView`.
- Saved achievements and layout polish together because the layout fix was needed for readable evidence.

### Evidence saved

- `evidence/achievements/60-achievements-dashboard.png`
- `evidence/achievements/61-dashboard-layout-after-polish.png`
- `evidence/achievements/62-achievements-file-structure.png`


---

## 2026-07-18 — Test plan created

### What I worked on

- Created a manual test plan for the Foku prototype.
- Added tests for app launch, focus sessions, dashboard, analytics, privacy, local data, and regression checks.
- Added current stable Git tags.

### Why this matters

The app now has enough features that future changes need a clear test checklist.

### Document created

- `docs/TEST_PLAN.md`


---

## 2026-07-18 — Feature: custom focus duration

### What I worked on

- Added a new `CustomDurationView.swift` file.
- Added a custom focus length control to the menu bar popover.
- Users can now choose a custom duration from 5 to 120 minutes using a stepper.
- Kept the existing 5m, 15m, 25m, and 45m preset buttons as quick choices.
- Confirmed that custom duration controls lock during an active session.

### What worked

- The app builds and runs.
- The custom duration control appears in the popover.
- The user can select custom values such as 5m, 30m, 60m, or 65m.
- Existing preset duration buttons still work.
- The feature uses the existing timer/session system.

### Problems

- The first custom duration version duplicated too many quick duration buttons.
- The first working version also passed minutes directly into the timer where seconds were expected.
- This caused 5 minutes to display as 00:05 and 65 minutes to display as 01:05.

### Solution

- Removed the extra duplicate quick duration row from the custom duration view.
- Kept only a stepper and a Use custom button.
- Fixed the unit bug by converting minutes to seconds before updating the session duration.
- Confirmed that 5m displays as 05:00 and 65m displays as 65:00.

### Evidence saved

- `evidence/custom-duration/63-custom-duration-popover.png`
- `evidence/custom-duration/64-custom-duration-65-minutes.png`
- `evidence/custom-duration/65-custom-duration-locked.png`
- `evidence/custom-duration/66-custom-duration-file-structure.png`


---

## 2026-07-18 — Feature: daily focus goal

### What I worked on

- Added a new `DailyGoalView.swift` file.
- Added a daily focus goal section to the dashboard.
- The dashboard now shows today's focused minutes, the daily goal, progress percentage, and remaining minutes.
- Added a stepper so the user can change the daily goal locally.
- Confirmed that the daily goal section appears and the stepper works.

### What worked

- The app builds and runs.
- The daily focus goal section appears in the dashboard.
- The goal is saved locally using `@AppStorage`.
- The feature does not require an account, backend, cloud sync, or AI.
- The dashboard now gives the user a clearer daily target.

### Problems

- This is a first prototype version.
- The daily goal currently affects dashboard progress only.
- It does not yet connect to achievements, missions, or notifications.

### Solution

- Keep the first version simple and local.
- Use focused minutes from today's local progress.
- Save the goal locally on this Mac.
- Leave deeper integration for a later version.

### Evidence saved

- `evidence/daily-goal/67-daily-goal-dashboard.png`
- `evidence/daily-goal/68-daily-goal-stepper.png`
- `evidence/daily-goal/69-daily-goal-file-structure.png`


---

## 2026-07-19 — Feature: Daily Goal Reached achievement

### What I worked on

- Connected the daily focus goal feature to the achievements system.
- Added a new achievement: `Daily Goal Reached`.
- The achievement unlocks when today's completed and rated focused minutes meet or exceed the local daily goal.
- Fixed the achievement so it uses the same daily focused minutes value as the Daily focus goal card.

### What worked

- The app builds and runs.
- `Daily Goal Reached` appears in the achievements section.
- The achievement unlocks after the user completes and rates enough focus time for the daily goal.
- The feature stays local-first and deterministic.
- No AI, account, backend, or cloud sync is required.

### Problems

- The first version did not unlock after a 15 minute session because it calculated today's minutes differently from the Daily focus goal card.
- The user also expected the goal to update during a running session, but the app correctly counts only completed and rated sessions.

### Solution

- Passed today's focused minutes from `sessionManager.progress.today.focusedMinutes` into `AchievementsView`.
- Used the same value for the Daily focus goal card and the Daily Goal Reached achievement.
- Kept the rule that running sessions do not count until completed and rated.

### Evidence saved

- `evidence/daily-goal-achievement/70-daily-goal-achievement-visible.png`
- `evidence/daily-goal-achievement/71-daily-goal-achievement-unlocked.png`
- `evidence/daily-goal-achievement/72-daily-goal-achievement-code.png`


---

## 2026-07-19 — UX polish: daily goal counting clarification

### What I worked on

- Updated the Daily focus goal section text.
- Clarified that daily goal progress counts completed and rated sessions only.
- Reduced confusion because running sessions do not immediately count toward the daily goal.

### What worked

- The app builds and runs.
- The Daily focus goal section now explains the counting rule.
- The rule matches the app behavior: running sessions are not counted until completed and rated.

### Why this matters

This improves user understanding. The daily goal feature could feel broken if a user expects a running session to count immediately. The new note explains the rule directly in the dashboard.

### Evidence saved

- `evidence/daily-goal-clarification/73-daily-goal-clarification.png`


---

## 2026-07-19 — Feature: session reflection notes

### What I worked on

- Added optional reflection notes to the self-check flow after a completed session.
- Added a reflection note field to `SelfRatingPanelView`.
- Added `reflectionNote` support to the `FocusSession` model.
- Made reflection notes backward-compatible with older saved sessions.
- Updated recent session history so saved reflection notes can appear in the dashboard.

### What worked

- The app builds and runs.
- After completing a session, the user can type a short reflection note before choosing a self-rating.
- The reflection note is saved into the rated session.
- The dashboard recent session history can show `Reflection: ...`.
- Existing session behavior still works.

### Problems

- The first implementation changed the `FocusSession` model too aggressively and temporarily removed compatibility properties used elsewhere in the app.
- This caused several build errors, including missing `intentionText`, `statusText`, `selfRating`, `abandoned`, `pauseCount`, `actualMinutesRoundedDown`, `actualSeconds`, and `ratingText`.
- The reflection note also did not appear at first because the typed note was not being written into `recentSessions[0]` during `submitSelfRating`.

### Solution

- Restored compatibility properties in `FocusSession`.
- Added `actualSeconds` support back into the model.
- Rewrote the dashboard session history row so it handles reflection notes correctly.
- Updated `submitSelfRating` so the typed reflection note is saved into the rated recent session.
- Tested the full flow after the fixes.

### Evidence saved

- `evidence/session-reflection-notes/74-reflection-note-self-check.png`
- `evidence/session-reflection-notes/75-reflection-note-recent-session.png`
- `evidence/session-reflection-notes/76-reflection-note-code.png`
- `evidence/session-reflection-notes/77-reflection-note-build-working.png`


---

## 2026-07-19 — UX polish: self-check panel

### What I worked on

- Polished the self-check panel shown after completing a focus session.
- Renamed the section to `Session self-check`.
- Added a clearer explanation that reflection is optional.
- Added quick reflection prompt buttons:
  - `What helped?`
  - `What distracted me?`
  - `Next time...`
- Increased the reflection note text area size.
- Made the self-rating buttons easier to read.

### What worked

- The app builds and runs.
- The self-check panel appears after completing a session.
- Reflection prompt buttons insert text into the reflection note.
- The user can still submit a self-rating.
- Reflection notes still save and appear in Recent sessions.
- Reward calculation still happens after self-rating.

### Problems

- The earlier self-check panel worked, but it looked too plain after reflection notes were added.
- The rating buttons and note field needed clearer structure.

### Solution

- Rewrote `SelfRatingPanelView.swift` with clearer hierarchy and spacing.
- Kept the same underlying session logic.
- Treated this as UX polish, not a new data model change.

### Evidence saved

- `evidence/self-check-polish/78-self-check-polished.png`
- `evidence/self-check-polish/79-self-check-prompts.png`
- `evidence/self-check-polish/80-self-check-reflection-saved.png`


---

## 2026-07-29 — Feature: latest session summary card

### What I worked on

- Added a post-rating summary card for the latest completed session.
- The card appears after the user submits a self-rating.
- It summarizes the latest session using:
  - actual focus time
  - XP earned
  - Bond change
  - Momentum change
  - self-rating
  - reflection saved status
  - deterministic rule summary

### What worked

- The app builds and runs.
- After completing and rating a session, the popover shows a `Last session summary` card.
- The card uses separate visual blocks for Time, Bond, and Momentum.
- Reflection status is shown clearly.
- The duplicate `Intention: Intention:` display issue was fixed.

### Problems

- The first version appeared as the old compact `Last session` text block.
- A replacement script initially placed `SessionSummaryCardView` inside a normal computed property without `@ViewBuilder`, which caused a SwiftUI build error.
- The computed property `recentSessionSection` needed to be treated as a view builder because it uses conditional SwiftUI content.

### Solution

- Added `SessionSummaryCardView`.
- Replaced the old compact recent-session block in the popover.
- Fixed `recentSessionSection` using `@ViewBuilder`.
- Retested the flow after rating a completed session.

### Evidence saved

- `evidence/session-summary-card/81-session-summary-card-popover.png`
- `evidence/session-summary-card/82-session-summary-card-reflection-saved.png`
- `evidence/session-summary-card/83-session-summary-card-code.png`
- `evidence/session-summary-card/84-session-summary-card-build-working.png`


---

## 2026-07-29 — UX polish: Dashboard Recent sessions

### What I worked on

- Polished the Dashboard `Recent sessions` section.
- Replaced the more raw session row layout with cleaner card-style rows.
- Added separate mini-metrics for:
  - Time
  - Rating
  - Bond
  - Momentum
- Added a clearer XP badge.
- Made reflection notes easier to read inside session history cards.
- Cleaned the intention display so it does not show duplicate `Intention:` text.

### What worked

- The app builds and runs.
- Dashboard recent sessions now appear as cleaner cards.
- The main session information is easier to scan.
- Reflection notes are visually separated from other session details.
- The deterministic rule summary is still visible.
- Existing session data still loads.

### Problems

- The old recent session row became harder to read after reflection notes and summary information were added.
- Too much information was compressed into one text line.
- The intention display could duplicate the word `Intention:`.

### Solution

- Rewrote `sessionHistoryRow` in `DashboardView.swift`.
- Added a `historyMetricPill` helper for small dashboard history metrics.
- Preserved the same saved session data and reward logic.
- Treated this as UI polish only.

### Evidence saved

- `evidence/recent-sessions-polish/85-recent-sessions-polished-dashboard.png`
- `evidence/recent-sessions-polish/86-recent-session-reflection-card.png`
- `evidence/recent-sessions-polish/87-recent-sessions-code.png`
- `evidence/recent-sessions-polish/88-recent-sessions-build-working.png`


---

## 2026-07-29 — Architecture cleanup: AchievementEngine

### What I worked on

- Extracted achievement milestone logic out of `AchievementsView`.
- Added a new model-layer file: `AchievementEngine.swift`.
- Added a `FokuAchievement` model for achievement display data.
- Updated `AchievementsView` so it mostly handles presentation.
- Updated `DashboardView` to use the new no-argument `AchievementsView()`.

### What worked

- The app builds and runs.
- Dashboard achievements still appear.
- Daily goal, reflection, intention, XP, Bond, Momentum, and streak achievements still make sense.
- Achievement logic is now easier to test later because it is separated from the SwiftUI view.

### Problems

- After extracting the logic, `DashboardView` still used the old initializer:
  `AchievementsView(sessions:focusedMinutesToday:)`.
- This caused a build error because the new `AchievementsView` reads from `EnvironmentObject` instead.

### Solution

- Replaced the old `AchievementsView(...)` call with `AchievementsView()`.
- Kept the same dashboard integration through the existing `sessionManager` environment object.
- Confirmed that the feature builds and works.

### Evidence saved

- `evidence/achievement-engine/89-achievements-dashboard.png`
- `evidence/achievement-engine/90-achievement-engine-code.png`


---

## 2026-07-29 — Architecture cleanup: SubjectTagEngine

### What I worked on

- Extracted subject-tag parsing and subject breakdown logic out of `SubjectBreakdownView`.
- Added a new model-layer file: `SubjectTagEngine.swift`.
- Added `SubjectBreakdownItem` and `SubjectBreakdownSummary` models.
- Updated `SubjectBreakdownView` so it mostly handles presentation.
- Kept the visual Subject breakdown section working in Dashboard.

### What worked

- The app builds and runs.
- Dashboard Subject breakdown still appears.
- Existing subjects still show.
- Top subject and total subject count still make sense.
- The subject breakdown logic is now easier to test later because it is separated from the SwiftUI view.

### Problems

- Before this refactor, subject parsing and UI presentation were mixed inside the same view.
- This made the subject breakdown feature harder to test and harder to expand.

### Solution

- Created `SubjectTagEngine.summary(from:)`.
- Created reusable subject parsing with `subjects(from:)` and `bracketTags(from:)`.
- Rewrote `SubjectBreakdownView` to use the engine output.
- Preserved local-only, deterministic analytics.

### Evidence saved

- `evidence/subject-tag-engine/91-subject-breakdown-dashboard.png`
- `evidence/subject-tag-engine/92-subject-tag-engine-code.png`


---

## 2026-07-30 — Testing: DeterministicRuleEngine

### What I worked on

- Added lightweight command-line tests for `DeterministicRuleEngine`.
- Added a test runner script:
  - `scripts/run_rule_engine_tests.sh`
- Added test source:
  - `tests/DeterministicRuleEngineTests.swift`

### What the tests check

- Identical input gives identical XP, Bond, Momentum, and rule summary.
- A focused completed session earns positive XP.
- A weaker rating does not beat a focused rating.
- Extra pauses do not improve Momentum compared with the same focused session.
- A much shorter actual session does not earn more XP than a full focused session.
- Rule results include a readable rule summary.

### What worked

- The tests passed.
- The normal app build also succeeded after adding the tests.
- The tests support the project claim that reward calculation is deterministic and rule-based.

### Problems

- This is not yet a formal Xcode test target.
- The tests currently run from a shell script using `swiftc`.

### Solution

- Kept the first version lightweight so it can be run quickly from Terminal.
- Saved the test output as project evidence.
- Left formal Xcode unit test target setup for later.

### Evidence saved

- `evidence/rule-engine-tests/93-rule-engine-tests-output.txt`
- `evidence/rule-engine-tests/94-app-build-after-rule-tests.txt`


---

## 2026-07-30 — Testing: SubjectTagEngine

### What I worked on

- Added lightweight command-line tests for `SubjectTagEngine`.
- Added a test runner script:
  - `scripts/run_subject_tag_engine_tests.sh`
- Added test source:
  - `tests/SubjectTagEngineTests.swift`

### What the tests check

- Bracket tags are extracted, cleaned, deduplicated, and sorted.
- Empty intentions produce no subject.
- Non-tagged intentions are grouped under `Other`.
- Mixed-subject sessions count for each bracket tag.
- Focused minutes are totaled by subject.
- Top subject is selected by focused minutes.
- Summary output is deterministic for identical input.

### What worked

- The tests passed.
- The normal app build succeeded after adding the tests.
- The tests support the project claim that subject analytics are deterministic and local.

### Problems

- These are lightweight command-line tests, not a formal Xcode test target yet.

### Solution

- Kept the test runner simple and fast.
- Saved the test output and build output as project evidence.
- Left formal Xcode unit test target setup for later.

### Evidence saved

- `evidence/subject-tag-engine-tests/95-subject-tag-engine-tests-output.txt`
- `evidence/subject-tag-engine-tests/96-app-build-after-subject-tests.txt`


---

## 2026-07-30 — Testing: AchievementEngine

### What I worked on

- Added lightweight command-line tests for `AchievementEngine`.
- Added a test runner script:
  - `scripts/run_achievement_engine_tests.sh`
- Added test source:
  - `tests/AchievementEngineTests.swift`

### What the tests check

- Achievement ids are unique.
- Rated sessions unlock the first self-check achievement.
- Daily goal achievement unlocks when focused minutes reach the goal.
- Reflection achievement unlocks when a rated session has a reflection note.
- Intention achievement unlocks when a rated session has an intention.
- XP, Bond, Momentum, and streak achievements unlock at their thresholds.
- Locked achievements remain locked without progress.
- Progress text is sensible.
- Output is deterministic for identical input.

### What worked

- The tests passed.
- The normal app build succeeded after adding the tests.
- The tests support the project claim that achievement logic is deterministic and local.

### Problems

- These are lightweight command-line tests, not a formal Xcode test target yet.

### Solution

- Kept the test runner simple and fast.
- Saved the test output and build output as project evidence.
- Left formal Xcode unit test target setup for later.

### Evidence saved

- `evidence/achievement-engine-tests/97-achievement-engine-tests-output.txt`
- `evidence/achievement-engine-tests/98-app-build-after-achievement-tests.txt`


---

## 2026-07-30 — Testing: combined test runner

### What I worked on

- Added a combined test runner:
  - `scripts/run_all_tests.sh`

### What it runs

- `DeterministicRuleEngine` tests
- `SubjectTagEngine` tests
- `AchievementEngine` tests
- Normal app build check with `xcodebuild`

### What worked

- All three command-line test suites passed.
- The normal app build succeeded.
- The project now has one command that checks the main deterministic engines and the app build.

### Why this matters

- It makes future testing faster.
- It gives a simple way to prove that the main rule-based logic still works.
- It supports the project claim that rewards, subject analytics, and achievements are deterministic and local.

### Evidence saved

- `evidence/all-tests-runner/99-all-tests-runner-output.txt`


---

## 2026-07-30 — Milestone: v0.3 study companion features

### What I worked on

- Updated the README with the current prototype status.
- Ran the combined test runner before tagging.
- Prepared the project for the `v0.3-study-companion-features` milestone tag.

### What is included in this milestone

- Focus sessions, custom duration, intentions, subject tags, self-rating, and reflection notes.
- XP, Level, Bond, Momentum, pet mood, pixel pet, missions, goals, achievements, and dashboard analytics.
- Dashboard subject breakdown, recent sessions, weekly stats, chart, and summary card.
- Extracted `AchievementEngine` and `SubjectTagEngine`.
- Lightweight tests for rule engine, subject tag engine, and achievement engine.
- Combined test runner.

### Evidence saved

- `evidence/version-tags/100-v0.3-all-tests-output.txt`


---

## 2026-07-30 — v0.4 polish: manual Dashboard redesign

### What I worked on

- Reworked the Dashboard layout manually after the earlier automatic layout experiment was not good enough.
- Organized the dashboard into clearer demo sections:
  - Today at a glance
  - Study analytics
  - Motivation system
  - History
  - Privacy and local data
- Kept existing app logic unchanged.
- Ran the combined test runner after the redesign.

### What improved

- The Dashboard now tells a clearer product story.
- Important metrics are grouped more naturally.
- Goal, progress, pet state, analytics, achievements, history, and privacy are easier to explain during a demo.
- The layout is more stable than the earlier masonry-style experiment.

### What worked

- The app built successfully.
- The full local test suite passed.
- The redesign did not change deterministic scoring, subject analytics, achievements, or persistence logic.

### Evidence saved

- `evidence/dashboard-v04-manual/101-dashboard-v04-top.png` if screenshot was found locally
- `evidence/dashboard-v04-manual/102-dashboard-v04-middle.png` if screenshot was found locally
- `evidence/dashboard-v04-manual/103-dashboard-v04-tests-output.txt`


---

## 2026-07-30 — v0.4 polish: simple pixel pet baseline

### What I worked on

- Replaced the earlier over-detailed pixel pet experiment with a simpler cleaner mascot.
- Kept the pet monochrome for now so the shape and face can be judged before adding colours or accessories.
- Preserved the existing mood label and accessibility label.
- Kept pet logic unchanged.

### What improved

- The mascot is less cluttered.
- The face is clearer.
- The pet fits better inside both the menu bar popover and Dashboard Pet state card.
- This creates a better baseline for later mood colours, level-based accessories, and achievement unlocks.

### What worked

- The full local test suite passed.
- The app build succeeded.
- No deterministic scoring, achievement, subject analytics, persistence, or rule-engine logic was changed.

### Evidence saved

- `evidence/pixel-pet-v04/104-simple-pixel-pet-tests-output.txt`


---

## 2026-07-30 — v0.4 polish: first-run onboarding

### What I worked on

- Added a first-run onboarding card to the menu bar popover.
- The card explains the basic Foku flow:
  - set an intention
  - focus honestly
  - reflect and grow
- Added a Trust Mode privacy note.
- Made the card dismissible with local storage using `@AppStorage`.

### What improved

- New users get a clearer explanation of how to use the app.
- The app is easier to demo because the main concept is visible immediately.
- The privacy promise is shown before the user starts using the timer.

### What worked

- The onboarding card appeared in the popover.
- The dismiss button worked.
- The timer and Dashboard still worked.
- The full local test suite passed.

### Evidence saved

- `evidence/onboarding-v04/105-first-run-onboarding-tests-output.txt`
