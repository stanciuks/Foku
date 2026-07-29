#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running AchievementEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/AchievementEngine.swift \
  tests/AchievementEngineTests.swift \
  -o /tmp/foku_achievement_engine_tests

/tmp/foku_achievement_engine_tests
