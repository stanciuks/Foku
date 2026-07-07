# Foku Product Requirements

## Product vision

Foku should be a local-first macOS study companion that makes focus sessions more motivating through a pixel-art pet and deterministic gamification systems.

## Target user

A student who wants to study more consistently without using a controlling or invasive productivity app.

## User needs

The user needs to:

- start focus sessions quickly
- track study consistency
- see progress
- feel motivated
- avoid fake productivity
- keep data private
- receive gentle feedback
- build better habits

## Must-have features for first version

- native macOS app
- menu bar access
- popover UI
- placeholder Foku pet
- basic timer
- start session
- pause session
- resume session
- complete session
- abandon session
- basic session state
- Trust Mode

## Should-have features for IB version

- XP
- levels
- Bond
- Momentum
- missions
- streaks
- basic rule engine
- basic state machine
- basic pet moods
- basic animations
- session history
- privacy settings
- reset progress

## Could-have features for IB version

- Focus Guard
- Strict Mode prototype
- extra personalities
- unlockables
- dashboard
- weekly stats
- exportable summary

## Not planned for first version

- App Store release
- paid Apple Developer Program
- payments
- licensing
- cloud sync
- account system
- public backend dependency
- AI API dependency
- leaderboard
- shared challenges

## Focus system requirements

The app should track:

- planned duration
- actual duration
- start time
- end time
- pause count
- break count
- completion
- abandonment
- self-rating

## XP system requirements

XP should depend on:

- completed sessions
- planned duration
- actual focus time
- self-rating
- later distraction time
- mission completion

Foku should not remove already-earned XP.

## Bond system requirements

Bond should increase when:

- sessions are completed
- the user returns after breaks
- the user studies consistently
- the user is honest about distractions
- healthy habits are maintained

Bond should not create guilt.

## Momentum system requirements

Momentum should increase with:

- consistency
- completed sessions
- realistic goals
- low distraction
- healthy breaks

Momentum may decrease gently after:

- abandoned sessions
- repeated low-quality sessions
- ignored focus goals

## Personality system requirements

Personality affects dialogue tone.

Examples:

- supportive
- sarcastic
- strict
- chaotic
- calm
- encouraging

Personality should not secretly change scoring.

## Privacy requirements

Foku must not read:

- screen content
- messages
- files
- typed text
- websites
- browser history
- screenshots

Focus Guard, if added, may only check the active app name during a study session.


## Current XP prototype rule

The first XP prototype uses this basic approach:

```text
Base XP = planned minutes × 1.2
Final XP = Base XP × completion multiplier × self-rating multiplier
```

Current self-rating multipliers:

```text
Focused = 1.0
Partly distracted = 0.7
Did not really study = 0.1
```

Current completion multiplier:

```text
Completed session = 1.0
Abandoned session = 0.25
```

This is temporary and will later be moved into a dedicated XP service or rule engine.


## Current Bond and Momentum prototype rule

The first Bond and Momentum prototype uses simple deterministic updates after the user submits a self-rating.

Bond currently represents the user's relationship/connection with Foku.

Momentum currently represents recent study consistency and session quality.

These values are temporary in-memory prototype values. Later they should be moved into dedicated services or the rule engine.


## Current local persistence prototype

The first persistence prototype stores Foku progress locally using `UserDefaults`.

Currently saved:

```text
- total XP
- level
- XP progress
- Bond
- Momentum
- completed session count
- recent sessions
```

This keeps the prototype offline-capable and local-first. It is acceptable for the early IB prototype, but a larger future version may move session history into a stronger local database or a structured local file.


## Current deterministic reward rule

The current prototype calculates a rule result after a user rates a finished session.

The rule result includes:

```text
XP earned
Bond change
Momentum change
A user-facing message
A visible rule summary
```

Current reward principle:

```text
Completed + Focused = strongest positive result
Completed + Partly distracted = smaller positive result
Completed + Did not really study = honest but weak result
Abandoned = reduced XP and lower Momentum
```

This supports the core Foku requirement that AI must not decide rewards or progression.


## Current daily stats prototype

The current prototype tracks daily progress locally.

Visible daily values:

```text
Today’s sessions
Today’s focused minutes
Today’s XP
Current streak
Best streak
```

This helps Foku feel more like a study companion instead of only a timer. The current version is still simple and will later need a better dashboard layout.


## Current dashboard prototype

Foku now includes a separate dashboard window.

The dashboard exists because the menu bar popover became too crowded. The popover should stay useful for quick actions, while the dashboard can show larger progress information.

Current dashboard cards:

```text
Progress
Pet state
Today
Streaks
Rule transparency
```

This supports the goal of making Foku feel like a full study companion app, not only a timer.


## Current session duration prototype

Foku now supports preset focus lengths.

Current options:

```text
5 minutes
15 minutes
25 minutes
45 minutes
```

The user can change the duration before starting a session. The duration is locked while a session is running or paused, so the recorded planned duration stays consistent.


## Current session history prototype

The dashboard now includes a Recent sessions card.

Each recent session can show:

```text
Status
Date and time
Actual minutes / planned minutes
Self-rating
XP earned
Bond change
Momentum change
Rule summary
```

This supports transparency because the user can see how each session affected progress.


## Current privacy transparency prototype

Foku now includes visible privacy explanations in the popover and dashboard.

The app clearly states that the current mode is Trust Mode and that the prototype only saves limited local session and progress data. It also states that Focus Guard is not enabled yet and that the app does not collect websites, messages, files, screen content, keyboard activity, or browsing history.


## Current study intention prototype

Before starting a focus session, the user can now type a short study intention.

Examples:

```text
Biology notes
Math practice
History revision
English essay plan
```

The intention is saved with the session and appears in the dashboard history. This makes each focus block more meaningful than only tracking time.


## Current daily missions prototype

Foku now has a simple daily missions system.

Current missions:

```text
Complete one focus session
Earn 30 XP
Set a study intention
```

Missions are shown in both the popover and the dashboard. They are calculated from saved local progress, so if the user already completed the goals earlier in the day, the missions appear as done.


## Current settings and local data prototype

Foku now includes a basic Settings & local data section in the dashboard.

Current controls:

```text
Show saved data location
Explain local-only prototype storage
Reset local prototype data
Confirm before reset
```

This supports transparency and makes it easier to test the prototype without affecting source code, commits, documentation, or evidence screenshots.
