# Foku Architecture

## Architecture goals

Foku should be:

- native to macOS
- local-first
- offline-capable
- privacy-conscious
- modular
- testable
- deterministic
- scalable later

The app should not become one giant SwiftUI file.

## High-level flow

User action -> UI -> AppState -> FocusSessionManager -> Event -> RuleEngine -> StateMachine -> Gamification services -> Persistence -> UI updates

## Main layers

### UI layer

Responsible for:

- menu bar pet
- popover
- timer panel
- dashboard
- settings
- privacy controls

The UI should not calculate XP or decide rules directly.

### App state layer

Responsible for shared app state:

- current session
- current timer status
- current pet mood
- selected personality
- user progress
- temporary UI state

### Focus layer

Responsible for:

- starting sessions
- pausing sessions
- resuming sessions
- completing sessions
- abandoning sessions
- tracking elapsed time

### Rule engine layer

Responsible for deterministic decisions.

Example:

IF session completed AND self-rating = focused THEN add XP, increase Bond, increase Momentum, set mood to proud

### State machine layer

Responsible for Foku's activity and emotional state.

Activity states:

- idle
- studying
- distracted
- break
- paused
- session complete
- session abandoned

Emotional states:

- neutral
- focused
- happy
- proud
- concerned
- annoyed
- tired
- disappointed
- celebrating

### Gamification layer

Responsible for:

- XP
- levels
- streaks
- missions
- rewards
- Bond
- Momentum

### Persistence layer

Responsible for saving and loading local data.

Possible stages:

1. in-memory state
2. JSON file
3. SwiftData
4. SQLite later if needed

### Animation layer

Responsible for pet animation states.

Example mapping:

- studying + focused -> studying_loop
- idle + neutral -> idle_loop
- sessionComplete + proud -> celebrate
- distracted + concerned -> concerned_loop

### AI layer

Optional future layer only.

AI may generate:

- dialogue variations
- study summaries
- mission wording

AI must not control:

- XP
- Bond
- Momentum
- rewards
- pet state
- progression
- session validation

### Server layer

Optional future layer only.

The first app must work without a server.

Future server features may include:

- cloud sync
- AI proxy
- leaderboards
- shared challenges
- account system
- license verification

## First prototype structure

FokuApp/
├── FokuApp.swift
├── AppState.swift
├── Models/
│   └── FocusSession.swift
├── Focus/
│   └── FocusSessionManager.swift
└── UI/
    ├── PopoverRootView.swift
    └── TimerPanelView.swift


## Current persistence approach

The current prototype uses local `UserDefaults` storage through `FocusSessionManager`.

This is intentionally simple:

```text
FocusSessionManager → FokuSaveData → UserDefaults
```

The app does not need a server, login, or internet connection for progress to work. This matches the local-first design goal. A future version may separate persistence into its own service, such as `LocalStorageService`, after the data model becomes more stable.


## Deterministic rule engine

Foku now has an early deterministic rule engine.

The purpose of the rule engine is to make reward decisions transparent and predictable. XP, Bond, Momentum, pet mood, and reward messages should come from app rules, not from AI output.

Current rule engine outputs:

```text
XP earned
Bond change
Momentum change
Message
Rule summary
```

The current rule engine is still an early prototype. Later it should be moved into a dedicated rule/service file and tested separately.


## Daily stats and streaks

Foku now stores early daily statistics locally.

Current daily stats:

```text
Completed sessions today
Focused minutes today
XP earned today
Current streak
Best streak
```

The app uses a local day key in `yyyy-MM-dd` format to decide whether the current saved daily stats belong to today. If the day key changes, the daily stats reset for the new day.

The current streak logic is simple: when a completed session is rated, the app checks whether the previous active day was yesterday. If it was yesterday, the streak increases. If not, the streak resets to 1.


## Dashboard window

Foku now has a separate dashboard window in addition to the menu bar popover.

The menu bar popover is for quick focus actions. The dashboard is for larger progress overview information.

Current dashboard sections:

```text
Progress
Pet state
Today
Streaks
Rule transparency
```

The dashboard uses the same `FocusSessionManager` as the menu bar popover, so both views show the same local saved state.


## Recent session history

Foku now shows recent session history in the dashboard.

