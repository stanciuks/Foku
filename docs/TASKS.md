# Foku Tasks

## Completed setup tasks

- [x] Create main Foku folder.
- [x] Create `/docs` folder.
- [x] Add starter documentation.
- [x] Add starter Swift file structure.
- [x] Initialize Git.
- [x] Make first commit.
- [x] Configure Git username and email.
- [x] Connect project to GitHub.
- [x] Push project to GitHub.
- [x] Replace documentation with updated Foku plan.
- [x] Install Xcode.
- [x] Select Xcode developer directory with `xcode-select`.
- [x] Save Xcode version evidence.
- [x] Open Xcode successfully.

## Current milestone: Version 0.1 — Menu bar prototype

Goal: create the first real macOS app prototype.

- [x] Create Xcode macOS app project named `Foku`.
- [x] Save it inside the existing Foku folder.
- [x] Run the default Xcode app once.
- [x] Commit the initial Xcode project.
- [x] Replace the default window app with a `MenuBarExtra`.
- [ ] Add `AppState.swift`.
- [x] Add `FocusSessionState.swift`.
- [x] Add `FocusSessionManager.swift`.
- [x] Add `PopoverRootView.swift`.
- [x] Add `TimerPanelView.swift`.
- [x] Show placeholder Foku pet.
- [x] Show basic timer.
- [x] Add Start Focus button.
- [x] Add Pause/Resume button.
- [x] Add Complete Session button.
- [x] Add Abandon Session button.
- [x] Run the menu bar prototype.
- [x] Take screenshot.
- [x] Commit and push.
- [x] Refactor prototype code into `Models`, `Focus`, and `UI` folders.
- [x] Add new Swift files to the Xcode target.
- [x] Confirm the refactored menu bar app still builds and runs.


## Version 0.2 — Focus session model

- [x] Add session start time.
- [x] Add session end time.
- [x] Add planned duration.
- [x] Add actual duration.
- [x] Add completed status.
- [x] Add abandoned status.
- [x] Add pause count.
- [x] Add self-rating placeholder.
- [x] Show recent session summary.



## Version 0.2 progress notes

- [x] Added early `FocusSession` model.
- [x] Added temporary in-memory recent session tracking.
- [x] Added last session summary to the popover.
- [x] Added self-rating panel after completed or abandoned sessions.
- [x] Fixed duplicate Xcode folder/build file warnings.
- [x] Confirmed the app still runs after project cleanup.
- [x] Add self-rating placeholder.
- [ ] Decide how local saving should work.

## Version 0.3 — Local persistence

- [ ] Decide JSON or SwiftData for first saving system.
- [ ] Save completed sessions locally.
- [ ] Load saved sessions when app opens.
- [ ] Save basic user progress.
- [ ] Add reset local data option.
- [ ] Document persistence decision.

## Version 0.4 — XP and levels

- [x] Add base XP calculation.
- [x] Add XP multiplier from self-rating.
- [x] Add total XP.
- [x] Add level calculation.
- [x] Add XP progress bar.
- [x] Show XP earned after session.



## Version 0.4 progress notes

- [x] Added early `UserProgress` model.
- [x] Added total XP.
- [x] Added level calculation.
- [x] Added XP progress bar.
- [x] Added XP earned to last session summary.
- [x] Connected XP calculation to self-rating.
- [ ] Move XP logic into a separate service later.
- [ ] Save XP locally later.

## Version 0.5 — Bond and Momentum

- [x] Add Bond score.
- [x] Add Momentum score.
- [x] Increase Bond after completed or honest sessions.
- [x] Increase Momentum after consistent sessions.
- [x] Reduce Momentum gently after abandoned or low-quality sessions.
- [x] Avoid removing earned XP.
- [ ] Add first pet reactions.



## Version 0.5 progress notes

- [x] Added early Bond value.
- [x] Added early Momentum value.
- [x] Connected Bond and Momentum updates to self-rating.
- [x] Displayed Bond and Momentum in the popover UI.
- [ ] Move Bond logic into a dedicated service later.
- [ ] Move Momentum logic into a dedicated service later.
- [ ] Connect Bond and Momentum to the rule engine later.
- [ ] Add first pet reactions based on Bond and Momentum.

