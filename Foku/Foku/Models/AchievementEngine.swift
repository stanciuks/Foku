import Foundation

struct FokuAchievement: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String
    let systemImage: String
    let isUnlocked: Bool
    let progressText: String
}

enum AchievementEngine {
    static func achievements(
        progress: UserProgress,
        recentSessions: [FocusSession],
        dailyGoalMinutes: Int
    ) -> [FokuAchievement] {
        let ratedSessions = recentSessions.filter { $0.selfRating != nil }
        let completedRatedSessions = ratedSessions.filter { $0.completed }
        let reflectedSessions = ratedSessions.filter {
            !$0.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        let sessionsWithIntention = ratedSessions.filter {
            !$0.intention.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        let todayFocusedMinutes = progress.today.focusedMinutes
        let safeDailyGoal = max(dailyGoalMinutes, 1)

        return [
            FokuAchievement(
                id: "first-rated-session",
                title: "First self-check",
                detail: "Complete a session and submit a focus rating.",
                systemImage: "checkmark.circle",
                isUnlocked: !ratedSessions.isEmpty,
                progressText: ratedSessions.isEmpty ? "0 / 1" : "1 / 1"
            ),
            FokuAchievement(
                id: "daily-goal-reached",
                title: "Daily goal reached",
                detail: "Reach your daily focus goal with completed and rated sessions.",
                systemImage: "target",
                isUnlocked: todayFocusedMinutes >= safeDailyGoal,
                progressText: "\(min(todayFocusedMinutes, safeDailyGoal)) / \(safeDailyGoal)m"
            ),
            FokuAchievement(
                id: "reflective-learner",
                title: "Reflective learner",
                detail: "Save a reflection note after a session.",
                systemImage: "text.bubble",
                isUnlocked: !reflectedSessions.isEmpty,
                progressText: reflectedSessions.isEmpty ? "0 / 1" : "1 / 1"
            ),
            FokuAchievement(
                id: "intentional-study",
                title: "Intentional study",
                detail: "Start a session with a study intention or subject tag.",
                systemImage: "pencil.and.list.clipboard",
                isUnlocked: !sessionsWithIntention.isEmpty,
                progressText: sessionsWithIntention.isEmpty ? "0 / 1" : "1 / 1"
            ),
            FokuAchievement(
                id: "three-completed-sessions",
                title: "Three-session rhythm",
                detail: "Build rhythm by completing three rated sessions in recent history.",
                systemImage: "3.circle",
                isUnlocked: completedRatedSessions.count >= 3,
                progressText: "\(min(completedRatedSessions.count, 3)) / 3"
            ),
            FokuAchievement(
                id: "xp-100",
                title: "100 XP earned",
                detail: "Earn 100 total XP through focused sessions.",
                systemImage: "sparkles",
                isUnlocked: progress.totalXP >= 100,
                progressText: "\(min(progress.totalXP, 100)) / 100 XP"
            ),
            FokuAchievement(
                id: "bond-60",
                title: "Bond builder",
                detail: "Raise the pet Bond score to 60 or higher.",
                systemImage: "heart",
                isUnlocked: progress.bond >= 60,
                progressText: "\(min(progress.bond, 60)) / 60"
            ),
            FokuAchievement(
                id: "momentum-50",
                title: "Momentum builder",
                detail: "Raise Momentum to 50 or higher.",
                systemImage: "bolt",
                isUnlocked: progress.momentum >= 50,
                progressText: "\(min(progress.momentum, 50)) / 50"
            ),
            FokuAchievement(
                id: "two-day-streak",
                title: "Two-day streak",
                detail: "Complete rated focus sessions on two consecutive days.",
                systemImage: "flame",
                isUnlocked: progress.bestStreak >= 2,
                progressText: "\(min(progress.bestStreak, 2)) / 2 days"
            )
        ]
    }
}
