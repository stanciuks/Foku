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
