# Personal Project progress reflection draft

Date: 2026-07-07

This is an early reflection draft for my Foku Personal Project. It is not the final report. I am saving it now so I do not forget the development process when I start writing the Personal Project work properly at school.

## What I built

Foku is now a working native macOS SwiftUI prototype. It started as an idea for a focus companion, but it now has a real menu bar app, a popover, and a dashboard window.

Current working features include:

```text
Menu bar popover
Dashboard window
Focus timer
Preset focus lengths
Study intention field
Pause / resume / complete / abandon session
Self-rating after a session
XP and level system
Bond and Momentum
Pet mood
Deterministic rule engine
Daily stats
Streaks
Daily missions
Recent session history
Privacy / Trust Mode explanation
Local saving
Local data reset controls
```

This means Foku is no longer only a concept. It can be opened, tested, demonstrated, and explained.

## Why the project matters

The goal of Foku is not just to make another timer. The idea is to make a study companion that supports focus without being invasive.

The user can set an intention, complete a focus session, rate how focused they were, and see progress update. This makes the app feel more reflective than a normal timer.

The project also tries to avoid manipulative design. Bond and pet mood should not punish the user emotionally. The app should encourage honest reflection and gradual progress.

## Important design decisions

### Local-first design

The prototype works locally. It currently saves data using UserDefaults on the Mac. This was a practical decision because the project does not need accounts, servers, or cloud sync at this stage.

### Trust Mode by default

Foku currently uses Trust Mode. It does not collect websites, messages, files, screen content, keyboard activity, or browsing history.

The current saved data is limited to local session and progress information such as:

```text
Session timing
Study intention
Self-rating
XP
Bond
Momentum
Daily stats
Streaks
Recent sessions
```

### Deterministic rewards

AI does not decide XP, Bond, Momentum, missions, streaks, or pet mood. These are calculated by deterministic app rules.

This is important because the reward system should be understandable and predictable. The app can show a rule summary such as:

```text
Completed × Focused → XP, Bond, Momentum
```

This supports transparency.

## Problems I solved

### Xcode file structure problems

At one point Xcode showed duplicate folders and duplicate compile warnings. I learned that the Xcode navigator is not always the same as the real folders on disk. I had to clean the project references and make sure files were included in the correct target.

### New files not being found

When I created new Swift files during refactoring, Xcode sometimes needed the files to be included correctly in the app target. I learned to test after every refactor and watch for red errors such as missing view names.

### Popover became too crowded

As I added more features, the menu bar popover became too tall. The solution was to add a ScrollView and later create a separate dashboard window. This changed the design:

```text
Popover = quick focus actions
Dashboard = larger progress overview
```

### Saved data compatibility

When I added the study intention field, older saved sessions did not have that field. This caused a decoding warning. I fixed it by making the decoder backward-compatible and giving older sessions a default empty intention.

### Refactoring mistake

When I moved rule logic into a separate file, the DailyMission model was accidentally removed. I fixed this by restoring the model and keeping only the engine logic in RuleEngines.swift.

### Long command issues

Some long Terminal commands were hard to paste and caused heredoc problems. I solved this by using downloadable `.sh` scripts for large updates.

## How I used AI responsibly

I used AI as a coding and planning assistant, but I still tested the app myself.

AI helped with:

```text
Generating code drafts
Writing scripts
Debugging errors
Planning feature order
Writing documentation drafts
Creating reflection material
```

I was responsible for:

```text
Running the app
Checking Xcode errors
Testing each feature
Taking screenshots
Committing changes
Deciding whether a feature worked
```

Inside the actual Foku app, AI does not control rewards or progression. The app uses deterministic rules for XP, Bond, Momentum, missions, and pet mood.

## What I learned

I learned about:

```text
SwiftUI
MenuBarExtra
WindowGroup
ObservableObject and @Published
Local persistence with UserDefaults
Codable models
Backward-compatible decoding
Git commits and tags
Xcode target membership
Refactoring Swift files
Keeping evidence through screenshots
Writing development documentation
```

I also learned that building an app is not only about adding features. A lot of time goes into fixing structure, testing, documenting, and making sure new changes do not break old features.

## Evidence created

I created evidence folders for many parts of the process, including:

```text
setup
xcode setup
initial app
menu bar prototype
session model
self-rating
XP and levels
Bond and Momentum
local persistence
rule engine
daily stats
dashboard
session duration
session history
privacy mode
study intention
daily missions
settings and data controls
refactoring
```

This evidence will be useful later because it shows the development process, not just the final app.

## Current limitations

Foku is still a prototype. Current limitations include:

```text
No App Store release
No polished pixel-art pet yet
No Focus Guard
No Strict Mode
No real database
No cloud sync
No unit tests
No full settings window
No custom duration input
No subject tags
No charts or weekly analytics
Some UI files still need more refactoring
```

These limitations are acceptable at this stage because the goal was to build a working prototype first.

## What I would improve next

The next improvements should focus on quality and explanation, not only more features.

Possible next steps:

```text
Refactor more UI into separate files
Add unit tests for the rule engine
Improve the dashboard design
Create a simple pixel-art pet design
Add subject tags
Add weekly stats
Improve mission variety
Create a proper settings window
```

## Short reflection paragraph

During this phase, I turned Foku from an idea into a working macOS prototype. I built a menu bar focus app with a dashboard, self-rating, XP, Bond, Momentum, daily missions, privacy explanations, local saving, and recent session history. I solved technical problems with Xcode project structure, UI overflow, saved-data compatibility, and refactoring mistakes. I used AI to help with coding and documentation, but I tested the app myself and kept the app's reward systems deterministic. The prototype is not finished, but it now has enough working features and evidence to show a real development process.

## Note for future report writing

This document should not be copied directly as the final Personal Project report. It should be used as raw reflection material when writing about:

```text
Initial idea
Design criteria
Development process
Problems and solutions
Responsible AI use
Technical learning
Evidence
Evaluation
Future improvements
```