## Version 0.6 — Rule engine and state machine

- [ ] Add events.
- [ ] Add rules.
- [ ] Add rule engine.
- [ ] Add activity states.
- [ ] Add emotional states.
- [ ] Add personality setting.
- [ ] Connect rules to XP, Bond, Momentum, state, and dialogue.



## Version 0.6 progress notes

- [x] Added `FokuSaveData` model.
- [x] Added local saving with `UserDefaults`.
- [x] Saved XP locally.
- [x] Saved Bond locally.
- [x] Saved Momentum locally.
- [x] Saved completed session count locally.
- [x] Saved recent sessions locally.
- [x] Loaded saved data on app launch.
- [ ] Add a better long-term storage system later if needed.
- [ ] Add a reset/debug screen later.

## Version 0.7 — Pixel pet animation

- [ ] Add placeholder pixel pet.
- [ ] Add idle animation.
- [ ] Add studying animation.
- [ ] Add happy animation.
- [ ] Add concerned animation.
- [ ] Add celebrating animation.

## Version 0.8 — Dashboard

- [ ] Add dashboard view.
- [ ] Show total focus time.
- [ ] Show sessions.
- [ ] Show XP and level.
- [ ] Show Bond.
- [ ] Show Momentum.
- [ ] Show streak.
- [ ] Show recent sessions.

## Version 0.9 — Optional Focus Guard

- [ ] Add Focus Guard toggle.
- [ ] Add privacy explanation.
- [ ] Check only frontmost app name during active sessions.
- [ ] Store app-level distraction data locally.
- [ ] Add reset/delete option.

## Not yet

Do not build these until the local core works:

- [ ] AI dialogue
- [ ] AI summaries
- [ ] Backend
- [ ] Cloud sync
- [ ] Leaderboards
- [ ] Shared challenges
- [ ] Payments
- [ ] Licensing
- [ ] Public website distribution
- [ ] App Store release


## Version 0.7 progress notes

- [x] Added daily stats model.
- [x] Added today's completed sessions.
- [x] Added today's focused minutes.
- [x] Added today's XP.
- [x] Added current streak and best streak.
- [x] Added simple local-day reset logic.
- [x] Added Today section to the popover.
- [x] Added ScrollView to the popover after the UI became too tall.
- [ ] Improve dashboard layout later.
- [ ] Add weekly stats later.



## Version 0.8 progress notes

- [x] Added a separate dashboard window.
- [x] Added Open Dashboard button to the menu bar popover.
- [x] Added dashboard cards for Progress, Pet state, Today, Streaks, and Rule transparency.
- [x] Connected dashboard to the same local session manager.
- [ ] Move dashboard view into its own file later.
- [ ] Improve dashboard visual design later.
- [ ] Add charts later.



## Version 0.9 progress notes

- [x] Added preset session duration controls.
- [x] Added 5, 15, 25, and 45 minute focus lengths.
- [x] Connected selected duration to the timer.
- [x] Locked duration changes during active sessions.
- [ ] Add custom duration later if needed.
- [ ] Save preferred default duration later.



## Version 0.10 progress notes

- [x] Added Recent sessions card to the dashboard.
- [x] Added saved session rows.
- [x] Added date/time display for session rows.
- [x] Added XP, Bond, Momentum, rating, and rule summary to session history.
- [x] Made dashboard scrollable.
- [ ] Add filters later.
- [ ] Add full history storage later.
- [ ] Move dashboard to a separate file later.



## Version 0.11 progress notes

- [x] Added Trust Mode label.
- [x] Added Privacy section to the popover.
- [x] Added Privacy & modes card to the dashboard.
- [x] Explained local-only saved data.
- [x] Explained that Focus Guard is not enabled in this prototype.
- [x] Explained that Foku does not collect websites, messages, files, screen content, keyboard activity, or browsing history.
- [ ] Add settings screen later.
- [ ] Add optional Focus Guard later.



## Version 0.12 progress notes

- [x] Added study intention field.
- [x] Saved intention into each session.
- [x] Locked intention changes during active sessions.
- [x] Displayed intention in the popover last session section.
- [x] Displayed intention in dashboard recent session history.
- [x] Fixed backward-compatible decoding for older saved sessions.
- [ ] Add subject tags later.
- [ ] Add filters by intention later.



