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

