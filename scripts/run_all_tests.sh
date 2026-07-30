#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "========================================"
echo "Foku test suite"
echo "========================================"
echo ""

echo "1/8 Running DeterministicRuleEngine tests..."
scripts/run_rule_engine_tests.sh
echo ""

echo "2/8 Running SubjectTagEngine tests..."
scripts/run_subject_tag_engine_tests.sh
echo ""

echo "3/8 Running AchievementEngine tests..."
scripts/run_achievement_engine_tests.sh
echo ""

echo "4/8 Running FeatureAccessEngine tests..."
scripts/run_feature_access_engine_tests.sh
echo ""

echo "5/8 Running StudySummaryExportEngine tests..."
scripts/run_study_summary_export_tests.sh
echo ""

echo "6/8 Running SessionInsightEngine tests..."
scripts/run_session_insight_tests.sh
echo ""

echo "7/8 Running FocusQualityTrendEngine tests..."
scripts/run_focus_quality_trend_tests.sh
echo ""

echo "8/8 Running app build check..."
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
