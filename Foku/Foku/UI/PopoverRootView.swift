import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                headerSection

                Divider()

                OnboardingCardView()
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

                missionSection

                Divider()

                privacySection

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

            PixelPetView(mood: sessionManager.petMood, level: sessionManager.progress.level)
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

    private var missionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Daily missions")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.dailyMissionSummary)
                .font(.subheadline)
                .fontWeight(.semibold)

            ForEach(sessionManager.dailyMissions) { mission in
                missionRow(mission)
            }
        }
    }

    private var privacySection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Privacy")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.privacyModeTitle)
                .font(.subheadline)
                .fontWeight(.semibold)

            Text(sessionManager.privacyModeDescription)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
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
            metricBlock(title: "Mode", value: sessionManager.privacyModeTitle)
        }
    }

    @ViewBuilder
    private var recentSessionSection: some View {
        if let latestSession = sessionManager.recentSessions.first,
           latestSession.selfRating != nil {
            SessionSummaryCardView(session: latestSession)
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

    private func missionRow(_ mission: DailyMission) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(mission.completed ? "✓" : "○")
                .font(.caption)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 3) {
                Text(mission.title)
                    .font(.caption)
                    .fontWeight(.semibold)

                Text(mission.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(8)
        .background(.quaternary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
