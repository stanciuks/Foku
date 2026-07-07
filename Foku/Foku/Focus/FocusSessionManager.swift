import Foundation
import Combine

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
