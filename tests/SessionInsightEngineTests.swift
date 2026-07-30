import Foundation

@main
struct SessionInsightEngineTestRunner {
    static func main() {
        var failures: [String] = []

        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() {
                failures.append(message)
            }
        }

        func rating() -> SelfRating {
            SelfRating.allCases.first!
        }

        func completedSession(
            intention: String = "[Math] Algebra practice",
            reflectionNote: String = "I stayed focused.",
            actualMinutes: Int = 25
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: max(actualMinutes, 1) * 60,
                intention: intention
            )

            session.completed = true
            session.abandoned = false
            session.actualSeconds = actualMinutes * 60
            session.selfRating = rating()
            session.reflectionNote = reflectionNote

            return session
        }

        func insight(
            _ id: String,
            in insights: [SessionInsight]
        ) -> SessionInsight? {
            insights.first { $0.id == id }
        }

        let strongSession = completedSession()
        let strongInsights = SessionInsightEngine.insights(for: strongSession)

        expect(
            strongInsights.count == 4,
            "A completed session should produce four insights."
        )

        expect(
            Set(strongInsights.map { $0.id }).count == strongInsights.count,
            "Insight ids should be unique."
        )

        expect(
            insight("focus-outcome", in: strongInsights)?.value == "Session completed",
            "Completed session should show a completed focus outcome."
        )

        expect(
            insight("subject", in: strongInsights)?.value == "Math",
            "Tagged session should extract the Math subject."
        )

        expect(
            insight("reflection", in: strongInsights)?.value == "Saved",
            "Session with reflection note should show reflection saved."
        )

        expect(
            insight("next-step", in: strongInsights)?.value == "Repeat the pattern",
            "Strong session with tag and reflection should recommend repeating the pattern."
        )

        let noSubjectSession = completedSession(
            intention: "Read chapter 2",
            reflectionNote: "I got through the reading.",
            actualMinutes: 20
        )

        let noSubjectInsights = SessionInsightEngine.insights(for: noSubjectSession)

        expect(
            insight("subject", in: noSubjectInsights)?.value == "No subject tag",
            "Session without bracket tags should show no subject tag."
        )

        expect(
            insight("next-step", in: noSubjectInsights)?.value == "Tag the subject",
            "Session with reflection but no tag should recommend adding a subject tag."
        )

        let noReflectionSession = completedSession(
            intention: "[Biology] Cells",
            reflectionNote: "",
            actualMinutes: 15
        )

        let noReflectionInsights = SessionInsightEngine.insights(for: noReflectionSession)

        expect(
            insight("reflection", in: noReflectionInsights)?.value == "Not saved",
            "Session without reflection should show reflection not saved."
        )

        expect(
            insight("next-step", in: noReflectionInsights)?.value == "Add reflection",
            "Session without reflection should recommend adding reflection."
        )

        let shortSession = completedSession(
            intention: "[History] Cold War",
            reflectionNote: "Quick review.",
            actualMinutes: 3
        )

        let shortInsights = SessionInsightEngine.insights(for: shortSession)

        expect(
            insight("next-step", in: shortInsights)?.value == "Try a longer block",
            "Very short session should recommend a longer focus block."
        )

        var incompleteSession = completedSession(
            intention: "[Physics] Waves",
            reflectionNote: "",
            actualMinutes: 8
        )
        incompleteSession.completed = false

        let incompleteInsights = SessionInsightEngine.insights(for: incompleteSession)

        expect(
            insight("focus-outcome", in: incompleteInsights)?.value == "Session recorded",
            "Incomplete session should show session recorded instead of completed."
        )

        let repeatedA = SessionInsightEngine.insights(for: strongSession)
        let repeatedB = SessionInsightEngine.insights(for: strongSession)

        expect(
            repeatedA == repeatedB,
            "SessionInsightEngine output should be deterministic for identical input."
        )

        if failures.isEmpty {
            print("✅ SessionInsightEngine tests passed.")
            print("Checked:")
            print("- completed session produces four insights")
            print("- insight ids are unique")
            print("- completed session outcome is detected")
            print("- subject tag is extracted")
            print("- missing subject tag is detected")
            print("- saved reflection is detected")
            print("- missing reflection is detected")
            print("- short sessions recommend a longer block")
            print("- complete strong sessions recommend repeating the pattern")
            print("- incomplete sessions are handled")
            print("- output is deterministic")
        } else {
            print("❌ SessionInsightEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
