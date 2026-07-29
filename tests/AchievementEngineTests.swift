import Foundation

@main
struct AchievementEngineTestRunner {
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

        func ratedSession(
            intention: String = "[Math] Algebra",
            reflectionNote: String = "",
            actualMinutes: Int = 25,
            completed: Bool = true
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: max(actualMinutes, 1) * 60,
                intention: intention
            )

            session.completed = completed
            session.abandoned = false
            session.actualSeconds = actualMinutes * 60
            session.selfRating = rating()
            session.reflectionNote = reflectionNote

            return session
        }

        func achievement(
            _ id: String,
            in achievements: [FokuAchievement]
        ) -> FokuAchievement? {
            achievements.first { $0.id == id }
        }

        var progress = UserProgress()
        progress.totalXP = 120
        progress.bond = 65
        progress.momentum = 55
        progress.bestStreak = 2
        progress.today.focusedMinutes = 60

        let sessions = [
            ratedSession(reflectionNote: "I stayed focused."),
            ratedSession(intention: "[History] Causes of war", actualMinutes: 20),
            ratedSession(intention: "", actualMinutes: 10)
        ]

        let achievements = AchievementEngine.achievements(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60
        )

        let ids = achievements.map { $0.id }
        expect(
            Set(ids).count == ids.count,
            "Achievement ids should be unique."
        )

        expect(
            achievement("first-rated-session", in: achievements)?.isUnlocked == true,
            "First self-check should unlock when there is a rated session."
        )

        expect(
            achievement("daily-goal-reached", in: achievements)?.isUnlocked == true,
            "Daily goal should unlock when today's focused minutes reach the daily goal."
        )

        expect(
            achievement("reflective-learner", in: achievements)?.isUnlocked == true,
            "Reflective learner should unlock when at least one rated session has a reflection note."
        )

        expect(
            achievement("intentional-study", in: achievements)?.isUnlocked == true,
            "Intentional study should unlock when at least one rated session has an intention."
        )

        expect(
            achievement("three-completed-sessions", in: achievements)?.isUnlocked == true,
            "Three-session rhythm should unlock after three completed rated sessions."
        )

        expect(
            achievement("xp-100", in: achievements)?.isUnlocked == true,
            "100 XP achievement should unlock when total XP is at least 100."
        )

        expect(
            achievement("bond-60", in: achievements)?.isUnlocked == true,
            "Bond builder should unlock when Bond is at least 60."
        )

        expect(
            achievement("momentum-50", in: achievements)?.isUnlocked == true,
            "Momentum builder should unlock when Momentum is at least 50."
        )

        expect(
            achievement("two-day-streak", in: achievements)?.isUnlocked == true,
            "Two-day streak should unlock when best streak is at least 2."
        )

        var lockedProgress = UserProgress()
        lockedProgress.today.focusedMinutes = 0
        lockedProgress.totalXP = 0
        lockedProgress.bond = 50
        lockedProgress.momentum = 0
        lockedProgress.bestStreak = 0

        let lockedAchievements = AchievementEngine.achievements(
            progress: lockedProgress,
            recentSessions: [],
            dailyGoalMinutes: 60
        )

        expect(
            achievement("first-rated-session", in: lockedAchievements)?.isUnlocked == false,
            "First self-check should stay locked with no rated sessions."
        )

        expect(
            achievement("daily-goal-reached", in: lockedAchievements)?.progressText == "0 / 60m",
            "Daily goal progress text should show current focused minutes against the goal."
        )

        expect(
            achievement("reflective-learner", in: lockedAchievements)?.isUnlocked == false,
            "Reflective learner should stay locked with no reflection notes."
        )

        let repeatedA = AchievementEngine.achievements(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60
        )

        let repeatedB = AchievementEngine.achievements(
            progress: progress,
            recentSessions: sessions,
            dailyGoalMinutes: 60
        )

        expect(
            repeatedA == repeatedB,
            "AchievementEngine output should be deterministic for identical input."
        )

        if failures.isEmpty {
            print("✅ AchievementEngine tests passed.")
            print("Checked:")
            print("- achievement ids are unique")
            print("- rated session unlocks first self-check")
            print("- daily goal achievement unlocks at the goal")
            print("- reflection achievement unlocks with a reflection note")
            print("- intention achievement unlocks with an intention")
            print("- XP, Bond, Momentum, and streak achievements unlock at thresholds")
            print("- locked state remains locked without progress")
            print("- progress text is sensible")
            print("- output is deterministic")
        } else {
            print("❌ AchievementEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
