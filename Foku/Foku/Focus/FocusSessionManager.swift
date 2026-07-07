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
    @Published var lastBondChange: Int = 0
    @Published var lastMomentumChange: Int = 0

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

        let bondText = signedText(lastSession.bondChange)
        let momentumText = signedText(lastSession.momentumChange)

        return "\(lastSession.statusText) • \(lastSession.actualMinutesRoundedDown)/\(lastSession.plannedMinutes) min • \(lastSession.ratingText) • +\(lastSession.xpEarned) XP • Bond \(bondText) • Momentum \(momentumText)"
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
        lastBondChange = 0
        lastMomentumChange = 0
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

        let session = recentSessions[0]
        let xp = calculateXP(for: session, rating: rating)
        let bondChange = calculateBondChange(for: session, rating: rating)
        let momentumChange = calculateMomentumChange(for: session, rating: rating)

        recentSessions[0].selfRating = rating
        recentSessions[0].xpEarned = xp
        recentSessions[0].bondChange = bondChange
        recentSessions[0].momentumChange = momentumChange

        addXP(xp)
        changeBond(by: bondChange)
        changeMomentum(by: momentumChange)

        lastXPEarned = xp
        lastBondChange = bondChange
        lastMomentumChange = momentumChange

        switch rating {
        case .focused:
            lastMessage = "Focused effort counted. +\(xp) XP, Bond \(signedText(bondChange)), Momentum \(signedText(momentumChange))"
        case .partlyDistracted:
            lastMessage = "Honest check-in saved. +\(xp) XP, Bond \(signedText(bondChange)), Momentum \(signedText(momentumChange))"
        case .didNotReallyStudy:
            lastMessage = "Thanks for being honest. +\(xp) XP, Bond \(signedText(bondChange)), Momentum \(signedText(momentumChange))"
        }
    }

    func resetToIdle() {
        stopTimer()

        state = .idle
        remainingSeconds = plannedSeconds
        currentSession = nil
        lastXPEarned = 0
        lastBondChange = 0
        lastMomentumChange = 0
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

    private func calculateBondChange(for session: FocusSession, rating: SelfRating) -> Int {
        switch (session.completed, rating) {
        case (true, .focused):
            return 3
        case (true, .partlyDistracted):
            return 2
        case (true, .didNotReallyStudy):
            return 1
        case (false, .focused):
            return 1
        case (false, .partlyDistracted):
            return 1
        case (false, .didNotReallyStudy):
            return 1
        }
    }

    private func calculateMomentumChange(for session: FocusSession, rating: SelfRating) -> Int {
        switch (session.completed, rating) {
        case (true, .focused):
            return 4
        case (true, .partlyDistracted):
            return 1
        case (true, .didNotReallyStudy):
            return -2
        case (false, .focused):
            return -1
        case (false, .partlyDistracted):
            return -2
        case (false, .didNotReallyStudy):
            return -3
        }
    }

    private func addXP(_ amount: Int) {
        progress.totalXP += amount

        let xpPerLevel = 100
        progress.level = (progress.totalXP / xpPerLevel) + 1
        progress.xpInCurrentLevel = progress.totalXP % xpPerLevel
        progress.xpNeededForNextLevel = xpPerLevel
    }

    private func changeBond(by amount: Int) {
        progress.bond = clampedProgressValue(progress.bond + amount)
    }

    private func changeMomentum(by amount: Int) {
        progress.momentum = clampedProgressValue(progress.momentum + amount)
    }

    private func clampedProgressValue(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    private func signedText(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)"
        }

        return "\(value)"
    }
}
