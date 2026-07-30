# Foku demo checklist

Date: 2026-07-07

This checklist is for demonstrating the current Foku prototype during Personal Project documentation, mentor meetings, or presentation preparation.

## Demo goal

Show that Foku is more than a timer.

The demo should show:

```text
A native macOS menu bar app
A focus session flow
Study intention
Self-rating
Deterministic XP / Bond / Momentum
Daily missions
Dashboard
Rule transparency
Privacy / Trust Mode
Local data controls
```

## Before the demo

Make sure:

```text
Xcode builds without red errors
Foku is running
The menu bar icon is visible
Dashboard opens from the popover
Local saved data is present
```

Do not reset local data before the main demo unless the goal is specifically to show first-run behavior.

## Demo steps

### 1. Open Foku from the menu bar

Click the Foku menu bar icon.

Show:

```text
Foku popover
Pet mood
Timer
Progress values
```

What to say:

```text
Foku is a native macOS menu bar study companion. The popover is for quick focus actions.
```

### 2. Show Trust Mode privacy

Scroll to the Privacy section.

Show:

```text
Trust Mode
Local-only saved progress
Focus Guard not enabled
No websites/messages/files/screen/keyboard/history collected
```

What to say:

```text
The default mode is Trust Mode. It does not monitor websites, messages, files, screen content, keyboard activity, or browsing history.
```

### 3. Set a study intention

Type an intention such as:

```text
Biology notes
Math practice
History revision
English essay plan
```

What to say:

```text
Before starting, the user can set an intention so the session has a clear purpose.
```

### 4. Choose a focus length

Click one of the preset focus lengths:

```text
5m
15m
25m
45m
```

What to say:

```text
The user can choose a shorter or longer focus block. Duration is locked after the session starts.
```

### 5. Start the focus session

Click:

```text
Start Focus
```

Show:

```text
Timer running
Duration buttons disabled
Intention field disabled
Pause / Complete / Abandon controls
```

What to say:

```text
During a session, important session details are locked so the record stays consistent.
```

### 6. Complete the session

Click:

```text
Complete
```

Show:

```text
Self-check panel
Focused / Partly / Not really buttons
```

What to say:

```text
Foku does not reward only time. The user honestly rates the session after it ends.
```

### 7. Choose a self-rating

Click:

```text
Focused
```

Show:

```text
XP updates
Bond updates
Momentum updates
Rule summary appears
Daily missions update
```

What to say:

```text
The result is calculated by deterministic app rules, not AI.
```

### 8. Show rule transparency

Scroll to the Rule engine section.

Show a rule summary such as:

```text
Completed × Focused → +30 XP, +3 Bond, +8 Momentum
```

What to say:

```text
Foku makes reward logic visible. AI does not control XP, Bond, Momentum, or progression.
```

### 9. Show daily missions

Scroll to Daily missions.

Show:

```text
Complete one focus session
Earn 30 XP
Set a study intention
```

What to say:

```text
Daily missions are calculated from saved local progress.
```

### 10. Open the Dashboard

Scroll to the bottom and click:

```text
Open Dashboard
```

Show dashboard cards:

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

What to say:

```text
The dashboard is for the larger progress overview, while the menu bar popover is for quick actions.
```

### 11. Show recent session history

Scroll to Recent sessions.

Show:

```text
Session status
Date and time
Actual/planned minutes
Self-rating
XP
Bond change
Momentum change
Study intention
Rule summary
```

What to say:

```text
The app stores recent sessions locally and shows how each session affected progress.
```

### 12. Show local data controls

Scroll to Settings & local data.

Show:

```text
Saved data location: Local UserDefaults
Reset local prototype data
Reset explanation
```

What to say:

```text
The prototype saves data locally on this Mac. The reset option is for testing and does not affect source code, GitHub, screenshots, or documentation.
```

Do not press Reset during the main demo unless specifically demonstrating the reset feature.

## Short demo script

Use this if the presentation has limited time:

```text
This is Foku, a native macOS menu bar study companion. The user sets a study intention, chooses a focus length, and starts a session. After the session, they self-rate how focused they were. Foku then uses deterministic rules to update XP, Bond, Momentum, daily missions, and streaks. AI does not control rewards or progression. The dashboard shows progress, rule transparency, privacy information, recent sessions, and local data controls. The current prototype works locally using Trust Mode.
```

## Evidence to show

Useful evidence folders:

```text
evidence/menu-bar-prototype
evidence/self-rating
evidence/xp-levels
evidence/bond-momentum
evidence/local-persistence
evidence/rule-engine
evidence/daily-stats
evidence/dashboard
evidence/privacy-mode
evidence/session-intention
evidence/daily-missions
evidence/settings-data
evidence/refactor-dashboard
evidence/refactor-self-rating
evidence/refactor-rule-engines
```

## If something goes wrong during demo

### If dashboard does not open

Say:

```text
The dashboard is a separate SwiftUI window. It was tested and documented, but this demo can continue from the menu bar popover.
```

### If local data looks different

Say:

```text
The app uses saved local prototype data, so XP, missions, and history depend on previous test sessions.
```

### If yellow Xcode logs appear

Say:

```text
Those are unrelated macOS/Xcode system logs. The app builds and runs as long as there are no red Swift errors.
```

## Current demo status

The current tagged demo versions are:

```text
v0.1-working-prototype
v0.1.1-refactored-structure
```


---

## v0.4 polished demo evidence package

### Terminal evidence

- [x] Full test runner output saved.
- [x] Git status saved.
- [x] Recent commit log saved.
- [x] Git tag list saved.
- [x] README status preview saved.

### Screenshot evidence to collect

Save final screenshots in:

```text
evidence/v0.4-demo-package/screenshots/
```

Recommended screenshots:

```text
112-popover-onboarding.png
113-popover-main-timer.png
114-subject-tags-intention.png
115-self-check-reflection.png
116-session-summary.png
117-dashboard-top.png
118-dashboard-analytics.png
119-dashboard-achievements-rules.png
120-dashboard-privacy-local-data.png
121-show-welcome-guide-again.png
122-github-v04-commit-history.png
123-github-v04-tags.png
```

### Before tagging v0.4

- [ ] Collect final screenshots.
- [ ] Run `scripts/run_all_tests.sh`.
- [ ] Commit final evidence package.
- [ ] Tag `v0.4-polished-demo`.


---

## v0.4 polished demo evidence completed

Final evidence package:

```text
evidence/v0.4-demo-package/
```

Screenshots collected:

```text
112-popover-onboarding.png
113-popover-main-timer.png
114-subject-tags-intention.png
115-self-check-reflection.png
116-session-summary.png
117-dashboard-top.png
118-dashboard-analytics.png
119-dashboard-achievements-rules.png
120-dashboard-privacy-local-data.png
121-show-welcome-guide-again.png
122-github-v04-commit-history.png
123-github-v04-tags.png
```

Final milestone tag:

```text
v0.4-polished-demo
```
