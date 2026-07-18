import SwiftUI

struct CustomDurationView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @State private var customMinutes: Int = 30

    private var durationIsLocked: Bool {
        switch sessionManager.state {
        case .idle:
            return false
        default:
            return true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Custom length")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack(spacing: 10) {
                Stepper(value: $customMinutes, in: 5...120, step: 5) {
                    Text("\(customMinutes)m")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(minWidth: 54, alignment: .leading)
                }
                .disabled(durationIsLocked)

                Button("Use custom") {
                    applyDuration(customMinutes)
                }
                .disabled(durationIsLocked)
            }

            Text(durationIsLocked ? "Locked during an active session." : "Use this when presets do not fit.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .onAppear {
            customMinutes = max(5, sessionManager.plannedSeconds / 60)
        }
    }

    private func applyDuration(_ minutes: Int) {
        let clamped = min(max(minutes, 5), 120)
        customMinutes = clamped
        sessionManager.setPlannedDuration(clamped * 60)
    }
}