The recent history uses the locally saved `recentSessions` list. Each row can show the session result, date, duration, self-rating, XP, Bond change, Momentum change, and rule summary.

This is still not a full database-backed history. It is a lightweight local recent-session list used for the prototype.


## Session intention

Foku now allows the user to write a short study intention before starting a session.

The intention is saved inside the local `FocusSession` model and displayed in recent session history. The intention is locked once a session starts so the session record stays consistent.

Because older saved sessions did not include this field, `FocusSession` uses backward-compatible decoding and defaults missing intention values to an empty string.


## Daily missions

Foku now includes a first deterministic daily missions prototype.

Missions are calculated from local progress and recent sessions. The first mission engine checks whether the user has completed a session today, earned enough XP today, and set a study intention in a recent session from today.

Current missions:

```text
Complete one focus session
Earn 30 XP
Set a study intention
```

The mission system is deterministic and does not use AI to decide rewards or completion.


## Settings and local data controls

The dashboard now includes a Settings & local data card. It explains that prototype progress is saved locally using UserDefaults and includes a reset control for clearing local prototype data.

The reset function lives in `FocusSessionManager` and clears in-memory progress as well as the saved UserDefaults key. This is intended for testing first-run behavior and empty mission states during development.


## UI refactor: DashboardView

`DashboardView` has been moved into its own Swift file:

```text
Foku/Foku/UI/DashboardView.swift
```

`PopoverRootView.swift` now focuses on the menu bar popover, while `DashboardView.swift` focuses on the larger dashboard window. This makes the UI layer easier to maintain and explain.


## UI refactor: SelfRatingPanelView

`SelfRatingPanelView` has been moved into its own Swift file:

```text
Foku/Foku/UI/SelfRatingPanelView.swift
```

This keeps self-rating UI separate from the main menu bar popover view and makes the UI layer easier to maintain.


## Rule engine refactor

Rule logic has been moved into a separate file:

```text
Foku/Foku/Models/RuleEngines.swift
```

This file currently contains:

```text
DeterministicRuleEngine
DailyMissionEngine
```

`FocusSessionState.swift` now focuses more on shared data models, while `RuleEngines.swift` contains deterministic calculations and mission evaluation logic.


## UI feature: PixelPetView

Foku now has a simple pixel-art pet view:

```text
Foku/Foku/UI/PixelPetView.swift
```

The view displays a lightweight pixel-style pet based on the current `PetMood`. This replaces the earlier text-based pet placeholder while keeping the mood system deterministic.


## UI feature: SubjectTagPickerView

Foku now includes a simple subject tag picker:

```text
Foku/Foku/UI/SubjectTagPickerView.swift
```

The first version stores subject tags as visible prefixes in the study intention, for example:

```text
[Biology] notes on cells
[Math] practice problems
```

This keeps the feature compatible with the current session model and local persistence system. A future version could store subject tags as a separate model field.


## UI feature: WeeklyStatsView

Foku now includes a weekly stats dashboard view:

```text
Foku/Foku/UI/WeeklyStatsView.swift
```

The view calculates weekly progress locally from saved completed sessions. It shows completed sessions, focused minutes, active days, average minutes per active day, and best day. This keeps analytics local-first and compatible with Trust Mode.


## UI feature: SubjectBreakdownView

Foku now includes a subject breakdown dashboard view:

```text
Foku/Foku/UI/SubjectBreakdownView.swift
```

The view calculates subject analytics locally from study intention prefixes such as:

```text
[Biology]
[Math]
[History]
```

It shows top subject, number of subjects, minutes per subject, and sessions per subject. This is a prototype-friendly way to add subject analytics without changing the saved session model yet.


## UI feature: WeeklyFocusChartView

Foku now includes a 7-day focus chart:

```text
Foku/Foku/UI/WeeklyFocusChartView.swift
```

The view calculates completed focus minutes for each of the last 7 days from local session history. This adds a visual analytics layer while keeping progress tracking local-first and compatible with Trust Mode.


## UI feature: AchievementsView

Foku now includes a local achievements dashboard section:

```text
Foku/Foku/UI/AchievementsView.swift
```

Achievements are calculated from local session history. They do not require AI, accounts, a backend, or cloud sync. The current prototype achievements include:

```text
First Focus
Getting Consistent
One Focus Hour
Subject Explorer
Three Active Days
```

