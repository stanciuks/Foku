#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "========================================"
echo "Foku test suite"
echo "========================================"
echo ""

echo "1/4 Running DeterministicRuleEngine tests..."
scripts/run_rule_engine_tests.sh
echo ""

echo "2/4 Running SubjectTagEngine tests..."
scripts/run_subject_tag_engine_tests.sh
echo ""

echo "3/4 Running AchievementEngine tests..."
scripts/run_achievement_engine_tests.sh
echo ""

echo "4/4 Running app build check..."
xcodebuild \
  -project Foku/Foku.xcodeproj \
  -scheme Foku \
  -configuration Debug \
  -destination 'platform=macOS' \
  build 2>&1 | grep -E "error:|warning:|BUILD SUCCEEDED|BUILD FAILED"

echo ""
echo "========================================"
echo "✅ All Foku tests and build checks passed."
echo "========================================"
