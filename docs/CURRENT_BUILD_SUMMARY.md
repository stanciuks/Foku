# Foku current build summary

Date: 2026-07-07

This document summarizes the current working prototype of Foku after the first major app-building phase.

## Current app type

Foku is currently a native macOS SwiftUI menu bar app with a separate dashboard window.

Current app structure:

```text
Menu bar popover = quick focus controls
Dashboard window = larger progress overview
Local storage = UserDefaults prototype storage
Rule system = deterministic app logic
```

## Current working features

### Menu bar app

- Foku appears in the macOS menu bar.
- The app opens as a menu bar popover.
- The popover is scrollable so all sections can be reached.
- A separate dashboard window can be opened from the popover.

### Focus timer

- The user can start a focus session.
- The user can pause and resume.
- The user can complete or abandon a session.
- The timer supports preset focus lengths:
  - 5 minutes
  - 15 minutes
  - 25 minutes
  - 45 minutes
- Duration changes are locked during an active session.

### Study intention

- The user can type a study intention before starting.
- The intention is saved with the session.
- The intention is shown in recent session history.
- Intention changes are locked during an active session.

### Self-rating

After a session, the user can rate it as:

```text
Focused
Partly distracted
Did not really study
```

This rating affects deterministic progress calculations.

### Progress

The prototype tracks:

```text
XP
Level
Bond
Momentum
Today’s sessions
Today’s focused minutes
Today’s XP
Current streak
Best streak
```

### Deterministic rule engine

Rewards are calculated by app rules rather than AI.

The current rule result can include:

```text
XP earned
Bond change
Momentum change
Message
Rule summary
```

The rule summary is shown in the app for transparency.

### Pet mood

Foku has an early mood state based on Bond and Momentum.

Current mood examples:

```text
Neutral
Encouraged
Proud
Tired
```

### Daily missions

The prototype has three deterministic daily missions:

```text
Complete one focus session
Earn 30 XP
Set a study intention
```

Missions are calculated from saved local progress.

### Dashboard

The dashboard currently includes cards for:

```text
Progress
Pet state
Today
Streaks
Daily missions
Rule transparency
Privacy & modes
Settings & local data
Recent sessions
```

### Local persistence

Foku saves local prototype progress using UserDefaults.

Saved data includes:

```text
Completed sessions
Recent sessions
XP
Level
Bond
Momentum
Daily stats
Streaks
Last rule result
```

### Privacy / Trust Mode

The current prototype uses Trust Mode.

The app explains that it saves only local session and progress data.

The app states that it does not collect:

```text
Websites
Messages
Files
Screen content
Keyboard activity
Browsing history
```

Focus Guard is not enabled in the current prototype.

### Local data reset

The dashboard includes a Settings & local data section.

It shows:

```text
Saved data location: Local UserDefaults
Reset local prototype data button
Confirmation alert before reset
```

The reset affects local app progress only. It does not delete source code, Git commits, screenshots, or documentation.

## Evidence folders created

Current evidence folders include:

```text
evidence/setup
evidence/xcode-setup
evidence/xcode-initial
evidence/menu-bar-prototype
evidence/refactor
evidence/session-model
evidence/self-rating
evidence/xp-levels
evidence/bond-momentum
evidence/local-persistence
evidence/rule-engine
evidence/daily-stats
evidence/dashboard
evidence/session-duration
evidence/session-history
evidence/privacy-mode
evidence/session-intention
evidence/daily-missions
evidence/settings-data
```

## Current limitations

The current app is still a prototype.

Important limitations:

```text
No App Store release
No Apple Developer Program setup
No Focus Guard app monitoring
No Strict Mode
No real database
No cloud sync
No polished pixel art pet
No unit tests
No separate settings window
Dashboard code still needs refactoring into separate files
```

## Next recommended work

The next best step is not to add many more features immediately. The next step should be cleanup and project quality:

```text
Refactor large SwiftUI files
Separate dashboard UI into its own file
Separate mission UI into its own file
Separate rule engine into its own file
Add a short technical explanation for the Personal Project report
Create a stable demo checklist
```

This will make the project easier to explain, maintain, and present.


## Visual update: pixel pet

The current prototype includes a simple pixel-art Foku pet view. The pet appears in the menu bar popover and dashboard, replacing the earlier diamond text placeholder. The visual pet still uses deterministic mood state from the app.


## Feature update: subject tags

The current prototype includes simple subject tags for study intentions. Users can select common subjects such as Biology, Math, History, English, Psychology, or Other. The selected subject is stored as a prefix in the study intention and appears in saved session history.


