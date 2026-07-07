import Foundation
import Combine

final class FocusSessionManager: ObservableObject {
    @Published var state: FocusSessionState = .idle
    @Published var plannedSeconds: Int = 25 * 60
    @Published var remainingSeconds: Int = 25 * 60
    @Published var completedSessions: Int = 0
    @Published var lastMessage: String = "Ready when you are."
    @Published var currentSession: FocusSession?
    @Published var recentSessions: [FocusSession] = []
    @Published var progress: UserProgress = UserProgress()
    @Published var lastXPEarned: Int = 0

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

    var elapsedSeconds: Int {
        plannedSeconds - remainingSeconds
    }

    var lastSessionSummary: String {
        guard let lastSession = recentSessions.first else {
            return "No finished sessions yet."
        }

        return "\(lastSession.statusText) • \(lastSession.actualMinutesRoundedDown)/\(lastSession.plannedMinutes) min • \(lastSession.pauseCount) pause(s) • \(lastSession.ratingText) • +\(lastSession.xpEarned) XP"
    }

    var latestSessionNeedsRating: Bool {
        guard let latestSession = recentSessions.first else {
            return false
        }

        return latestSession.selfRating == nil && (latestSession.completed || latestSession.abandoned)
    }

    func startSession() {
        stopTimer()

        remainingSeconds = plannedSeconds
        currentSession = FocusSession(plannedSeconds: plannedSeconds)
        state = .running
        lastXPEarned = 0
        lastMessage = "Foku is studying with you."

        startTimer()
    }

    func pauseSession() {
        guard state == .running else { return }

        state = .paused
        lastMessage = "Paused. Foku will wait."
        stopTimer()

        updateCurrentSession { session in
            session.pauseCount += 1
        }
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
        lastMessage = "Nice. How focused was that session?"

        finishCurrentSession(completed: true, abandoned: false)
    }

    func abandonSession() {
        guard state == .running || state == .paused else { return }

        stopTimer()
        state = .abandoned
        lastMessage = "That one did not work out. What happened?"

        finishCurrentSession(completed: false, abandoned: true)
    }

    func submitSelfRating(_ rating: SelfRating) {
        guard !recentSessions.isEmpty else { return }
        guard recentSessions[0].selfRating == nil else { return }

        let xp = calculateXP(for: recentSessions[0], rating: rating)

        recentSessions[0].selfRating = rating
        recentSessions[0].xpEarned = xp

        addXP(xp)
        lastXPEarned = xp

        switch rating {
        case .focused:
            lastMessage = "Good. Foku counted that as focused effort. +\(xp) XP"
        case .partlyDistracted:
            lastMessage = "Honest check-in saved. +\(xp) XP"
        case .didNotReallyStudy:
            lastMessage = "Thanks for being honest. +\(xp) XP"
        }
    }

    func resetToIdle() {
        stopTimer()

        state = .idle
        remainingSeconds = plannedSeconds
        currentSession = nil
        lastXPEarned = 0
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

    private func updateCurrentSession(_ update: (inout FocusSession) -> Void) {
        guard var session = currentSession else { return }
        update(&session)
        currentSession = session
    }

    private func finishCurrentSession(completed: Bool, abandoned: Bool) {
        guard var session = currentSession else { return }

        session.endTime = Date()
        session.actualSeconds = elapsedSeconds
        session.completed = completed
        session.abandoned = abandoned

        recentSessions.insert(session, at: 0)
        currentSession = nil
    }

    private func calculateXP(for session: FocusSession, rating: SelfRating) -> Int {
        let plannedMinutes = max(1, session.plannedMinutes)
        let baseXP = Int(Double(plannedMinutes) * 1.2)

        let completionMultiplier = session.completed ? 1.0 : 0.25
        let ratingMultiplier = rating.focusQualityMultiplier

        let calculatedXP = Double(baseXP) * completionMultiplier * ratingMultiplier

        return max(1, Int(calculatedXP.rounded()))
    }

    private func addXP(_ amount: Int) {
        progress.totalXP += amount

        let xpPerLevel = 100
        progress.level = (progress.totalXP / xpPerLevel) + 1
        progress.xpInCurrentLevel = progress.totalXP % xpPerLevel
        progress.xpNeededForNextLevel = xpPerLevel
    }
}
