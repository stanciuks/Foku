import Foundation

enum DeterministicRuleEngine {
    static func evaluate(session: FocusSession, rating: SelfRating) -> SessionRuleResult {
        let plannedMinutes = max(1, session.plannedMinutes)
        let baseXP = Int(Double(plannedMinutes) * 1.2)

        let completionMultiplier = session.completed ? 1.0 : 0.25
        let ratingMultiplier = rating.focusQualityMultiplier
        let calculatedXP = Double(baseXP) * completionMultiplier * ratingMultiplier
        let xp = max(1, Int(calculatedXP.rounded()))

        let bondChange: Int
        let momentumChange: Int
        let message: String

        if session.completed {
            switch rating {
            case .focused:
                bondChange = 3
                momentumChange = 8
                message = "Strong focused effort. Foku is proud. +\(xp) XP"
            case .partlyDistracted:
                bondChange = 2
                momentumChange = 4
                message = "Honest check-in saved. Progress still counts. +\(xp) XP"
            case .didNotReallyStudy:
                bondChange = 1
                momentumChange = -2
                message = "Thanks for being honest. Let's restart gently. +\(xp) XP"
            }
        } else {
            switch rating {
            case .focused:
                bondChange = 1
                momentumChange = -1
                message = "Even though it was abandoned, some focus happened. +\(xp) XP"
            case .partlyDistracted:
                bondChange = 1
                momentumChange = -3
                message = "Not the best session, but the check-in helps. +\(xp) XP"
            case .didNotReallyStudy:
                bondChange = 0
                momentumChange = -5
                message = "That session did not really work. Try a smaller restart. +\(xp) XP"
            }
        }

        let status = session.completed ? "Completed" : "Abandoned"

        return SessionRuleResult(
            xpEarned: xp,
            bondChange: bondChange,
            momentumChange: momentumChange,
            message: message,
            ruleSummary: "\(status) × \(rating.title) → +\(xp) XP, \(signed(bondChange)) Bond, \(signed(momentumChange)) Momentum"
        )
    }

    static func mood(for progress: UserProgress) -> PetMood {
        if progress.momentum < 15 {
            return .neutral
        }

        if progress.bond >= 70 && progress.momentum >= 50 {
            return .proud
        }

        if progress.momentum >= 25 || progress.bond >= 60 {
            return .encouraged
        }

        return .neutral
    }

    private static func signed(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)"
        }

        return "\(value)"
    }
}

enum DailyMissionEngine {
    static func missions(progress: UserProgress, recentSessions: [FocusSession]) -> [DailyMission] {
        let todaysSessions = recentSessions.filter { isFromToday($0) }
        let hasIntentionToday = todaysSessions.contains { session in
            !session.intention.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        return [
            DailyMission(
                id: "complete-one-session",
                title: "Complete one focus session",
                description: "Finish and rate at least one session today.",
                completed: progress.today.completedSessions >= 1
            ),
            DailyMission(
                id: "earn-thirty-xp",
                title: "Earn 30 XP",
                description: "Use focused study to earn at least 30 XP today.",
                completed: progress.today.xpEarned >= 30
            ),
            DailyMission(
                id: "set-study-intention",
                title: "Set a study intention",
                description: "Write what you are studying before starting.",
                completed: hasIntentionToday
            )
        ]
    }

    private static func isFromToday(_ session: FocusSession) -> Bool {
        let date = session.endTime ?? session.startTime
        return DailyStudyStats.currentDayKey(date: date) == DailyStudyStats.currentDayKey()
    }
}
