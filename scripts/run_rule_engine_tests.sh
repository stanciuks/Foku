#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running DeterministicRuleEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/RuleEngines.swift \
  tests/DeterministicRuleEngineTests.swift \
  -o /tmp/foku_rule_engine_tests

/tmp/foku_rule_engine_tests
