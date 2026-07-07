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
