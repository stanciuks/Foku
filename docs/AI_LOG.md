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


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add daily missions to Foku.

### Useful output

- Added a `DailyMission` model.
- Added a `DailyMissionEngine`.
- Added deterministic mission completion checks.
- Added missions for completing a session, earning XP, and setting a study intention.
- Added mission UI to the popover and dashboard.
- Explained that already-completed missions are correct because local progress is saved.

### What I accepted

- Starting with three simple daily missions.
- Calculating missions from local progress.
- Showing missions as Done when saved data already meets the requirements.
- Keeping missions deterministic and not AI-controlled.

### What I changed manually

- Tested the app in Xcode.
- Opened the popover.
- Opened the dashboard.
- Confirmed that daily missions appear.
- Confirmed that missions are already completed because saved progress meets the goals.
- Took evidence screenshots.

### What I rejected or postponed

- Mission rewards.
- Randomized missions.
- AI-generated missions.
- Mission rerolling.
- More advanced daily/weekly challenge logic.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add settings and local data controls to Foku.

### Useful output

- Added a Settings & local data dashboard card.
- Added a reset function for local prototype data.
- Added a confirmation alert before clearing data.
- Added text explaining that the reset does not affect GitHub, source code, screenshots, or documentation.
- Kept the feature local and safe for prototype testing.

### What I accepted

- Showing saved data location as Local UserDefaults.
- Adding a reset button for local prototype data.
- Adding a confirmation alert before reset.
- Explaining that reset only affects local saved progress.

### What I changed manually

- Tested the app in Xcode.
- Opened the dashboard.
- Confirmed that the Settings & local data card appears.
- Checked the reset confirmation without clearing data.
- Took evidence screenshots.

### What I rejected or postponed

- A full settings window.
- Export/import controls.
- Partial resets.
- Cloud sync.
- Account system.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help summarize the current working state of the Foku prototype.

### Useful output

- Created a current build summary.
- Listed working features.
- Listed evidence folders.
- Listed limitations.
- Suggested cleanup and refactoring as the next direction.

### What I accepted

- Keeping the summary as a project documentation file.
- Using the summary to prepare for later report writing and presentation.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help refactor the app by moving the dashboard into its own Swift file.

### Useful output

- Created `DashboardView.swift`.
- Reduced the responsibility of `PopoverRootView.swift`.
- Kept the same dashboard functionality.
- Suggested testing the popover and dashboard before committing.
- Explained that unrelated yellow Xcode system logs could be ignored if the app runs.

### What I accepted

- Moving the dashboard into its own file.
- Keeping the refactor behavior-preserving.
- Testing before committing.
- Committing refactor separately from new feature work.

### What I changed manually

- Ran the refactor script.
- Tested the app in Xcode.
- Opened the menu bar popover.
- Opened the dashboard from the popover.
- Took evidence screenshots.

### What I rejected or postponed

- Refactoring all UI files at once.
- Moving dashboard cards into separate files.
- Changing the dashboard design.
- Adding new features during this refactor.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help refactor the self-rating panel into its own Swift file.

### Useful output

- Created `SelfRatingPanelView.swift`.
- Removed `SelfRatingPanelView` from `PopoverRootView.swift`.
- Kept the same self-rating behavior.
- Suggested testing the self-rating flow before committing.

### What I accepted

- Moving the self-rating panel into its own file.
- Keeping the refactor behavior-preserving.
- Committing it separately from feature work.

### What I changed manually

- Ran the refactor script.
- Tested the app in Xcode.
- Completed a session.
- Confirmed that the self-rating panel still appears.
- Took evidence screenshots.

### What I rejected or postponed

- Redesigning the self-rating panel.
- Moving all popover sections into separate files at once.
- Changing the self-rating options.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help refactor deterministic rule and mission logic into a separate file.

### Useful output

- Created `RuleEngines.swift`.
- Moved `DeterministicRuleEngine`.
- Moved `DailyMissionEngine`.
- Helped diagnose and fix the missing `DailyMission` model error.

### What I accepted

- Moving rule engines out of the model file.
- Keeping `DailyMission` in the model file.
- Fixing the refactor without changing app behavior.
- Testing before committing.

### What I changed manually

- Ran the refactor script.
- Saw Xcode errors about missing `DailyMission`.
- Ran the fix script.
- Tested the app again.
- Confirmed that the app runs.
- Took evidence screenshots.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help create a demo checklist for the current Foku prototype.

