# Foku test plan

Date: 2026-07-18

This document is a manual test plan for the Foku prototype. It should be used before demos, screenshots, mentor meetings, and future feature work.

## Status labels

```text
✅ Pass
⚠️ Works but needs polish
❌ Fails
```

## 1. App launch

### Build and run

Steps:

```text
1. Open Foku in Xcode.
2. Press Shift + Command + K.
3. Press Run.
```

Expected result:

```text
The app builds with no red Swift errors.
The Foku menu bar icon appears.
```

## 2. Menu bar popover

### Open popover

Steps:

```text
1. Click the Foku menu bar icon.
```

Expected result:

```text
The popover opens.
The timer is visible.
The pixel pet is visible.
Progress values are visible.
```

## 3. Focus session flow

### Set intention and subject

Steps:

```text
1. Type a study intention.
2. Click a subject tag such as Biology or Math.
```

Expected result:

```text
The intention updates.
The selected subject appears as a prefix, such as [Biology] or [Math].
```

### Start session

Steps:

```text
1. Select a focus length.
2. Click Start Focus.
```

Expected result:

```text
The timer starts.
Pause, Complete, and Abandon controls appear.
The intention field and duration buttons are locked.
```

### Pause and resume

Steps:

```text
1. Click Pause.
2. Click Resume.
```

Expected result:

```text
The timer pauses and resumes without losing the session.
```

### Complete and self-rate

Steps:

```text
1. Click Complete.
2. Choose Focused, Partly distracted, or Did not really study.
```

Expected result:

```text
XP updates.
Bond updates.
Momentum updates.
Rule summary updates.
Daily missions update.
The completed session appears in recent history.
```

## 4. Progress systems

Check that these appear and update:

```text
Level
Total XP
XP progress bar
Bond
Momentum
Pet mood
Daily stats
Current streak
Best streak
Daily missions
```

Expected result:

```text
Progress values are calculated by deterministic app rules, not by AI.
```

## 5. Dashboard

### Dashboard opens

Steps:

```text
1. Open Foku popover.
2. Click Open Dashboard.
```

Expected result:

```text
The Foku Dashboard window opens.
Cards are readable.
The layout wraps into wider rows instead of one cramped row.
```

### Dashboard sections

Check that these sections appear:

```text
This week
7-day focus chart
Subject breakdown
Achievements
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

Expected result:

```text
Dashboard data is calculated from local session history.
```

## 6. Analytics checks

### Weekly stats

Expected result:

```text
This week section shows sessions, minutes, active days, average minutes per active day, and best day.
```

### 7-day focus chart

Expected result:

```text
Chart shows completed focus minutes for the last 7 days.
```

### Subject breakdown

Expected result:

```text
Subject breakdown shows top subject, subject count, minutes, and sessions.
```

### Achievements

Expected result:

```text
Achievements show unlocked and locked states.
Achievement progress is based on local session history.
```

## 7. Privacy and local data

### Trust Mode

Expected result:

```text
Privacy section explains Trust Mode.
The app says it does not collect websites, messages, files, screen content, keyboard activity, or browsing history.
```

### Local persistence

Steps:

```text
1. Complete and rate a session.
2. Quit the app.
3. Reopen the app.
```

Expected result:

```text
XP, Bond, Momentum, sessions, and dashboard progress are still saved.
```

### Reset local data

Steps:

```text
1. Open Dashboard.
2. Go to Settings & local data.
3. Click Reset local prototype data.
4. Confirm reset.
```

Expected result:

```text
Local prototype progress resets.
Source code, Git commits, documentation, and screenshots are not affected.
```

## 8. Regression checklist before future commits

Before every future commit, quickly check:

```text
[ ] App builds
[ ] Menu bar popover opens
[ ] Dashboard opens
[ ] Timer starts
[ ] Timer pauses and resumes
[ ] Session can be completed
[ ] Self-rating works
[ ] XP updates
[ ] Bond and Momentum update
[ ] Daily missions still appear
[ ] Subject tags still work
[ ] Weekly stats still appear
[ ] 7-day chart still appears
[ ] Subject breakdown still appears
[ ] Achievements still appear
[ ] Recent sessions still appear
[ ] Privacy section still appears
[ ] No red Xcode errors
```

## 9. Acceptable current prototype limitations

These are acceptable for the current stage:

```text
UI is still prototype-level.
Pixel pet is simple and not final art.
Subject tags are stored as intention prefixes.
No Focus Guard yet.
No Strict Mode yet.
No cloud sync.
No App Store release.
No unit tests yet.
No advanced settings window.
```

## 10. Current stable tags

```text
v0.1-working-prototype
v0.1.1-refactored-structure
v0.2-analytics-dashboard
```
