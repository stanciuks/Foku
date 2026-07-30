import Foundation

@main
struct FocusQualityTrendEngineTestRunner {
    @MainActor
    static func main() {
        var failures: [String] = []

        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() {
                failures.append(message)
            }
        }

        let ratings = SelfRating.allCases

        guard ratings.count >= 3 else {
            print("❌ FocusQualityTrendEngine tests failed:")
            print("- Expected at least three SelfRating cases.")
            exit(1)
        }

        let focusedRating = ratings[0]
        let mixedRating = ratings[1]
        let unfocusedRating = ratings[2]

        func session(
            rating: SelfRating,
            completed: Bool = true,
            intention: String = "[Math] Practice",
            actualMinutes: Int = 25
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: max(actualMinutes, 1) * 60,
                intention: intention
            )

            session.completed = completed
            session.abandoned = !completed
            session.actualSeconds = actualMinutes * 60
            session.selfRating = rating

            return session
        }

        let emptyTrend = FocusQualityTrendEngine.trend(from: [])

        expect(
            emptyTrend.title == "No data yet",
            "Empty session list should produce No data yet."
        )

        expect(
            emptyTrend.ratedSessionCount == 0,
            "Empty trend should have zero rated sessions."
        )

        expect(
            emptyTrend.scorePercent == 0,
            "Empty trend should have a zero score."
        )

        let mostlyFocusedTrend = FocusQualityTrendEngine.trend(
            from: [
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: mixedRating)
            ]
        )

        expect(
            mostlyFocusedTrend.title == "Mostly focused",
            "High-quality recent sessions should be Mostly focused."
        )

        expect(
            mostlyFocusedTrend.focusedCount == 3,
            "Mostly focused trend should count three focused sessions."
        )

        expect(
            mostlyFocusedTrend.mixedCount == 1,
            "Mostly focused trend should count one mixed session."
        )

        expect(
            mostlyFocusedTrend.unfocusedCount == 0,
            "Mostly focused trend should count zero reset sessions."
        )

        expect(
            mostlyFocusedTrend.scorePercent >= 75,
            "Mostly focused trend should score at least 75%."
        )

        let mixedTrend = FocusQualityTrendEngine.trend(
            from: [
                session(rating: focusedRating),
                session(rating: mixedRating),
                session(rating: mixedRating),
                session(rating: mixedRating),
                session(rating: unfocusedRating)
            ]
        )

        expect(
            mixedTrend.title == "Mixed focus",
            "Middle-quality recent sessions should be Mixed focus."
        )

        expect(
            mixedTrend.focusedCount == 1,
            "Mixed trend should count one focused session."
        )

        expect(
            mixedTrend.mixedCount == 3,
            "Mixed trend should count three mixed sessions."
        )

        expect(
            mixedTrend.unfocusedCount == 1,
            "Mixed trend should count one reset session."
        )

        let resetTrend = FocusQualityTrendEngine.trend(
            from: [
                session(rating: mixedRating),
                session(rating: unfocusedRating),
                session(rating: unfocusedRating),
                session(rating: unfocusedRating)
            ]
        )

        expect(
            resetTrend.title == "Needs reset",
            "Low-quality recent sessions should be Needs reset."
        )

        expect(
            resetTrend.scorePercent < 45,
            "Needs reset trend should score below 45%."
        )

        let unratedSessions = [
            FocusSession(plannedSeconds: 1_500, intention: "[Biology] Cells"),
            FocusSession(plannedSeconds: 1_500, intention: "[History] Cold War")
        ]

        let unratedTrend = FocusQualityTrendEngine.trend(from: unratedSessions)

        expect(
            unratedTrend.title == "No data yet",
            "Unrated sessions should be ignored."
        )

        let limitedTrend = FocusQualityTrendEngine.trend(
            from: [
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: focusedRating),
                session(rating: unfocusedRating),
                session(rating: unfocusedRating),
                session(rating: unfocusedRating)
            ],
            limit: 7
        )

        expect(
            limitedTrend.ratedSessionCount == 7,
            "Trend should only use the requested limit of recent rated sessions."
        )

        expect(
            limitedTrend.unfocusedCount == 0,
            "Sessions outside the limit should not affect counts."
        )

        expect(
            limitedTrend.scorePercent == 100,
            "Seven focused sessions inside the limit should score 100%."
        )

        expect(
            mostlyFocusedTrend.summaryLine == "3 focused • 1 mixed • 0 reset",
            "Summary line should be human-readable and stable."
        )

        let repeatedA = FocusQualityTrendEngine.trend(
            from: [
                session(rating: focusedRating),
                session(rating: mixedRating),
                session(rating: unfocusedRating)
            ]
        )

        let repeatedB = FocusQualityTrendEngine.trend(
            from: [
                session(rating: focusedRating),
                session(rating: mixedRating),
                session(rating: unfocusedRating)
            ]
        )

        expect(
            repeatedA == repeatedB,
            "FocusQualityTrendEngine output should be deterministic for identical input."
        )

        if failures.isEmpty {
            print("✅ FocusQualityTrendEngine tests passed.")
            print("Checked:")
            print("- empty state returns No data yet")
            print("- unrated sessions are ignored")
            print("- mostly focused trend is detected")
            print("- mixed focus trend is detected")
            print("- needs reset trend is detected")
            print("- focused/mixed/reset counts are calculated")
            print("- score percentage is calculated")
            print("- recent session limit is respected")
            print("- summary line is stable")
            print("- output is deterministic")
        } else {
            print("❌ FocusQualityTrendEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
