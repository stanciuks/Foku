import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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

                bondMomentumSection

                Divider()

                ruleSection

                Divider()

                statsSection

                Divider()

                recentSessionSection
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
                VStack(alignment: .leading, spacing: 4) {
                    Text("Level")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("\(sessionManager.progress.level)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Total XP")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("\(sessionManager.progress.totalXP)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }

            ProgressView(value: sessionManager.progress.levelProgress)
                .progressViewStyle(.linear)

            Text("\(sessionManager.progress.xpInCurrentLevel)/\(sessionManager.progress.xpNeededForNextLevel) XP to next level")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var bondMomentumSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Bond")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(sessionManager.progress.bond)/100")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: sessionManager.progress.bondProgress)
                .progressViewStyle(.linear)

            HStack {
                Text("Momentum")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(sessionManager.progress.momentum)/100")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: sessionManager.progress.momentumProgress)
                .progressViewStyle(.linear)
        }
    }

    private var ruleSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Rule engine")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.lastRuleSummary)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var statsSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Completed sessions")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("\(sessionManager.completedSessions)")
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Mode")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Trust")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
    }

    private var recentSessionSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Last session")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(sessionManager.lastSessionSummary)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
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
