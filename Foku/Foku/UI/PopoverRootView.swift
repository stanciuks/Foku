import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(spacing: 16) {
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

            Divider()

            TimerPanelView()

            Divider()

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
        .padding(18)
        .frame(width: 320)
    }
}