## Version 0.13 progress notes

- [x] Added daily missions prototype.
- [x] Added `DailyMission`.
- [x] Added `DailyMissionEngine`.
- [x] Added Complete one focus session mission.
- [x] Added Earn 30 XP mission.
- [x] Added Set a study intention mission.
- [x] Added daily missions to popover.
- [x] Added daily missions to dashboard.
- [x] Connected missions to real saved local progress.
- [ ] Add mission rewards later.
- [ ] Add more mission variety later.



## Version 0.14 progress notes

- [x] Added Settings & local data card.
- [x] Showed saved data location as Local UserDefaults.
- [x] Added reset local prototype data button.
- [x] Added confirmation alert before reset.
- [x] Explained that reset does not affect source code, Git commits, screenshots, or documentation.
- [ ] Add full settings window later.
- [ ] Add export/import later.
- [ ] Add partial reset options later.



## Refactor progress notes

- [x] Moved `DashboardView` into `DashboardView.swift`.
- [x] Reduced `PopoverRootView.swift` responsibility.
- [x] Confirmed popover still works.
- [x] Confirmed dashboard still opens.
- [ ] Move `SelfRatingPanelView` into its own file later.
- [ ] Move reusable dashboard cards into their own components later.
- [ ] Move rule engine out of the model file later.



## Refactor progress notes — self-rating panel

- [x] Moved `SelfRatingPanelView` into `SelfRatingPanelView.swift`.
- [x] Confirmed self-rating still appears after completing a session.
- [x] Confirmed this was a behavior-preserving refactor.
- [ ] Move reusable popover metric blocks later.
- [ ] Move mission row UI later.



## Refactor progress notes — rule engines

- [x] Created `RuleEngines.swift`.
- [x] Moved `DeterministicRuleEngine` into `RuleEngines.swift`.
- [x] Moved `DailyMissionEngine` into `RuleEngines.swift`.
- [x] Restored `DailyMission` as a model after a refactor error.
- [x] Confirmed XP, Bond, Momentum, and daily missions still work.
- [ ] Add unit tests for rule engine later.
- [ ] Add unit tests for mission engine later.



## Visual design progress notes — pixel pet

- [x] Added `PixelPetView.swift`.
- [x] Replaced the old diamond placeholder.
- [x] Connected the pet view to `PetMood`.
- [x] Confirmed the pixel pet appears in the popover.
- [x] Confirmed the pixel pet appears in the dashboard.
- [ ] Improve the pet art later.
- [ ] Add mood-specific animations later.
- [ ] Add a more polished pet design later.



## Feature progress notes — subject tags

- [x] Added `SubjectTagPickerView.swift`.
- [x] Added subject buttons near the study intention field.
- [x] Stored subject tags as intention prefixes.
- [x] Confirmed subject tags appear in the popover.
- [x] Confirmed subject tags can be saved through existing session history.
- [ ] Store subject tags as a separate field later.
- [ ] Add subject-based analytics later.
- [ ] Add custom subject editing later.



## Feature progress notes — weekly stats

- [x] Added `WeeklyStatsView.swift`.
- [x] Added a weekly stats card to the dashboard.
- [x] Show completed sessions for the current week.
- [x] Show focused minutes for the current week.
- [x] Show active days for the current week.
- [x] Show average minutes per active day.
- [x] Show best day.
- [x] Confirmed the feature appears in the dashboard.
- [ ] Add weekly charts later.
- [ ] Add subject-based weekly stats later.



## Feature progress notes — subject breakdown

- [x] Added `SubjectBreakdownView.swift`.
- [x] Added a subject breakdown section to the dashboard.
- [x] Calculated subject stats from tagged study intentions.
- [x] Show top subject.
- [x] Show subject count.
- [x] Show minutes per subject.
- [x] Show sessions per subject.
- [x] Confirmed the subject breakdown appears in the dashboard.
- [ ] Store subject tags as a separate model field later.
- [ ] Add subject charts later.
- [ ] Add monthly subject breakdown later.



## Feature progress notes — 7-day focus chart

