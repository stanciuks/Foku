#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Running SubjectTagEngine tests..."

swiftc \
  Foku/Foku/Models/FocusSessionState.swift \
  Foku/Foku/Models/SubjectTagEngine.swift \
  tests/SubjectTagEngineTests.swift \
  -o /tmp/foku_subject_tag_engine_tests

/tmp/foku_subject_tag_engine_tests
