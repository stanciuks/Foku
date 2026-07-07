import SwiftUI

struct TimerPanelView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(spacing: 14) {
            Text(sessionManager.formattedTime)
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .monospacedDigit()

            controls
        }
    }

    @ViewBuilder
    private var controls: some View {
        switch sessionManager.state {
        case .idle, .completed, .abandoned:
            Button("Start Focus") {
                sessionManager.startSession()
            }
            .keyboardShortcut(.defaultAction)

        case .running:
            HStack {
                Button("Pause") {
                    sessionManager.pauseSession()
                }

                Button("Complete") {
                    sessionManager.completeSession()
                }

                Button("Abandon") {
                    sessionManager.abandonSession()
                }
            }

        case .paused:
            HStack {
                Button("Resume") {
                    sessionManager.resumeSession()
                }

                Button("Complete") {
                    sessionManager.completeSession()
                }

                Button("Abandon") {
                    sessionManager.abandonSession()
                }
            }
        }

        if sessionManager.state == .completed || sessionManager.state == .abandoned {
            Button("Reset") {
                sessionManager.resetToIdle()
            }
        }
    }
}