- [x] Added `WeeklyFocusChartView.swift`.
- [x] Added a 7-day focus chart to the dashboard.
- [x] Show completed focus minutes by day.
- [x] Calculate chart data locally from session history.
- [x] Confirmed the chart appears in the dashboard.
- [ ] Add subject-specific charting later.
- [ ] Add monthly chart later.
- [ ] Add chart polish later.



## Feature progress notes — achievements and dashboard layout

- [x] Added `AchievementsView.swift`.
- [x] Added First Focus achievement.
- [x] Added Getting Consistent achievement.
- [x] Added One Focus Hour achievement.
- [x] Added Subject Explorer achievement.
- [x] Added Three Active Days achievement.
- [x] Calculated achievements locally from session history.
- [x] Improved dashboard layout after cards became too cramped.
- [x] Replaced cramped horizontal rows with adaptive grid rows.
- [x] Confirmed achievements appear in the dashboard.
- [ ] Add achievement notifications later.
- [ ] Add achievement icons later.
- [ ] Further polish dashboard spacing later.



## Feature progress notes — custom focus duration

- [x] Added `CustomDurationView.swift`.
- [x] Added a custom duration stepper.
- [x] Kept existing preset duration buttons.
- [x] Removed duplicate custom quick duration buttons.
- [x] Fixed minutes-to-seconds conversion.
- [x] Confirmed 5m displays as 05:00.
- [x] Confirmed 65m displays as 65:00.
- [x] Confirmed duration controls lock during an active session.
- [ ] Add saved favorite durations later.
- [ ] Add custom duration validation message later if needed.



## Feature progress notes — daily focus goal

- [x] Added `DailyGoalView.swift`.
- [x] Added a daily focus goal section to the dashboard.
- [x] Show today's focused minutes.
- [x] Show current daily goal.
- [x] Show goal progress percentage.
- [x] Show remaining minutes.
- [x] Added local goal stepper.
- [x] Confirmed the feature appears in the dashboard.
- [ ] Connect daily goal to achievements later.
- [ ] Connect daily goal to missions later.
- [ ] Add goal streaks later.



## Feature progress notes — Daily Goal Reached achievement

- [x] Added `Daily Goal Reached` to achievements.
- [x] Connected the achievement to the local daily focus goal.
- [x] Used `sessionManager.progress.today.focusedMinutes` as the shared source.
- [x] Confirmed running sessions do not count until completed and rated.
- [x] Confirmed the achievement unlocks after meeting the daily goal.
- [ ] Add achievement notifications later.
- [ ] Add achievement unlock animation later.



## UX polish notes — daily goal clarification

- [x] Added a note to the Daily focus goal section.
- [x] Clarified that daily goal progress counts completed and rated sessions only.
- [x] Kept running sessions excluded until completed and rated.
- [x] Confirmed the clarification appears in the dashboard.



## Feature progress notes — session reflection notes

- [x] Added optional reflection note field to the self-check panel.
- [x] Added `reflectionNote` to `FocusSession`.
- [x] Added backward-compatible decoding for older saved sessions.
- [x] Added reflection note display to recent session history.
- [x] Fixed model compatibility errors after the first implementation.
- [x] Fixed saving so `submitSelfRating` writes the typed note into the rated session.
- [x] Confirmed reflection notes appear in recent sessions.
- [ ] Add editable reflection notes later.
- [ ] Add reflection prompt variations later.
- [ ] Add reflection analytics later.



## UX polish notes — self-check panel

- [x] Updated `SelfRatingPanelView.swift`.
- [x] Added clearer `Session self-check` title.
- [x] Added optional reflection explanation.
- [x] Added reflection prompt buttons.
- [x] Increased reflection note text area size.
- [x] Improved self-rating button layout.
- [x] Confirmed reflection notes still save.
- [ ] Add post-session summary card later.
- [ ] Add better reward reveal later.



## Feature progress notes — latest session summary card

- [x] Add latest session summary card after self-rating.
- [x] Show XP earned in the summary card.
- [x] Show actual focused time in the summary card.
- [x] Show Bond and Momentum changes separately.
- [x] Show reflection saved status.
- [x] Fix old compact `Last session` display.
- [x] Fix SwiftUI view-builder issue.
- [x] Confirm the feature builds and works.
- [ ] Add animated reward reveal later.
- [ ] Add richer post-session encouragement later.
