# Foku

Foku is a native macOS menu bar study companion app with an animated pixel-art digital pet.

The project is being built as an IB MYP 5 Personal Project in computer science, but the goal is to approach it as a serious software product rather than a simple school prototype.

Foku should help users study more consistently through focus sessions, emotional pet feedback, XP, Bond, Momentum, missions, streaks, unlockables, and privacy-safe focus validation.

## Core idea

Foku is not just a timer. It is a local-first, rule-based macOS study companion where a digital pet reacts to study behavior through deterministic systems.

## Core principles

- Native macOS app
- Menu bar first
- Local-first
- Offline-capable
- Privacy-conscious
- Rule-based and deterministic
- No invasive tracking
- No guilt-based design
- No AI-controlled progression
- No required server
- No required account
- No paid distribution during the IB stage

## Current stage

Current development stage: early build setup before the formal IB documentation period begins in September 2026.

Current priority:

1. Set up folder structure.
2. Set up Git and GitHub.
3. Create project documentation.
4. Create the Xcode app.
5. Build the first menu bar prototype.
6. Add a timer.
7. Add session tracking.
8. Add XP, Bond, Momentum, and rule-based behavior later.

## Source of truth

The source of truth for the project is:

1. The Xcode project
2. The GitHub repository
3. The `/docs` folder

AI tools may help, but they should not randomly redesign the project.


## Project documentation

- [Current build summary](docs/CURRENT_BUILD_SUMMARY.md)
- [Demo checklist](docs/DEMO_CHECKLIST.md)
- [Personal Project progress reflection draft](docs/PERSONAL_PROJECT_PROGRESS_REFLECTION.md)
- [Test plan](docs/TEST_PLAN.md)

---

## Current prototype status — v0.3 study companion features

Foku is now a working native macOS menu bar study companion prototype.

### Core app features

- Native macOS menu bar app built with SwiftUI.
- Focus timer with start, pause, resume, complete, and abandon states.
- Preset and custom session durations.
- Study intention field and subject tags.
- Self-rating after completed sessions.
- Optional reflection notes after sessions.
- Latest session summary card after self-rating.
- Local XP and level progression.
- Bond and Momentum values for the pet.
- Deterministic pet mood logic.
- Pixel-style pet display.
- Daily stats and streaks.
- Daily focus goal.
- Daily missions.
- Weekly focus stats.
- Seven-day focus chart.
- Subject breakdown.
- Achievement cards.
- Recent session history.
- Privacy/Trust Mode explanations.
- Local reset controls.

### Architecture status

Important logic has been separated from the UI layer:

```text
Foku/Foku/Models/RuleEngines.swift
Foku/Foku/Models/AchievementEngine.swift
Foku/Foku/Models/SubjectTagEngine.swift
```

These systems are deterministic and local-first. AI does not control XP, Bond, Momentum, achievements, session validation, or pet progression.

### Testing status

The project now includes lightweight command-line tests:

```text
scripts/run_rule_engine_tests.sh
scripts/run_subject_tag_engine_tests.sh
scripts/run_achievement_engine_tests.sh
scripts/run_all_tests.sh
```

The combined runner checks:

- DeterministicRuleEngine tests.
- SubjectTagEngine tests.
- AchievementEngine tests.
- Normal macOS app build.

Run all tests with:

```bash
scripts/run_all_tests.sh
```

### Privacy status

The current prototype is local-first. It stores focus sessions, progress, settings, reflection notes, and history locally. It does not read websites, messages, files, keyboard input, screen contents, or browser history.

