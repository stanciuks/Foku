import Foundation

@MainActor
final class FocusSessionManager: ObservableObject {
    @Published var selectedMinutes: Int = 25
    @Published private(set) var remainingSeconds: Int = 25 * 60
    @Published private(set) var elapsedSeconds: Int = 0
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var isPaused: Bool = false
    @Published private(set) var currentSession: FocusSession?
    @Published private(set) var lastFinishedSession: FocusSession?

    private var timer: Timer?

    var formattedRemainingTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func prepareDuration(minutes: Int) {
        guard !isRunning else { return }
        selectedMinutes = minutes
        remainingSeconds = minutes * 60
        elapsedSeconds = 0
    }

    func start(goalName: String = "Focus Session") {
        stopTimer()

        let duration = selectedMinutes * 60
        currentSession = FocusSession(goalName: goalName, plannedDurationSeconds: duration)
        currentSession?.status = .running

        remainingSeconds = duration
        elapsedSeconds = 0
        isRunning = true
        isPaused = false

        startTimer()
    }

    func pause() {
        guard isRunning, !isPaused else { return }
        isPaused = true
        currentSession?.status = .paused
        currentSession?.pauseCount += 1
        stopTimer()
    }

    func resume() {
        guard isRunning, isPaused else { return }
        isPaused = false
        currentSession?.status = .running
        startTimer()
    }

    func complete() {
        guard var session = currentSession else { return }
        stopTimer()

        session.status = .completed
        session.endTime = Date()
        session.actualDurationSeconds = elapsedSeconds

        lastFinishedSession = session
        currentSession = nil
        isRunning = false
        isPaused = false
    }

    func abandon() {
        guard var session = currentSession else { return }
        stopTimer()

        session.status = .abandoned
        session.endTime = Date()
        session.actualDurationSeconds = elapsedSeconds

        lastFinishedSession = session
        currentSession = nil
        isRunning = false
        isPaused = false
        remainingSeconds = selectedMinutes * 60
        elapsedSeconds = 0
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }
    }

    private func tick() {
        guard isRunning, !isPaused else { return }

        if remainingSeconds > 0 {
            remainingSeconds -= 1
            elapsedSeconds += 1
        } else {
            complete()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
