import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(spacing: 16) {
            headerSection

            Divider()

            TimerPanelView()

            if sessionManager.latestSessionNeedsRating {
                Divider()
                SelfRatingPanelView()
            }

            Divider()

            statsSection

            Divider()

            recentSessionSection
        }
        .padding(18)
        .frame(width: 360)
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Foku")
                .font(.title2)
                .fontWeight(.semibold)

            Text("▣")
                .font(.system(size: 56))
                .padding(.top, 4)

            Text(sessionManager.stateTitle)
                .font(.headline)

            Text(sessionManager.lastMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
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