### Useful output

- Created `docs/DEMO_CHECKLIST.md`.
- Added a step-by-step demo flow.
- Added a short demo script.
- Added evidence folder suggestions.
- Added fallback notes for possible demo problems.

### What I accepted

- Using the checklist to prepare for Personal Project demonstration.
- Keeping the demo focused on working prototype features.
- Explaining that rewards are deterministic and privacy-safe.


---

## 2026-07-07 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help create an early Personal Project progress reflection draft.

### Useful output

- Created `docs/PERSONAL_PROJECT_PROGRESS_REFLECTION.md`.
- Summarized current working features.
- Described problems and solutions.
- Reflected on responsible AI use.
- Listed future improvements.

### What I accepted

- Keeping the reflection as a draft rather than a final report.
- Using the document to preserve process evidence for later school writing.


---

## 2026-07-09 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a visible pixel-art pet to the Foku prototype.

### Useful output

- Created `PixelPetView.swift`.
- Helped replace the old pet placeholder in the popover and dashboard.
- Diagnosed why the first replacement did not work.
- Corrected the replacement from `petMood.symbol` to `petMood.face`.

### What I accepted

- Adding a simple pixel-art placeholder pet.
- Connecting the pet to existing mood logic.
- Keeping the feature lightweight and local.
- Committing the visual feature separately.

### What I changed manually

- Ran the generated scripts.
- Built and tested the app in Xcode.
- Confirmed that the pet changed visually.
- Took evidence screenshots.

### What I rejected or postponed

- Full polished pixel art.
- Animation.
- Custom colors.
- Pet customization.


---

## 2026-07-09 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add subject tags to the Foku study intention flow.

### Useful output

- Created `SubjectTagPickerView.swift`.
- Added subject tag buttons.
- Used the existing intention system to store subject tags.
- Kept the feature simple for the prototype.

### What I accepted

- Subject tags as intention prefixes for the first version.
- Buttons for common subjects.
- No new database changes in this step.
- Testing before committing.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Confirmed that the subject tags appear and update the intention.
- Took evidence screenshots.

### What I rejected or postponed

- A separate `subjectTag` field in the data model.
- Subject analytics.
- Custom subject editing.
- Charts by subject.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add weekly stats to the Foku dashboard.

### Useful output

- Created `WeeklyStatsView.swift`.
- Added local weekly calculations based on saved completed sessions.
- Helped fix the first insertion attempt when the weekly stats view did not appear.
- Explained that the Xcode question mark meant the new file was untracked by Git.

### What I accepted

- Adding weekly stats as a dashboard card.
- Calculating weekly stats locally.
- Keeping the feature separate from the popover.
- Committing the feature separately.

### What I changed manually

- Ran the generated scripts.
- Built and tested the app in Xcode.
- Confirmed that the weekly stats card appears.
- Took evidence screenshots.

### What I rejected or postponed

- Weekly charts.
- Monthly analytics.
- Subject-based weekly analytics.
- Exporting weekly data.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a subject breakdown section to the Foku dashboard.

### Useful output

- Created `SubjectBreakdownView.swift`.
- Added local subject analytics based on study intention tags.
- Inserted the subject breakdown section into the dashboard.
- Kept the feature compatible with the current prototype data model.

### What I accepted

- Calculating subject breakdown from intention prefixes.
- Showing top subject, subject count, minutes, and sessions.
- Keeping subject analytics local-first.
- Committing the feature separately.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Confirmed that the subject breakdown appears.
- Took evidence screenshots.

### What I rejected or postponed

- Separate `subjectTag` model field.
- Subject charts.
- Custom subject editing.
- Monthly subject analytics.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a 7-day focus chart to the Foku dashboard.

### Useful output

- Created `WeeklyFocusChartView.swift`.
- Added a SwiftUI bar chart.
- Inserted the chart into the dashboard.
- Kept the chart calculated from local completed sessions.

### What I accepted

- Showing a simple 7-day chart.
- Keeping the chart local-first.
- Committing the chart as a separate feature.
- Postponing more advanced analytics.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Confirmed that the 7-day focus chart appears.
- Took evidence screenshots.

### What I rejected or postponed

- Subject-specific chart colors.
- Monthly charts.
- Exportable analytics.
- Complex graph interactions.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add achievements to the Foku dashboard and improve the dashboard layout after the first version looked cramped.

