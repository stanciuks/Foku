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
- [ ] Add `FocusSession.swift`.
- [ ] Add `FocusSessionManager.swift`.
- [ ] Add `PopoverRootView.swift`.
- [ ] Add `TimerPanelView.swift`.
- [x] Show placeholder Foku pet.
- [x] Show basic timer.
- [x] Add Start Focus button.
- [x] Add Pause/Resume button.
- [x] Add Complete Session button.
- [x] Add Abandon Session button.
- [x] Run the menu bar prototype.
- [x] Take screenshot.
- [x] Commit and push.

## Version 0.2 — Focus session model

- [ ] Add session start time.
- [ ] Add session end time.
- [ ] Add planned duration.
- [ ] Add actual duration.
- [ ] Add completed status.
- [ ] Add abandoned status.
- [ ] Add pause count.
- [ ] Add self-rating placeholder.
- [ ] Show recent session summary.

## Version 0.3 — Local persistence

- [ ] Decide JSON or SwiftData for first saving system.
- [ ] Save completed sessions locally.
- [ ] Load saved sessions when app opens.
- [ ] Save basic user progress.
- [ ] Add reset local data option.
- [ ] Document persistence decision.

## Version 0.4 — XP and levels

- [ ] Add base XP calculation.
- [ ] Add XP multiplier from self-rating.
- [ ] Add total XP.
- [ ] Add level calculation.
- [ ] Add XP progress bar.
- [ ] Show XP earned after session.

## Version 0.5 — Bond and Momentum

- [ ] Add Bond score.
- [ ] Add Momentum score.
- [ ] Increase Bond after completed or honest sessions.
- [ ] Increase Momentum after consistent sessions.
- [ ] Reduce Momentum gently after abandoned or low-quality sessions.
- [ ] Avoid removing earned XP.
- [ ] Add first pet reactions.

## Version 0.6 — Rule engine and state machine

- [ ] Add events.
- [ ] Add rules.
- [ ] Add rule engine.
- [ ] Add activity states.
- [ ] Add emotional states.
- [ ] Add personality setting.
- [ ] Connect rules to XP, Bond, Momentum, state, and dialogue.

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
