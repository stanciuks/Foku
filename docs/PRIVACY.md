# Foku Privacy Design

Privacy is a core part of Foku.

Foku should help users focus without spying on them.

## Main privacy principle

Foku should be transparent, optional, local-first, and respectful.

## Foku must not track

Foku must not read or store:

- screen contents
- screenshots
- website contents
- browser history
- private messages
- files
- documents
- typed text
- keyboard input
- clipboard contents
- microphone audio
- camera video
- location
- activity outside focus sessions

## Mode 1: Trust Mode

Trust Mode is the default and first mode.

It tracks:

- session start time
- session end time
- planned duration
- actual duration
- pauses
- breaks
- completion
- abandonment
- self-rating
- XP
- Bond
- Momentum
- streaks

It does not monitor other apps.

## Mode 2: Focus Guard

Focus Guard is optional and should be added later.

It may check only the currently active app name during a study session.

Examples:

- Safari
- Notes
- Preview
- Anki
- Pages
- Calculator
- Steam
- Discord
- Minecraft
- Roblox

It must not read content inside those apps.

Explanation for users:

Focus Guard only checks which app is active during a study session. It does not read your screen, websites, messages, files, or keyboard input.

## Mode 3: Strict Mode

Strict Mode is optional and advanced.

Before a session, the user chooses allowed apps.

Strict Mode should use thresholds:

- 0–2 minutes distraction: ignored
- 2–5 minutes: warning
- 5–15 minutes: reduced XP
- 15–30 minutes: reduced XP and small Momentum penalty
- 30+ minutes: session may not count for streak

## Data control

The user should eventually be able to:

- view stored data
- reset progress
- delete all local data
- disable Focus Guard
- delete Focus Guard data

## Ethical design

Foku should avoid:

- guilt-based messages
- emotional punishment
- secret monitoring
- hidden scoring
- pay-to-save streaks
- pay-to-stop negative reactions
- selling user data

Low-quality sessions should earn less XP, but already-earned XP should not be removed.


## Current in-app privacy message

Foku currently shows privacy information directly inside the app.

Current mode:

```text
Trust Mode
```

Current saved data:

```text
Session timing
Self-ratings
XP
Bond
Momentum
Streaks
Recent sessions
```

Current not-collected data:

```text
Websites
Messages
Files
Screen content
Keyboard activity
Browsing history
```

Focus Guard is not enabled in the current prototype.
