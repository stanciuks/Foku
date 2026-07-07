# Foku Design Decisions

Use this file as a simple decision log. Do not make it polished yet. Short notes are enough.

## Decision 001: Native macOS app

**Date:** 2026-07-07

Foku will be a native macOS app built with Swift and SwiftUI because the product idea depends on feeling like a polished menu bar utility.

## Decision 002: Local-first development

**Date:** 2026-07-07

The first version will work fully offline and store progress locally. Server features are future extensions, not requirements.

## Decision 003: No paid developer account during IB stage

**Date:** 2026-07-07

During the IB stage, Foku will be built and tested locally in Xcode. Public distribution, signing, notarization, and App Store release are future concerns.

## Decision 004: Trust Mode first

**Date:** 2026-07-07

The first tracking mode will not monitor other apps. It will track only session time, completion, breaks, pauses, and self-rating.

## Decision 005: Rule engine controls real logic

**Date:** 2026-07-07

AI will not control XP, Bond, Momentum, state, rewards, or progression. AI may only help generate text after the deterministic system has already decided the outcome.

## Decision template

```md
## Decision XXX: Title

**Date:** YYYY-MM-DD

**Decision:** What did I choose?

**Reason:** Why did I choose it?

**Alternatives considered:** What else could I have done?

**Impact:** How does this affect the app?
```
