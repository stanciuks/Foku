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
    @Published var lastRuleResult: SessionRuleResult?

    private var timer: Timer?
    private let saveKey = "foku.local.state.v1"

    init() {
        loadState()
        refreshTodayIfNeeded()
    }

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

    var petMood: PetMood {
        DeterministicRuleEngine.mood(for: progress)
    }

    var lastSessionSummary: String {
        guard let lastSession = recentSessions.first else {
            return "No finished sessions yet."
        }

        return "\(lastSession.statusText) • \(lastSession.actualMinutesRoundedDown)/\(lastSession.plannedMinutes) min • \(lastSession.pauseCount) pause(s) • \(lastSession.ratingText) • +\(lastSession.xpEarned) XP • \(signed(lastSession.bondChange)) Bond • \(signed(lastSession.momentumChange)) Momentum"
    }

    var latestSessionNeedsRating: Bool {
        guard let latestSession = recentSessions.first else {
            return false
        }

        return latestSession.selfRating == nil && (latestSession.completed || latestSession.abandoned)
    }

    var privacyModeTitle: String {
        "Trust Mode"
    }

    var privacyModeDescription: String {
        "Only session timing, ratings, XP, Bond, Momentum, streaks, and recent sessions are saved locally."
    }

    var focusGuardStatus: String {
        "Focus Guard is not enabled in this prototype."
    }

    var ruleSummaryText: String {
        if let ruleSummary = lastRuleResult?.ruleSummary {
            return ruleSummary
        }

        if let latestRuleSummary = recentSessions.first?.ruleSummary {
            return latestRuleSummary
        }

        return "No rule result yet."
    }

    func setPlannedDuration(_ seconds: Int) {
        guard state == .idle || state == .completed || state == .abandoned else { return }

        plannedSeconds = seconds
        remainingSeconds = seconds
        lastMessage = "Focus length set to \(seconds / 60) minutes."
    }

    func startSession() {
        stopTimer()
        refreshTodayIfNeeded()

        remainingSeconds = plannedSeconds
        currentSession = FocusSession(plannedSeconds: plannedSeconds)
        state = .running
        lastXPEarned = 0
        lastRuleResult = nil
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

        refreshTodayIfNeeded()

        let result = DeterministicRuleEngine.evaluate(session: recentSessions[0], rating: rating)

        recentSessions[0].selfRating = rating
        recentSessions[0].xpEarned = result.xpEarned
        recentSessions[0].bondChange = result.bondChange
        recentSessions[0].momentumChange = result.momentumChange
        recentSessions[0].ruleSummary = result.ruleSummary

        lastRuleResult = result
        lastXPEarned = result.xpEarned
        lastMessage = result.message

        applyRuleResult(result, session: recentSessions[0])
        saveState()
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

    private func applyRuleResult(_ result: SessionRuleResult, session: FocusSession) {
        progress.totalXP += result.xpEarned

        let xpPerLevel = 100
        progress.level = (progress.totalXP / xpPerLevel) + 1
        progress.xpInCurrentLevel = progress.totalXP % xpPerLevel
        progress.xpNeededForNextLevel = xpPerLevel

        progress.bond = clamp(progress.bond + result.bondChange, min: 0, max: 100)
        progress.momentum = clamp(progress.momentum + result.momentumChange, min: 0, max: 100)

        if session.completed {
            updateDailyStats(session: session, xpEarned: result.xpEarned)
            updateStreakAfterCompletedSession()
        }
    }

    private func updateDailyStats(session: FocusSession, xpEarned: Int) {
        refreshTodayIfNeeded()

        progress.today.completedSessions += 1
        progress.today.focusedMinutes += max(0, session.actualMinutesRoundedDown)
        progress.today.xpEarned += xpEarned
    }

    private func updateStreakAfterCompletedSession() {
        let todayKey = DailyStudyStats.currentDayKey()

        if progress.lastActiveDayKey == todayKey {
            progress.bestStreak = max(progress.bestStreak, progress.currentStreak)
            return
        }

        if let lastActiveDayKey = progress.lastActiveDayKey,
           isYesterday(lastActiveDayKey, comparedTo: todayKey) {
            progress.currentStreak += 1
        } else {
            progress.currentStreak = 1
        }

        progress.lastActiveDayKey = todayKey
        progress.bestStreak = max(progress.bestStreak, progress.currentStreak)
    }

    private func refreshTodayIfNeeded() {
        let todayKey = DailyStudyStats.currentDayKey()

        if progress.today.dayKey != todayKey {
            progress.today = DailyStudyStats(dayKey: todayKey)
        }
    }

    private func isYesterday(_ previousDayKey: String, comparedTo currentDayKey: String) -> Bool {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"

        guard
            let previousDate = formatter.date(from: previousDayKey),
            let currentDate = formatter.date(from: currentDayKey),
            let expectedPreviousDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        else {
            return false
        }

        return Calendar.current.isDate(previousDate, inSameDayAs: expectedPreviousDate)
    }

    private func saveState() {
        let state = FokuSavedState(
            completedSessions: completedSessions,
            recentSessions: Array(recentSessions.prefix(10)),
            progress: progress,
            lastRuleResult: lastRuleResult
        )

        do {
            let data = try JSONEncoder().encode(state)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save Foku state: \(error)")
        }
    }

    private func loadState() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }

        do {
            let savedState = try JSONDecoder().decode(FokuSavedState.self, from: data)
            completedSessions = savedState.completedSessions
            recentSessions = savedState.recentSessions
            progress = savedState.progress
            lastRuleResult = savedState.lastRuleResult
        } catch {
            print("Failed to load Foku state: \(error)")
        }
    }

    private func clamp(_ value: Int, min: Int, max: Int) -> Int {
        Swift.max(min, Swift.min(max, value))
    }

    private func signed(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)"
        }

        return "\(value)"
    }
}

private struct FokuSavedState: Codable {
    var completedSessions: Int
    var recentSessions: [FocusSession]
    var progress: UserProgress
    var lastRuleResult: SessionRuleResult?
}