The dashboard layout was also updated to use adaptive card grids instead of cramped horizontal rows, making new analytics sections easier to read.


## UI feature: CustomDurationView

Foku now includes a custom focus duration control:

```text
Foku/Foku/UI/CustomDurationView.swift
```

The view allows users to select a custom focus duration from 5 to 120 minutes using a stepper. It keeps preset duration buttons for quick choices and converts custom minutes into seconds before updating the session manager.


## UI feature: DailyGoalView

Foku now includes a local daily focus goal dashboard section:

```text
Foku/Foku/UI/DailyGoalView.swift
```

The view shows today's focused minutes, the user's daily goal, progress percentage, and remaining minutes. The goal is saved locally with `@AppStorage`, keeping the feature local-first and compatible with Trust Mode.


## Achievement update: Daily Goal Reached

The achievements system now includes a daily-goal milestone:

```text
Daily Goal Reached
```

This achievement unlocks when today's completed and rated focused minutes meet or exceed the locally saved daily focus goal. It uses the same daily focused minutes value as the Daily focus goal card, keeping dashboard progress and achievement logic consistent.


## Feature update: session reflection notes

Foku now supports optional session reflection notes.

Reflection notes are stored locally inside `FocusSession`:

```text
reflectionNote
```

The note is typed during the self-check flow and saved when the user submits a self-rating. Recent session history can show the note as:

```text
Reflection: ...
```

This keeps reflection local-first and separate from AI. AI does not evaluate, score, or generate the note in this prototype.


## Feature update: latest session summary card

Foku now includes a `SessionSummaryCardView` that presents feedback after a completed session has been rated.

The card reads already-computed session data from `FocusSession`:

```text
xpEarned
actualMinutesRoundedDown
bondChange
momentumChange
ratingText
reflectionNote
ruleSummary
```

The summary card does not calculate rewards. It only displays values already produced by the deterministic rule engine and saved in the session model.


## Architecture update: AchievementEngine

Achievement logic has been moved out of the SwiftUI view layer into `AchievementEngine`.

Relevant files:

```text
Foku/Foku/Models/AchievementEngine.swift
Foku/Foku/UI/AchievementsView.swift
```

`AchievementEngine` produces `[FokuAchievement]` from local app state:

```text
UserProgress
recentSessions
dailyGoalMinutes
```

This keeps milestone rules deterministic, testable, and separate from presentation. `AchievementsView` now reads from `FocusSessionManager` and uses the engine to render cards.


## Architecture update: SubjectTagEngine

Subject-tag parsing and subject breakdown logic has been moved out of the SwiftUI view layer into `SubjectTagEngine`.

Relevant files:

```text
Foku/Foku/Models/SubjectTagEngine.swift
Foku/Foku/UI/SubjectBreakdownView.swift
```

`SubjectTagEngine` produces subject breakdown data from saved local sessions:

```text
[FocusSession] -> SubjectBreakdownSummary
```

The engine reads subject tags from session intentions, especially bracket-style tags such as:

```text
[History]
[Psychology]
[English]
```

This keeps subject analytics deterministic, local, and easier to test separately from UI rendering.


## Testing update: DeterministicRuleEngine

The project now includes lightweight command-line tests for deterministic reward logic.

Relevant files:

```text
tests/DeterministicRuleEngineTests.swift
scripts/run_rule_engine_tests.sh
```

The tests compile the model and rule engine files directly with `swiftc` and verify important rule-engine behavior without needing a full Xcode test target.

This supports the architecture decision that XP, Bond, Momentum, and rule summaries are deterministic and not AI-controlled.


## Testing update: SubjectTagEngine

The project now includes lightweight command-line tests for subject-tag parsing and subject breakdown logic.

Relevant files:

```text
tests/SubjectTagEngineTests.swift
scripts/run_subject_tag_engine_tests.sh
```

The tests compile the model and subject engine files directly with `swiftc` and verify that subject analytics remain deterministic and local.


## Testing update: AchievementEngine

The project now includes lightweight command-line tests for achievement unlock logic.

Relevant files:

```text
tests/AchievementEngineTests.swift
scripts/run_achievement_engine_tests.sh
```

The tests compile the model and achievement engine files directly with `swiftc` and verify that milestone logic remains deterministic and local.
