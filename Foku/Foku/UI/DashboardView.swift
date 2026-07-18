import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @State private var showingResetConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                dashboardHeader

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 360), spacing: 18)], alignment: .leading, spacing: 18) {
                    WeeklyStatsView(sessions: sessionManager.recentSessions)
                        .padding(26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.secondary.opacity(0.12))
                        )
                        .padding(.bottom, 4)

                WeeklyFocusChartView(sessions: sessionManager.recentSessions)
                    .padding(26)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.12))
                    )
                    .padding(.bottom, 4)

                SubjectBreakdownView(sessions: sessionManager.recentSessions)
                    .padding(26)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.12))
                    )
                    .padding(.bottom, 4)

                AchievementsView(sessions: sessionManager.recentSessions)
                    .padding(26)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.12))
                    )
                    .padding(.bottom, 4)

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
                                .font(.system(size: 54))
                            largeMetric(title: "Mood", value: sessionManager.petMood.title)
                            largeMetric(title: "Bond", value: "\(sessionManager.progress.bond)/100")
                            largeMetric(title: "Momentum", value: "\(sessionManager.progress.momentum)/100")
                        }
                    }

                    dashboardCard(title: "Today") {
                        VStack(alignment: .leading, spacing: 10) {
                            largeMetric(title: "Sessions", value: "\(sessionManager.progress.today.completedSessions)")
                            largeMetric(title: "Focused minutes", value: "\(sessionManager.progress.today.focusedMinutes)")
                            largeMetric(title: "XP today", value: "\(sessionManager.progress.today.xpEarned)")
                        }
                    }
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 360), spacing: 18)], alignment: .leading, spacing: 18) {
                    dashboardCard(title: "Streaks") {
                        VStack(alignment: .leading, spacing: 10) {
                            largeMetric(title: "Current streak", value: "\(sessionManager.progress.currentStreak) day(s)")
                            largeMetric(title: "Best streak", value: "\(sessionManager.progress.bestStreak) day(s)")
                        }
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
            .padding(28)
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
        VStack(alignment: .leading, spacing: 6) {
            Text("Foku Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Local progress overview")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
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
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(session.statusText)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Spacer()

                Text(formatDate(session.endTime ?? session.startTime))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("\(session.actualMinutesRoundedDown)/\(session.plannedMinutes) min • \(session.ratingText) • +\(session.xpEarned) XP • \(signed(session.bondChange)) Bond • \(signed(session.momentumChange)) Momentum")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("Intention: \(session.intentionText)")
                .font(.caption2)
                .foregroundStyle(.secondary)

            if let ruleSummary = session.ruleSummary {
                Text(ruleSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(10)
        .background(.quaternary.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
}
