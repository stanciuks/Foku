# Foku Design Decisions

This file records important design and technical decisions.

## Decision 001: Build Foku as a native macOS app

**Date:** 2026-07-07

**Decision:**  
Foku will be built as a native macOS application using Swift and SwiftUI.

**Reason:**  
The app should feel like a polished macOS menu bar product, not a website or simple school prototype.

**Alternatives considered:**  
- Web app
- Electron app
- iOS app
- Simple timer app

**Impact:**  
The project will require learning macOS development, but the final result better matches the product idea.

## Decision 002: Use a local-first architecture

**Date:** 2026-07-07

**Decision:**  
The first version of Foku will work offline and store progress locally.

**Reason:**  
The core app should not depend on internet access, accounts, cloud sync, AI APIs, or a server.

**Alternatives considered:**  
- Starting with cloud accounts
- Requiring a backend from the beginning
- Saving all data online

**Impact:**  
The first version will focus on local sessions, local progress, local XP, Bond, Momentum, and settings.

## Decision 003: Do not pay for Apple Developer Program during the IB stage

**Date:** 2026-07-07

**Decision:**  
The IB version will be built and tested locally using Xcode without paying for the Apple Developer Program.

**Reason:**  
The academic version does not need public distribution. It can be demonstrated through local builds, screenshots, screen recordings, GitHub commits, and documentation.

**Alternatives considered:**  
- Paying immediately
- Releasing on the Mac App Store
- Focusing on distribution before the app works

**Impact:**  
Signing, notarization, payments, App Store release, and public downloads are future possibilities, not first-version requirements.

## Decision 004: Website distribution is a possible future path

**Date:** 2026-07-07

**Decision:**  
Foku will not be architecturally locked into the Mac App Store.

**Reason:**  
Many macOS productivity apps are distributed through websites. Foku may later use this model.

**Alternatives considered:**  
- Mac App Store only
- Website only from the beginning
- No future distribution planning

**Impact:**  
Distribution, payment, licensing, and updates should stay separate from the core app logic.

## Decision 005: Trust Mode comes first

**Date:** 2026-07-07

**Decision:**  
The first focus validation mode will be Trust Mode.

**Reason:**  
Trust Mode is privacy-safe and easier to build first. It tracks session behavior but does not monitor other apps.

**Alternatives considered:**  
- Starting with Focus Guard
- Starting with Strict Mode
- Blocking distracting apps

**Impact:**  
The first version will focus on honest self-reporting and basic session data.

## Decision 006: AI will not control the core system

**Date:** 2026-07-07

**Decision:**  
AI may be used later for optional dialogue or summaries, but not for core logic.

**Reason:**  
Foku should demonstrate deterministic system design. XP, Bond, Momentum, progression, rewards, and pet state should be controlled by rules.

**Alternatives considered:**  
- AI deciding pet mood
- AI deciding session quality
- AI controlling rewards

**Impact:**  
The core app must work without AI.

## Decision 007: Use GitHub as the source of truth

**Date:** 2026-07-07

**Decision:**  
The project will be stored in GitHub from the beginning.

**Reason:**  
GitHub provides version history, backup, and process evidence.

**Alternatives considered:**  
- No version control
- Keeping the project only locally
- Waiting until later

**Impact:**  
Working changes should be committed regularly.

## Decision 008: Keep documentation lightweight until September

**Date:** 2026-07-07

**Decision:**  
The final IB documentation will not be written yet. Instead, short logs and decision notes will be kept during development.

**Reason:**  
The formal documentation period begins later, but early development evidence should not be lost.

**Alternatives considered:**  
- Writing the full report now
- Writing nothing until September

**Impact:**  
Documentation should be updated after meaningful development steps.

## Future decision template

## Decision XXX: Title

**Date:** YYYY-MM-DD

**Decision:**  

**Reason:**  

**Alternatives considered:**  

**Impact:**