### Useful output

- Created `AchievementsView.swift`.
- Added local achievement calculations.
- Helped identify that the dashboard was using horizontal stacks that made cards too narrow.
- Replaced cramped dashboard rows with adaptive grid layout.
- Improved text wrapping and dashboard window size.

### What I accepted

- Adding prototype achievements.
- Keeping achievements deterministic and local.
- Improving dashboard readability before committing.
- Saving achievements and layout polish together.

### What I changed manually

- Ran generated scripts.
- Built and tested the app in Xcode.
- Confirmed that the achievements section appears.
- Confirmed that the dashboard layout is more readable.
- Took evidence screenshots.

### What I rejected or postponed

- Animated achievements.
- Achievement notifications.
- Custom achievement art.
- Fully polished final dashboard design.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help create a development test plan for the Foku prototype.

### Useful output

- Created `docs/TEST_PLAN.md`.
- Listed manual tests for the core app flow.
- Added dashboard, analytics, privacy, local data, and regression checks.

### What I accepted

- Creating a practical manual test plan before adding more complex features.
- Keeping it separate from the final Personal Project report.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add custom focus duration controls to the Foku popover.

### Useful output

- Created `CustomDurationView.swift`.
- Added a custom duration stepper.
- Helped fix API mismatch errors with `FocusSessionManager`.
- Helped identify and fix a minutes-versus-seconds bug.
- Simplified the UI after the first version duplicated duration buttons.

### What I accepted

- Adding a custom duration control.
- Keeping existing preset buttons.
- Removing duplicate custom quick buttons.
- Fixing the duration unit bug before committing.
- Committing the feature separately.

### What I changed manually

- Ran generated scripts.
- Built and tested the app in Xcode.
- Checked 5m and 65m custom durations.
- Confirmed the timer displays the correct duration.
- Took evidence screenshots.

### What I rejected or postponed

- Saving favorite custom durations.
- Adding a full settings screen for durations.
- Adding custom duration labels.


---

## 2026-07-18 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add a daily focus goal section to the Foku dashboard.

### Useful output

- Created `DailyGoalView.swift`.
- Added a local daily goal using `@AppStorage`.
- Inserted the daily goal section into the dashboard.
- Kept the feature local-first and compatible with Trust Mode.

### What I accepted

- Adding daily goal progress to the dashboard.
- Saving the goal locally.
- Using today's focused minutes from existing progress.
- Committing the feature separately.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Confirmed that the daily goal section appears.
- Tested the goal stepper.
- Took evidence screenshots.

### What I rejected or postponed

- Goal-based notifications.
- Goal streaks.
- Connecting daily goal to achievements.
- Syncing goals across devices.


---

## 2026-07-19 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to connect the daily focus goal feature to achievements.

### Useful output

- Added `Daily Goal Reached` to `AchievementsView`.
- Helped diagnose why it did not unlock at first.
- Explained that running sessions should not count until completed and rated.
- Fixed the achievement to use `sessionManager.progress.today.focusedMinutes`, the same value used by the Daily focus goal card.

### What I accepted

- Adding the achievement as a deterministic local milestone.
- Counting only completed and rated sessions.
- Using the same daily focused minutes source across dashboard and achievements.
- Committing the achievement separately.

### What I changed manually

- Ran the generated scripts.
- Built and tested the app in Xcode.
- Completed and rated a session.
- Confirmed that the achievement unlocks.
- Took evidence screenshots.

### What I rejected or postponed

- Live goal progress during a running session.
- Achievement notifications.
- Animation for achievement unlocks.


---

## 2026-07-19 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help clarify the daily focus goal behavior after noticing that running sessions did not update the goal immediately.

### Useful output

- Updated `DailyGoalView.swift`.
- Added a clearer note explaining that daily goal progress counts completed and rated sessions only.
- Kept the behavior unchanged because it is better for focus integrity.

### What I accepted

- Adding a small clarification instead of changing the core logic.
- Keeping running sessions excluded until completed and rated.
- Treating this as UX polish.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Confirmed that the clarification appears in the dashboard.
- Took an evidence screenshot.


---

## 2026-07-19 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help add optional session reflection notes after self-rating.

### Useful output

- Added `reflectionNote` to the session model.
- Added a reflection note editor to the self-check panel.
- Added recent-session display for reflection notes.
- Helped diagnose and fix several build errors caused by model compatibility changes.
- Helped diagnose why notes did not save at first.
- Fixed `submitSelfRating` so typed notes are saved into the rated recent session.

