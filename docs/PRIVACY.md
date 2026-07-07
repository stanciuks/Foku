# Foku Privacy Design

## Privacy principle

Foku should help users focus without spying on them.

## Version 1: Trust Mode

Trust Mode is the default. It tracks only study session data:

- session start time
- session end time
- planned duration
- actual duration
- pauses
- breaks
- completion or abandonment
- idle time if added
- self-rating
- XP/Bond/Momentum changes

Trust Mode does not monitor other apps.

## Future optional Focus Guard

Focus Guard may be added later. It should be optional and transparent.

It may check:

- active/frontmost app name during active study sessions

It must not check:

- screen contents
- websites
- browser history
- messages
- keyboard input
- files
- documents
- screenshots
- activity outside focus sessions

## Future optional Strict Mode

Strict Mode may allow users to choose allowed apps before a session. It should use thresholds and warnings, not instant failure.

## User controls

The user should be able to:

- disable optional monitoring
- view tracked data
- reset progress
- delete all local data

## Ethical design rules

- Do not remove already-earned XP.
- Do not emotionally punish the user.
- Do not use guilt-based messages.
- Do not make the pet seem harmed by the user.
- Reward honest effort and consistency.
