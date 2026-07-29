import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @AppStorage("foku.dailyGoalMinutes") private var dailyGoalMinutes = 60

    private var achievements: [FokuAchievement] {
        AchievementEngine.achievements(
            progress: sessionManager.progress,
            recentSessions: sessionManager.recentSessions,
            dailyGoalMinutes: dailyGoalMinutes
        )
    }

    private var unlockedCount: Int {
        achievements.filter { $0.isUnlocked }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 220), spacing: 10)], spacing: 10) {
                ForEach(achievements) { achievement in
                    achievementCard(achievement)
                }
            }
        }
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Achievements")
                    .font(.headline)

                Text("Deterministic milestones based on local study data.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("\(unlockedCount) / \(achievements.count)")
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.secondary.opacity(0.12))
                )
        }
    }

    private func achievementCard(_ achievement: FokuAchievement) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: achievement.systemImage)
                .font(.title3)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(Color.secondary.opacity(achievement.isUnlocked ? 0.16 : 0.08))
                )
                .opacity(achievement.isUnlocked ? 1.0 : 0.45)

            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .firstTextBaseline) {
                    Text(achievement.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    Text(achievement.isUnlocked ? "Unlocked" : "Locked")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }

                Text(achievement.detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(achievement.progressText)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.secondary.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.secondary.opacity(achievement.isUnlocked ? 0.18 : 0.10), lineWidth: 1)
        )
    }
}
