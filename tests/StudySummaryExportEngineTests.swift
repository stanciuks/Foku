import Foundation

@main
struct StudySummaryExportEngineTestRunner {
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

        func session(
            intention: String,
            reflectionNote: String = "",
            actualMinutes: Int = 25,
            xp: Int = 18
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: actualMinutes * 60,
                intention: intention
            )

            session.completed = true
            session.abandoned = false
            session.actualSeconds = actualMinutes * 60
            session.selfRating = rating()
            session.reflectionNote = reflectionNote
            session.xpEarned = xp
            session.ruleSummary = "Completed × Focused → +18 XP"

            return session
        }

        var progress = UserProgress()
        progress.level = 5
        progress.totalXP = 430
        progress.bond = 100
        progress.momentum = 100
        progress.currentStreak = 2
        progress.bestStreak = 2
        progress.today.focusedMinutes = 40
        progress.today.completedSessions = 2
        progress.today.xpEarned = 36

        let fixedDate = Date(timeIntervalSince1970: 1_785_425_040)

        let sessions = [
            session(
                intention: "[Math] Calculus practice",
                reflectionNote: "Solved practice problems.",
                actualMinutes: 25,
                xp: 18
            ),
            session(
                intention: "[Biology] Cell revision",
                actualMinutes: 15,
                xp: 18
            )
        ]

        let markdown = StudySummaryExportEngine.makeMarkdown(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60,
            privacyModeTitle: "Trust Mode",
            generatedAt: fixedDate
        )

        expect(
            markdown.contains("# Foku Study Summary"),
            "Markdown should include the summary title."
        )

        expect(
            markdown.contains("Privacy mode: Trust Mode"),
            "Markdown should include the privacy mode."
        )

        expect(
            markdown.contains("## Progress"),
            "Markdown should include a Progress section."
        )

        expect(
            markdown.contains("- Level: 5"),
            "Markdown should include the current level."
        )

        expect(
            markdown.contains("- Total XP: 430"),
            "Markdown should include total XP."
        )

        expect(
            markdown.contains("## Today"),
            "Markdown should include a Today section."
        )

        expect(
            markdown.contains("- Focused minutes today: 40 / 60m"),
            "Markdown should include daily goal progress."
        )

        expect(
            markdown.contains("## Recent activity"),
            "Markdown should include a Recent activity section."
        )

        expect(
            markdown.contains("- Recent completed sessions: 2"),
            "Markdown should count completed sessions."
        )

        expect(
            markdown.contains("- Recent focused minutes: 40m"),
            "Markdown should total recent focused minutes."
        )

        expect(
            markdown.contains("## Subject breakdown"),
            "Markdown should include a Subject breakdown section."
        )

        expect(
            markdown.contains("- Math: 25m"),
            "Markdown should include Math subject minutes."
        )

        expect(
            markdown.contains("- Biology: 15m"),
            "Markdown should include Biology subject minutes."
        )

        expect(
            markdown.contains("## Achievements"),
            "Markdown should include an Achievements section."
        )

        expect(
            markdown.contains("- Unlocked achievements:"),
            "Markdown should include achievement unlock count."
        )

        expect(
            markdown.contains("## Recent sessions"),
            "Markdown should include a Recent sessions section."
        )

        expect(
            markdown.contains("Intention: [Math] Calculus practice"),
            "Markdown should include recent session intention."
        )

        expect(
            markdown.contains("Reflection: Solved practice problems."),
            "Markdown should include recent session reflection."
        )

        expect(
            markdown.contains("## Privacy note"),
            "Markdown should include a Privacy note section."
        )

        expect(
            markdown.contains("does not collect websites, messages, files, screen contents, keyboard activity, or browser history"),
            "Markdown should include the local-first privacy promise."
        )

        let emptyMarkdown = StudySummaryExportEngine.makeMarkdown(
            progress: UserProgress(),
            recentSessions: [],
            dailyGoalMinutes: 60,
            privacyModeTitle: "Trust Mode",
            generatedAt: fixedDate
        )

        expect(
            emptyMarkdown.contains("- No subject data yet."),
            "Empty export should explain when subject data is missing."
        )

        expect(
            emptyMarkdown.contains("- No recent sessions yet."),
            "Empty export should explain when recent sessions are missing."
        )

        let repeatedA = StudySummaryExportEngine.makeMarkdown(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60,
            privacyModeTitle: "Trust Mode",
            generatedAt: fixedDate
        )

        let repeatedB = StudySummaryExportEngine.makeMarkdown(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60,
            privacyModeTitle: "Trust Mode",
            generatedAt: fixedDate
        )

        expect(
            repeatedA == repeatedB,
            "StudySummaryExportEngine output should be deterministic when generatedAt is fixed."
        )

        let fileName = StudySummaryExportEngine.fileName(generatedAt: fixedDate)

        expect(
            fileName.hasPrefix("Foku-study-summary-"),
            "Export filename should have the Foku-study-summary prefix."
        )

        expect(
            fileName.hasSuffix(".md"),
            "Export filename should end with .md."
        )

        if failures.isEmpty {
            print("✅ StudySummaryExportEngine tests passed.")
            print("Checked:")
            print("- Markdown title exists")
            print("- Progress section exists")
            print("- Today section exists")
            print("- Recent activity section exists")
            print("- Subject breakdown is included")
            print("- Achievements count is included")
            print("- Recent sessions include intention and reflection")
            print("- Privacy note is included")
            print("- Empty state text is included")
            print("- filename uses .md")
            print("- output is deterministic with fixed generatedAt")
        } else {
            print("❌ StudySummaryExportEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
