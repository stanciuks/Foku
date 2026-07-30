#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "========================================"
echo "Foku test suite"
echo "========================================"
echo ""

echo "1/5 Running DeterministicRuleEngine tests..."
scripts/run_rule_engine_tests.sh
echo ""

echo "2/5 Running SubjectTagEngine tests..."
scripts/run_subject_tag_engine_tests.sh
echo ""

echo "3/5 Running AchievementEngine tests..."
scripts/run_achievement_engine_tests.sh
echo ""

echo "4/5 Running FeatureAccessEngine tests..."
scripts/run_feature_access_engine_tests.sh
echo ""

echo "5/5 Running app build check..."
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