### What I accepted

- Adding reflection notes as an optional field.
- Showing reflection notes in recent session history.
- Keeping notes local-first.
- Fixing build errors before committing.
- Committing the feature separately after testing.

### What I changed manually

- Ran generated scripts.
- Built and tested the app in Xcode.
- Completed a session.
- Typed a reflection note.
- Submitted a self-rating.
- Confirmed the note appears in recent session history.
- Took evidence screenshots.

### What I rejected or postponed

- AI-generated reflection feedback.
- Reflection prompts that change dynamically.
- Separate reflection analytics.
- Editing old reflection notes.


---

## 2026-07-19 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to polish the self-check panel after adding session reflection notes.

### Useful output

- Rewrote `SelfRatingPanelView.swift`.
- Added a clearer title and explanation.
- Added reflection prompt buttons.
- Improved the note area and self-rating button layout.
- Kept the existing reflection saving and reward logic.

### What I accepted

- Making reflection feel optional and lightweight.
- Adding fixed prompt buttons instead of AI-generated prompts.
- Improving the layout without changing the session model.
- Testing before committing.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Completed a session.
- Tested reflection prompts.
- Confirmed reflection notes still save.
- Took evidence screenshots.

### What I rejected or postponed

- AI-generated reflection prompts.
- Animated rating results.
- A full post-session summary screen.


---

## 2026-07-29 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to add a latest session summary card after self-rating.

### Useful output

- Added `SessionSummaryCardView`.
- Added a summary card after rated sessions.
- Helped replace the old compact `Last session` section.
- Helped fix a SwiftUI `@ViewBuilder` issue in `recentSessionSection`.
- Helped fix the duplicate `Intention: Intention:` display.

### What I accepted

- A local deterministic summary card.
- Showing XP, Time, Bond, Momentum, Rating, Reflection status, and rule summary.
- Keeping this as UI feedback only.
- Not changing the XP or reward calculation logic.

### What I changed manually

- Ran generated scripts.
- Built and tested the app in Xcode.
- Completed a session.
- Added a reflection note.
- Submitted a self-rating.
- Confirmed the summary card appears correctly.
- Took evidence screenshots.

### What I rejected or postponed

- Animated reward reveal.
- AI-generated session feedback.
- A separate full-screen session summary.


---

## 2026-07-29 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to polish the Dashboard Recent sessions section.

### Useful output

- Rewrote the dashboard recent session row layout.
- Added separate metric boxes for Time, Rating, Bond, and Momentum.
- Improved reflection note display.
- Fixed duplicate intention text display.
- Kept all existing session and reward logic unchanged.

### What I accepted

- Cleaner card-style history rows.
- Small metric pills for important session data.
- Keeping deterministic rule summaries visible.
- Treating this as UI polish, not a data model change.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Opened Dashboard.
- Checked Recent sessions.
- Confirmed the cards are easier to read.
- Took evidence screenshots.

### What I rejected or postponed

- Editing old session history items.
- Deleting individual sessions.
- Filtering history by subject.
- Exporting session history.


---

## 2026-07-29 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to extract achievement logic into `AchievementEngine`.

### Useful output

- Created `AchievementEngine.swift`.
- Created the `FokuAchievement` model.
- Rewrote `AchievementsView` to use the engine.
- Fixed the dashboard call from the old argument-based initializer to `AchievementsView()`.
- Helped test that achievements still appear.

### What I accepted

- Separating milestone rules from UI code.
- Keeping achievements deterministic and local.
- Keeping the existing achievement UI, but making the logic easier to maintain.
- Using only two evidence screenshots for this architecture cleanup.

### What I changed manually

- Ran generated scripts.
- Built and tested the app in Xcode.
- Opened Dashboard.
- Confirmed Achievements still show correctly.
- Took evidence screenshots.

### What I rejected or postponed

- Unit tests for achievements.
- Animated achievement unlocks.
- Editable achievement definitions.


---

## 2026-07-29 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to extract subject parsing into `SubjectTagEngine`.

### Useful output

- Created `SubjectTagEngine.swift`.
- Created `SubjectBreakdownItem` and `SubjectBreakdownSummary`.
- Rewrote `SubjectBreakdownView` to use the engine.
- Kept the dashboard UI behavior the same.
- Helped verify that subject breakdown still builds and works.

