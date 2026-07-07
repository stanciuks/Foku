import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                headerSection

                Divider()

                TimerPanelView()

                if sessionManager.latestSessionNeedsRating {
                    Divider()
                    SelfRatingPanelView()
                }

                Divider()

                progressSection

                Divider()

                relationshipSection

                Divider()

                todaySection

                Divider()

                ruleSection

                Divider()

                statsSection

                Divider()

                recentSessionSection

                Divider()

                dashboardButton
            }
            .padding(18)
        }
        .frame(width: 420, height: 620)
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Foku")
                .font(.title2)
                .fontWeight(.semibold)

            Text(sessionManager.petMood.face)
                .font(.system(size: 56))
                .padding(.top, 4)

            Text("\(sessionManager.stateTitle) • \(sessionManager.petMood.title)")
                .font(.headline)

            Text(sessionManager.petMood.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Text(sessionManager.lastMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                metricBlock(title: "Level", value: "\(sessionManager.progress.level)")
                Spacer()
                metricBlock(title: "Total XP", value: "\(sessionManager.progress.totalXP)")
            }

            ProgressView(value: sessionManager.progress.levelProgress)
                .progressViewStyle(.linear)

            Text("\(sessionManager.progress.xpInCurrentLevel)/\(sessionManager.progress.xpNeededForNextLevel) XP to next level")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var relationshipSection: some View {
        HStack {
            metricBlock(title: "Bond", value: "\(sessionManager.progress.bond)/100")
            Spacer()
            metricBlock(title: "Momentum", value: "\(sessionManager.progress.momentum)/100")
        }
    }

    private var todaySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {
                metricBlock(title: "Sessions", value: "\(sessionManager.progress.today.completedSessions)")
                Spacer()
                metricBlock(title: "Minutes", value: "\(sessionManager.progress.today.focusedMinutes)")
                Spacer()
                metricBlock(title: "XP today", value: "\(sessionManager.progress.today.xpEarned)")
            }

            HStack {
                metricBlock(title: "Current streak", value: "\(sessionManager.progress.currentStreak) day(s)")
                Spacer()
                metricBlock(title: "Best streak", value: "\(sessionManager.progress.bestStreak) day(s)")
            }
        }
    }

    private var ruleSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Rule engine")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.ruleSummaryText)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var statsSection: some View {
        HStack {
            metricBlock(title: "Completed sessions", value: "\(sessionManager.completedSessions)")
            Spacer()
            metricBlock(title: "Mode", value: "Trust")
        }
    }

    private var recentSessionSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Last session")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.lastSessionSummary)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var dashboardButton: some View {
        Button("Open Dashboard") {
            openWindow(id: "dashboard")
        }
        .frame(maxWidth: .infinity)
    }

    private func metricBlock(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            dashboardHeader

            HStack(alignment: .top, spacing: 18) {
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
                        Text(sessionManager.petMood.face)
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

            HStack(alignment: .top, spacing: 18) {
                dashboardCard(title: "Streaks") {
                    VStack(alignment: .leading, spacing: 10) {
                        largeMetric(title: "Current streak", value: "\(sessionManager.progress.currentStreak) day(s)")
                        largeMetric(title: "Best streak", value: "\(sessionManager.progress.bestStreak) day(s)")
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

            Spacer()
        }
        .padding(28)
        .frame(minWidth: 760, minHeight: 560)
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
}

struct SelfRatingPanelView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Self-check")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("How focused was this session?")
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                ForEach(SelfRating.allCases, id: \.self) { rating in
                    Button(rating.shortTitle) {
                        sessionManager.submitSelfRating(rating)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
