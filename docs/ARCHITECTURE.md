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
