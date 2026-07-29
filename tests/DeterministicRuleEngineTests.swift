import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

@main
struct DeterministicRuleEngineTestRunner {
    static func main() {
        var failures: [String] = []

        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() {
                failures.append(message)
            }
        }

        func rating(containing text: String, fallbackIndex: Int) -> SelfRating {
            if let rating = SelfRating.allCases.first(where: {
                $0.shortTitle.localizedCaseInsensitiveContains(text)
            }) {
                return rating
            }

            return SelfRating.allCases[min(fallbackIndex, SelfRating.allCases.count - 1)]
        }

        func completedSession(
            plannedMinutes: Int = 25,
            actualMinutes: Int = 25,
            pauseCount: Int = 0,
            intention: String = "[Math] Algebra practice"
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: plannedMinutes * 60,
                intention: intention
            )

            session.completed = true
            session.abandoned = false
            session.actualSeconds = actualMinutes * 60
            session.pauseCount = pauseCount

            return session
        }

        let focusedRating = rating(containing: "Focused", fallbackIndex: 0)
        let weakerRating = SelfRating.allCases.first(where: {
            $0.shortTitle.localizedCaseInsensitiveContains("Did not")
            || $0.shortTitle.localizedCaseInsensitiveContains("not")
            || $0.shortTitle.localizedCaseInsensitiveContains("distracted")
        }) ?? SelfRating.allCases.last!

        let normalSession = completedSession()
        let repeatedA = DeterministicRuleEngine.evaluate(session: normalSession, rating: focusedRating)
        let repeatedB = DeterministicRuleEngine.evaluate(session: normalSession, rating: focusedRating)

        expect(
            repeatedA.xpEarned == repeatedB.xpEarned
            && repeatedA.bondChange == repeatedB.bondChange
            && repeatedA.momentumChange == repeatedB.momentumChange
            && repeatedA.ruleSummary == repeatedB.ruleSummary,
            "Rule engine should be deterministic for identical input."
        )

        expect(
            repeatedA.xpEarned > 0,
            "Focused completed session should earn positive XP."
        )

        let weakerResult = DeterministicRuleEngine.evaluate(session: normalSession, rating: weakerRating)

        expect(
            repeatedA.xpEarned >= weakerResult.xpEarned,
            "Focused rating should not earn less XP than a weaker rating."
        )

        let pausedSession = completedSession(pauseCount: 3)
        let pausedResult = DeterministicRuleEngine.evaluate(session: pausedSession, rating: focusedRating)

        expect(
            pausedResult.momentumChange <= repeatedA.momentumChange,
            "Extra pauses should not improve Momentum compared with the same focused session."
        )

        let shortSession = completedSession(plannedMinutes: 25, actualMinutes: 10)
        let shortResult = DeterministicRuleEngine.evaluate(session: shortSession, rating: focusedRating)

        expect(
            repeatedA.xpEarned >= shortResult.xpEarned,
            "A much shorter actual session should not earn more XP than a full focused session."
        )

        expect(
            !repeatedA.ruleSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            "Rule result should include a readable rule summary."
        )

        if failures.isEmpty {
            print("✅ DeterministicRuleEngine tests passed.")
            print("Checked:")
            print("- identical input gives identical XP/Bond/Momentum/rule summary")
            print("- focused completed session earns positive XP")
            print("- weaker rating does not beat focused rating")
            print("- extra pauses do not improve Momentum")
            print("- short session does not beat full session")
            print("- rule summary is readable")
        } else {
            print("❌ DeterministicRuleEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