### What I accepted

- Separating subject parsing from UI code.
- Keeping subject analytics deterministic and local.
- Preserving the same user-facing dashboard section.
- Using only two evidence screenshots for this architecture cleanup.

### What I changed manually

- Ran the generated script.
- Built and tested the app in Xcode.
- Opened Dashboard.
- Confirmed Subject breakdown still works.
- Took evidence screenshots.

### What I rejected or postponed

- Unit tests for subject parsing.
- Custom subject tag management.
- Subject filtering in session history.


---

## 2026-07-30 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to add lightweight `DeterministicRuleEngine` tests.

### Useful output

- Created `tests/DeterministicRuleEngineTests.swift`.
- Created `scripts/run_rule_engine_tests.sh`.
- Added tests for determinism and sensible reward behavior.
- Helped verify that the app still builds after the tests were added.

### What I accepted

- Starting with command-line tests instead of a full Xcode test target.
- Testing XP, Bond, Momentum, pauses, short sessions, and rule summaries.
- Saving terminal test output as evidence.
- Keeping the tests local and deterministic.

### What I changed manually

- Ran the generated script.
- Checked the test output.
- Confirmed the normal app build succeeded.

### What I rejected or postponed

- Creating a formal Xcode test target.
- UI tests.
- Snapshot tests.


---

## 2026-07-30 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to add lightweight `SubjectTagEngine` tests.

### Useful output

- Created `tests/SubjectTagEngineTests.swift`.
- Created `scripts/run_subject_tag_engine_tests.sh`.
- Added tests for bracket parsing, `Other` fallback behavior, mixed-subject sessions, focused-minute totals, top subject selection, and deterministic output.
- Helped verify that the app still builds after adding the tests.

### What I accepted

- Starting with command-line tests instead of a full Xcode test target.
- Testing the extracted subject analytics logic separately from the UI.
- Saving terminal test output as evidence.
- Keeping the tests local and deterministic.

### What I changed manually

- Ran the generated script.
- Checked the test output.
- Confirmed the normal app build succeeded.

### What I rejected or postponed

- Creating a formal Xcode test target.
- UI tests for subject breakdown.
- Subject history filters.


---

## 2026-07-30 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to add lightweight `AchievementEngine` tests.

### Useful output

- Created `tests/AchievementEngineTests.swift`.
- Created `scripts/run_achievement_engine_tests.sh`.
- Added tests for unlock rules, locked states, progress text, unique ids, and deterministic output.
- Helped verify that the app still builds after adding the tests.

### What I accepted

- Starting with command-line tests instead of a full Xcode test target.
- Testing the extracted achievement logic separately from the UI.
- Saving terminal test output as evidence.
- Keeping the tests local and deterministic.

### What I changed manually

- Ran the generated script.
- Checked the test output.
- Confirmed the normal app build succeeded.

### What I rejected or postponed

- Creating a formal Xcode test target.
- UI tests for achievement cards.
- Animated achievement unlock notifications.


---

## 2026-07-30 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to add a combined test runner.

### Useful output

- Created `scripts/run_all_tests.sh`.
- The script runs all lightweight command-line tests.
- The script also runs a normal app build check.
- Helped verify that the full local test suite passes.

### What I accepted

- One test command for all current test scripts.
- Including the app build check in the same runner.
- Saving combined terminal output as evidence.

### What I changed manually

- Ran the generated script.
- Checked the combined test output.
- Confirmed all tests and the app build passed.

### What I rejected or postponed

- Formal Xcode test target setup.
- UI tests.
- Continuous integration setup.


---

## 2026-07-30 — Tool used: ChatGPT

### Task asked

Asked ChatGPT to help redesign the Dashboard manually for the v0.4 polished demo stage.

### Useful output

- Suggested using a safer manual layout instead of another automatic masonry-style layout.
- Reorganized the Dashboard into clearer sections.
- Kept deterministic logic unchanged.
- Helped verify the redesign with the combined test runner.

### What I accepted

- Section-based Dashboard structure.
- Today, analytics, motivation, history, and privacy grouping.
- Keeping the current functionality while improving demo clarity.
- Saving test output as evidence.

### What I rejected or postponed

- Another automatic dashboard layout experiment.
- A full visual redesign of every individual card.
- Final demo screenshots and final v0.4 tag.
