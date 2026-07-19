import SwiftUI

struct AchievementsView: View {
    @AppStorage("foku.dailyGoalMinutes") private var dailyGoalMinutes: Int = 60

    let sessions: [FocusSession]
    let focusedMinutesToday: Int

    private var completedSessions: [FocusSession] {
        sessions.filter { $0.completed }
    }

    private var focusedMinutes: Int {
        completedSessions.reduce(0) { total, session in
            guard let endTime = session.endTime else {
                return total
            }

            let seconds = max(0, endTime.timeIntervalSince(session.startTime))
            return total + Int(seconds / 60)
        }
    }


    private var clampedDailyGoalMinutes: Int {
        min(max(dailyGoalMinutes, 15), 240)
    }

    private var activeDays: Int {
        let dayKeys = Set(completedSessions.map { session in
            DailyStudyStats.currentDayKey(date: session.startTime)
        })

        return dayKeys.count
    }

    private var taggedSessionCount: Int {
        completedSessions.filter { session in
            session.intention.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("[")
        }
        .count
    }

    private var achievements: [AchievementItem] {
        [
            AchievementItem(
                title: "First Focus",
                description: "Complete your first focus session.",
                unlocked: completedSessions.count >= 1
            ),
            AchievementItem(
                title: "Getting Consistent",
                description: "Complete 3 focus sessions.",
                unlocked: completedSessions.count >= 3
            ),
            AchievementItem(
                title: "One Focus Hour",
                description: "Reach 60 completed focus minutes.",
                unlocked: focusedMinutes >= 60
            ),
            AchievementItem(
                title: "Daily Goal Reached",
                description: "Reach your local daily focus goal.",
                unlocked: focusedMinutesToday >= clampedDailyGoalMinutes
            ),
            AchievementItem(
                title: "Subject Explorer",
                description: "Complete a session with a subject tag.",
                unlocked: taggedSessionCount >= 1
            ),
            AchievementItem(
                title: "Three Active Days",
                description: "Study on 3 different days.",
                unlocked: activeDays >= 3
            )
        ]
    }

    private var unlockedCount: Int {
        achievements.filter { $0.unlocked }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Achievements")
                        .font(.headline)

                    Text("Prototype milestones based on local session history")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(unlockedCount)/\(achievements.count)")
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            VStack(spacing: 8) {
                ForEach(achievements) { achievement in
                    HStack(alignment: .top, spacing: 10) {
                        Text(achievement.unlocked ? "✓" : "○")
                            .font(.headline)
                            .frame(width: 22)

                        VStack(alignment: .leading, spacing: 3) {
                            Text(achievement.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(achievement.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer()

                        Text(achievement.unlocked ? "Unlocked" : "Locked")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .frame(minWidth: 58, alignment: .trailing)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(achievement.unlocked ? Color.accentColor.opacity(0.14) : Color.secondary.opacity(0.10))
                    )
                }
            }

            Text("Achievements are calculated locally and do not require AI or cloud sync.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AchievementItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let unlocked: Bool
}
