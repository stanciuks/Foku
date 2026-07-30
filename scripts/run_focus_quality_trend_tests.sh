#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running FocusQualityTrendEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/FocusQualityTrendEngine.swift \
  tests/FocusQualityTrendEngineTests.swift \
  -o /tmp/foku_focus_quality_trend_tests

/tmp/foku_focus_quality_trend_tests
