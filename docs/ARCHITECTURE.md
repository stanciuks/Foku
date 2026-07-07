# Foku Architecture

## Architecture style

Foku should use a layered architecture:

```text
UI
↓
ViewModels / Observable State
↓
Application Services
↓
Rule Engine + State Machine
↓
Gamification Services
↓
Persistence Repositories
↓
Local Storage
```

The UI should never directly calculate XP, Bond, Momentum, streaks, or rewards. The UI sends events or user actions. The rule engine and services decide what happens.

## Main modules

```text
FokuApp/
├── FokuApp.swift
├── AppState.swift
├── Core/
│   ├── Events/
│   ├── StateMachine/
│   └── Rules/
├── Models/
├── Focus/
├── Gamification/
├── Persistence/
├── Animation/
├── AI/
├── Server/
└── UI/
```

## First simple structure

At the very beginning, do not create every module. Start with:

```text
FokuApp/
├── FokuApp.swift
├── AppState.swift
├── Models/
│   └── FocusSession.swift
├── Focus/
│   └── FocusSessionManager.swift
└── UI/
    ├── PopoverRootView.swift
    ├── MenuBarPetView.swift
    └── TimerPanelView.swift
```

Add more folders only when they are actually needed.

## Data flow

```text
User clicks Start
→ FocusSessionManager starts session
→ AppState updates
→ UI shows timer
→ Session completed event is created later
→ Rule Engine evaluates rules
→ XP/Bond/Momentum changes
→ State Machine updates Foku mood
→ Session is saved locally
```

## Future event flow

```text
FokuEvent
→ RuleEngine.evaluate(event, context)
→ FokuEffects
→ Services apply effects
→ Persistence saves changes
→ UI updates from state
```

## Core rule

The app should be deterministic. The same state + same event should produce the same result.
