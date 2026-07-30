#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running StudySummaryExportEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/AchievementEngine.swift \
  Foku/Foku/Models/StudySummaryExportEngine.swift \
  tests/StudySummaryExportEngineTests.swift \
  -o /tmp/foku_study_summary_export_tests

/tmp/foku_study_summary_export_tests