## Feature update: weekly stats

The current prototype includes a weekly stats section in the dashboard. It calculates this week's completed sessions, focused minutes, active days, average minutes per active day, and best day from local saved session history.


## Feature update: subject breakdown

The current prototype includes a subject breakdown section in the dashboard. It calculates top subject, subject count, minutes per subject, and sessions per subject from tagged study intentions in local session history.


## Feature update: 7-day focus chart

The current prototype includes a 7-day focus chart in the dashboard. It shows completed focus minutes by day using locally saved session history.


## Feature update: achievements and dashboard layout

The current prototype includes an achievements section in the dashboard. Achievements are calculated locally from session history and include milestones such as First Focus, Getting Consistent, One Focus Hour, Subject Explorer, and Three Active Days.

The dashboard layout has also been improved so cards wrap into wider rows instead of being squeezed into one horizontal row.


## Feature update: custom focus duration

The current prototype includes a custom focus duration control in the popover. Users can choose a custom duration from 5 to 120 minutes using a stepper, while keeping the preset 5m, 15m, 25m, and 45m options.


## Feature update: daily focus goal

The current prototype includes a daily focus goal section in the dashboard. Users can set a local daily goal and see today's focused minutes, progress percentage, and remaining minutes.


## Feature update: Daily Goal Reached achievement

The current prototype includes a Daily Goal Reached achievement. It unlocks when today's completed and rated focused minutes meet or exceed the local daily focus goal.


## UX update: daily goal clarification

The Daily focus goal card now explains that goal progress counts completed and rated sessions only. This prevents confusion when a session is still running.


## Feature update: session reflection notes

The current prototype includes optional session reflection notes. After completing a session, the user can write a short note before self-rating. The note is saved locally with the session and shown in recent session history.


## UX update: self-check panel polish

The self-check panel now has clearer spacing, optional reflection text, quick reflection prompt buttons, and cleaner self-rating buttons. Reflection notes still save locally and appear in Recent sessions.


## Feature update: latest session summary card

The current build includes a latest session summary card. After a session is completed and rated, the popover shows a compact summary with XP, actual time, Bond, Momentum, rating, reflection status, and rule summary.


## UX update: Dashboard Recent sessions polish

The Dashboard Recent sessions section now uses cleaner card-style rows. Each row shows a clear session title, XP badge, Time, Rating, Bond, Momentum, optional intention, optional reflection note, and the deterministic rule summary.


## Architecture update: AchievementEngine

The current build now separates achievement rules into `AchievementEngine.swift`. The Dashboard Achievements UI still works, but the milestone logic is cleaner and easier to test later.


## Architecture update: SubjectTagEngine

The current build now separates subject-tag parsing and subject breakdown logic into `SubjectTagEngine.swift`. The Dashboard Subject breakdown UI still works, but the analytics logic is cleaner and easier to test later.


## Testing update: DeterministicRuleEngine

The current build includes lightweight command-line tests for `DeterministicRuleEngine`. These tests verify deterministic reward behavior and confirm that the normal app build still succeeds.


## Testing update: SubjectTagEngine

The current build includes lightweight command-line tests for `SubjectTagEngine`. These tests verify bracket tag parsing, subject fallback behavior, mixed-subject counting, focused-minute totals, top subject selection, and deterministic output.


## Testing update: AchievementEngine

The current build includes lightweight command-line tests for `AchievementEngine`. These tests verify achievement unlock rules, locked states, progress text, unique ids, and deterministic output.


## Testing update: combined test runner

The current build includes a combined test runner: `scripts/run_all_tests.sh`. It runs all current command-line engine tests and a normal app build check.


## Milestone: v0.3 study companion features

The current stable milestone is `v0.3-study-companion-features`. It includes the main study companion features, local deterministic engines, reflection notes, session summaries, dashboard analytics, and lightweight tests with a combined runner.


## v0.4 polish update: manual Dashboard redesign

The Dashboard has been manually reorganized into clearer demo sections: Today at a glance, Study analytics, Motivation system, History, and Privacy/local data. This improves presentation without changing the deterministic engines or local persistence logic.


## v0.4 polish update: simple pixel pet baseline

The pet visual has been simplified into a cleaner monochrome pixel mascot. This creates a stable visual baseline before adding mood colours, unlockable accessories, or animations.


## v0.4 polish update: first-run onboarding

The menu bar popover now includes a dismissible first-run onboarding card. It explains the main workflow: set an intention, focus honestly, then reflect and grow. It also reinforces the local-first Trust Mode privacy promise.
