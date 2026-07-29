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


## Custom duration checks

### Custom duration control

Steps:

```text
1. Open the Foku popover.
2. Use the custom length stepper.
3. Click Use custom.
4. Try 5m and 65m.
```

Expected result:

```text
5m displays as 05:00.
65m displays as 65:00.
Custom controls lock during an active session.
Preset buttons still work.
```


## Daily focus goal checks

### Daily goal section

Steps:

```text
1. Open the Foku Dashboard.
2. Find Daily focus goal.
3. Change the goal with the stepper.
```

Expected result:

```text
Daily focus goal section appears.
Today, Goal, and Progress values appear.
Goal stepper changes the local goal.
The setting stays local on this Mac.
```


## Daily Goal Reached achievement checks

### Daily goal achievement

Steps:

```text
1. Open Dashboard.
2. Set Daily focus goal to a low value, such as 15m.
3. Complete and rate enough focus time to meet the goal.
4. Check Achievements.
```

Expected result:

```text
Daily Goal Reached appears in Achievements.
It stays locked during a running session.
It unlocks after completed and rated focus minutes meet or exceed the daily goal.
```


## Daily goal clarification check

### Counting rule note

Steps:

```text
1. Open Dashboard.
2. Look at Daily focus goal.
```

Expected result:

```text
The card explains that daily goal progress counts completed and rated sessions only.
```


## Session reflection note checks

### Reflection note saving

Steps:

```text
1. Complete a focus session.
2. Type a reflection note in the self-check panel.
3. Choose a self-rating.
4. Open Dashboard.
5. Check Recent sessions.
```

Expected result:

```text
The recent session shows Reflection: followed by the typed note.
The note stays local.
The app still updates XP, Bond, Momentum, daily missions, and achievements.
```


## Self-check panel polish checks

### Reflection prompt buttons

Steps:

```text
1. Complete a focus session.
2. In the self-check panel, click each prompt button.
3. Type or edit a reflection note.
4. Submit a self-rating.
5. Open Dashboard > Recent sessions.
```

Expected result:

```text
Prompt buttons add text to the reflection note.
The note can still be edited before self-rating.
The note is saved and appears in Recent sessions.
XP, Bond, Momentum, missions, and achievements still update.
```


## Latest session summary card checks

### Summary card after self-rating

Steps:

```text
1. Start and complete a focus session.
2. Add a reflection note in the self-check panel.
3. Submit a self-rating.
4. Open the popover.
5. Check the latest session summary card.
```

Expected result:

```text
The popover shows `Last session summary`.
The card displays XP, Time, Bond, Momentum, Rating, and Reflection status.
The card does not show duplicate `Intention: Intention:` text.
The app still updates dashboard stats, recent sessions, missions, and achievements.
```


## Dashboard Recent sessions polish checks

### Recent session readability

Steps:

```text
1. Run the app.
2. Open Dashboard.
3. Find the Recent sessions section.
4. Check a session with a reflection note.
5. Check a session without a reflection note if available.
```

Expected result:

```text
Recent sessions appear as clean cards.
Time, Rating, Bond, and Momentum are shown separately.
Reflection notes are readable.
The intention display does not duplicate `Intention:`.
The deterministic rule summary remains visible.
```


## AchievementEngine checks

### Dashboard achievement display

Steps:

```text
1. Run the app.
2. Open Dashboard.
3. Check the Achievements section.
4. Compare visible achievement progress with current app state.
```

Expected result:

```text
Achievements still appear.
Daily goal, reflection, intention, XP, Bond, Momentum, and streak achievements display sensible progress.
No reward calculation changes occur from this refactor.
```


## SubjectTagEngine checks

### Dashboard subject breakdown display

Steps:

```text
1. Run the app.
2. Open Dashboard.
3. Check the Subject breakdown section.
4. Compare visible subjects with saved recent session intentions.
```

Expected result:

```text
Subject breakdown still appears.
Existing subjects are listed.
Top subject and subject count are sensible.
The feature remains local-only and deterministic.
No reward calculation changes occur from this refactor.
```


## DeterministicRuleEngine automated checks

### Command

```bash
scripts/run_rule_engine_tests.sh
```

### Expected result

```text
DeterministicRuleEngine tests passed.
```

### Coverage

```text
- identical input gives identical XP/Bond/Momentum/rule summary
- focused completed session earns positive XP
- weaker rating does not beat focused rating
- extra pauses do not improve Momentum
- short session does not beat full session
- rule summary is readable
```


## SubjectTagEngine automated checks

### Command

```bash
scripts/run_subject_tag_engine_tests.sh
```

### Expected result

```text
SubjectTagEngine tests passed.
```

### Coverage

```text
- bracket tags are extracted and sorted
- empty intention produces no subject
- non-tagged intention becomes Other
- mixed-subject sessions count for each tag
- focused minutes are totalled by subject
- top subject is selected by focused minutes
- summary output is deterministic
```


## AchievementEngine automated checks

### Command

```bash
scripts/run_achievement_engine_tests.sh
```

### Expected result

```text
AchievementEngine tests passed.
```

### Coverage

```text
- achievement ids are unique
- rated session unlocks first self-check
- daily goal achievement unlocks at the goal
- reflection achievement unlocks with a reflection note
- intention achievement unlocks with an intention
- XP, Bond, Momentum, and streak achievements unlock at thresholds
- locked state remains locked without progress
- progress text is sensible
- output is deterministic
```


## Combined test runner

### Command

```bash
scripts/run_all_tests.sh
```

### Expected result

```text
All Foku tests and build checks passed.
```

### Coverage

```text
- DeterministicRuleEngine tests
- SubjectTagEngine tests
- AchievementEngine tests
- normal app build check
```
