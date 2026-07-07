import SwiftUI
import Combine

enum FocusSessionState {
    case idle
    case running
    case paused
    case completed
    case abandoned
}

final class FocusSessionManager: ObservableObject {
    @Published var state: FocusSessionState = .idle
    @Published var plannedSeconds: Int = 25 * 60
    @Published var remainingSeconds: Int = 25 * 60
    @Published var completedSessions: Int = 0
    @Published var lastMessage: String = "Ready when you are."

    private var timer: Timer?

    var menuBarIcon: String {
        switch state {
        case .idle:
            return "◉"
        case .running:
            return "●"
        case .paused:
            return "◌"
        case .completed:
            return "★"
        case .abandoned:
            return "!"
        }
    }

    var stateTitle: String {
        switch state {
        case .idle:
            return "Idle"
        case .running:
            return "Studying"
        case .paused:
            return "Paused"
        case .completed:
            return "Session Complete"
        case .abandoned:
            return "Session Abandoned"
        }
    }

    var formattedTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startSession() {
        stopTimer()
        remainingSeconds = plannedSeconds
        state = .running
        lastMessage = "Foku is studying with you."
        startTimer()
    }

    func pauseSession() {
        guard state == .running else { return }
        state = .paused
        lastMessage = "Paused. Foku will wait."
        stopTimer()
    }

    func resumeSession() {
        guard state == .paused else { return }
        state = .running
        lastMessage = "Back to focus."
        startTimer()
    }

    func completeSession() {
        guard state == .running || state == .paused else { return }
        stopTimer()
        state = .completed
        completedSessions += 1
        lastMessage = "Nice. Session completed."
    }

    func abandonSession() {
        guard state == .running || state == .paused else { return }
        stopTimer()
        state = .abandoned
        lastMessage = "Session abandoned. We can try again."
    }

    func resetToIdle() {
        stopTimer()
        state = .idle
        remainingSeconds = plannedSeconds
        lastMessage = "Ready when you are."
    }

    private func startTimer() {
        stopTimer()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }

            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.completeSession()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

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
