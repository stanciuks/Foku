#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running SessionInsightEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/SessionInsightEngine.swift \
  tests/SessionInsightEngineTests.swift \
  -o /tmp/foku_session_insight_tests

/tmp/foku_session_insight_tests
