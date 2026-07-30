#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running FeatureAccessEngine tests..."

swiftc \
  Foku/Foku/Models/FeatureAccessEngine.swift \
  tests/FeatureAccessEngineTests.swift \
  -o /tmp/foku_feature_access_engine_tests

/tmp/foku_feature_access_engine_tests
