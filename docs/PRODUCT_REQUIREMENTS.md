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
