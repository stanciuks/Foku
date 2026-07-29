import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @State private var showingResetConfirmation = false

    private let compactColumns: [GridItem] = [
        GridItem(.adaptive(minimum: 260), spacing: 16, alignment: .top)
    ]

    private let wideColumns: [GridItem] = [
        GridItem(.adaptive(minimum: 360), spacing: 16, alignment: .top)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                dashboardHeader

                VStack(alignment: .leading, spacing: 14) {
                    sectionHeader(
                        title: "Today at a glance",
                        subtitle: "Goal, progress, and companion state"
                    )

                    surfaced {
                        DailyGoalView(focusedMinutesToday: sessionManager.progress.today.focusedMinutes)
                    }

                    LazyVGrid(columns: compactColumns, alignment: .leading, spacing: 16) {
                        dashboardCard(title: "Today") {
                            VStack(alignment: .leading, spacing: 10) {
                                largeMetric(title: "Sessions", value: "\(sessionManager.progress.today.completedSessions)")
                                largeMetric(title: "Focused minutes", value: "\(sessionManager.progress.today.focusedMinutes)")
                                largeMetric(title: "XP today", value: "\(sessionManager.progress.today.xpEarned)")
                            }
                        }

                        dashboardCard(title: "Progress") {
                            VStack(alignment: .leading, spacing: 10) {
                                largeMetric(title: "Level", value: "\(sessionManager.progress.level)")
                                largeMetric(title: "Total XP", value: "\(sessionManager.progress.totalXP)")
                                ProgressView(value: sessionManager.progress.levelProgress)
                                Text("\(sessionManager.progress.xpInCurrentLevel)/\(sessionManager.progress.xpNeededForNextLevel) XP to next level")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        dashboardCard(title: "Pet state") {
                            VStack(alignment: .leading, spacing: 10) {
                                PixelPetView(mood: sessionManager.petMood)
                                    .font(.system(size: 52))
                                largeMetric(title: "Mood", value: sessionManager.petMood.title)
                                largeMetric(title: "Bond", value: "\(sessionManager.progress.bond)/100")
                                largeMetric(title: "Momentum", value: "\(sessionManager.progress.momentum)/100")
                            }
                        }

                        dashboardCard(title: "Streaks") {
                            VStack(alignment: .leading, spacing: 10) {
                                largeMetric(title: "Current streak", value: "\(sessionManager.progress.currentStreak) day(s)")
                                largeMetric(title: "Best streak", value: "\(sessionManager.progress.bestStreak) day(s)")
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    sectionHeader(
                        title: "Study analytics",
                        subtitle: "Weekly trends and subject patterns"
                    )

                    LazyVGrid(columns: wideColumns, alignment: .leading, spacing: 16) {
                        surfaced {
                            WeeklyStatsView(sessions: sessionManager.recentSessions)
                        }

                        surfaced {
                            WeeklyFocusChartView(sessions: sessionManager.recentSessions)
                        }

                        surfaced {
                            SubjectBreakdownView(sessions: sessionManager.recentSessions)
                        }

                        dashboardCard(title: "Daily missions") {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(sessionManager.dailyMissionSummary)
                                    .font(.body)
                                    .fontWeight(.semibold)

                                ForEach(sessionManager.dailyMissions) { mission in
                                    missionRow(mission)
                                }
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    sectionHeader(
                        title: "Motivation system",
                        subtitle: "Milestones and transparent rule feedback"
                    )

                    LazyVGrid(columns: wideColumns, alignment: .leading, spacing: 16) {
                        surfaced {
                            AchievementsView()
                        }

                        dashboardCard(title: "Rule transparency") {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(sessionManager.ruleSummaryText)
                                    .font(.body)

                                Text("Rewards are calculated by deterministic app rules, not by AI.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    sectionHeader(
                        title: "History",
                        subtitle: "Recent rated sessions and reflection notes"
                    )

                    dashboardCard(title: "Recent sessions") {
                        if sessionManager.recentSessions.isEmpty {
                            Text("No finished sessions yet.")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        } else {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(Array(sessionManager.recentSessions.prefix(5))) { session in
                                    sessionHistoryRow(session)
                                }
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    sectionHeader(
                        title: "Privacy and local data",
                        subtitle: "Local-first prototype controls"
                    )

                    LazyVGrid(columns: wideColumns, alignment: .leading, spacing: 16) {
                        dashboardCard(title: "Privacy & modes") {
                            VStack(alignment: .leading, spacing: 12) {
                                largeMetric(title: "Current mode", value: sessionManager.privacyModeTitle)

                                Text(sessionManager.privacyModeDescription)
                                    .font(.body)

                                Text(sessionManager.focusGuardStatus)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text("No websites, messages, files, screen content, keyboard activity, or browsing history are collected.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        dashboardCard(title: "Settings & local data") {
                            VStack(alignment: .leading, spacing: 12) {
                                largeMetric(title: "Saved data location", value: "Local UserDefaults")

                                Text("This prototype saves progress only on this Mac. Resetting data is useful for testing first-run behavior and empty daily missions.")
                                    .font(.body)

                                Button("Reset local prototype data", role: .destructive) {
                                    showingResetConfirmation = true
                                }

                                Text("This does not delete source code, Git commits, screenshots, or documentation.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(28)
            .frame(maxWidth: 1160, alignment: .topLeading)
        }
        .frame(minWidth: 980, minHeight: 720)
        .alert("Reset local prototype data?", isPresented: $showingResetConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                sessionManager.resetLocalPrototypeData()
            }
        } message: {
            Text("This clears saved XP, Bond, Momentum, streaks, missions, and recent sessions on this Mac. It does not affect GitHub or evidence screenshots.")
        }
    }

    private var dashboardHeader: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Foku Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Local progress overview")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Trust Mode")
                    .font(.caption)
                    .fontWeight(.semibold)

                Text("Local-first prototype")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.secondary.opacity(0.10))
            )
        }
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func surfaced<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.secondary.opacity(0.11))
            )
    }

    private func missionRow(_ mission: DailyMission) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(mission.completed ? "✓" : "○")
                .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
                Text(mission.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(mission.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(mission.statusText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(.quaternary.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private func sessionHistoryRow(_ session: FocusSession) -> some View {
        let bondText = session.bondChange >= 0 ? "+\(session.bondChange)" : "\(session.bondChange)"
        let momentumText = session.momentumChange >= 0 ? "+\(session.momentumChange)" : "\(session.momentumChange)"
        let rawIntentionText = session.intentionText.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanIntentionText = rawIntentionText.hasPrefix("Intention: ")
            ? String(rawIntentionText.dropFirst("Intention: ".count))
            : rawIntentionText
        let hasReflection = !session.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        return VStack(alignment: .leading, spacing: 11) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(session.completed ? "Completed session" : "Incomplete session")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text(session.startTime.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("+\(session.xpEarned) XP")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.secondary.opacity(0.12))
                    )
            }

            HStack(spacing: 8) {
                historyMetricPill(title: "Time", value: "\(session.actualMinutesRoundedDown)m")
                historyMetricPill(title: "Rating", value: session.ratingText)
                historyMetricPill(title: "Bond", value: bondText)
                historyMetricPill(title: "Momentum", value: momentumText)
            }

            if !cleanIntentionText.isEmpty {
                Label(cleanIntentionText, systemImage: "target")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if hasReflection {
                VStack(alignment: .leading, spacing: 4) {
                    Label("Reflection", systemImage: "text.bubble")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    Text(session.reflectionNote)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if !session.ruleSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(session.ruleSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.secondary.opacity(0.09))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary.opacity(0.16), lineWidth: 1)
        )
    }

    private func dashboardCard<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.headline)

            content()
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func largeMetric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func signed(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)"
        }

        return "\(value)"
    }

    private func historyMetricPill(title: String, value: String) -> some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary.opacity(0.10))
        )
    }
}
