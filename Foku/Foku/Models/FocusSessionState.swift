import Foundation

enum FocusSessionState {
    case idle
    case running
    case paused
    case completed
    case abandoned
}

enum SelfRating: String, CaseIterable, Codable, Equatable {
    case focused
    case partlyDistracted
    case didNotReallyStudy

    var title: String {
        switch self {
        case .focused:
            return "Focused"
        case .partlyDistracted:
            return "Partly distracted"
        case .didNotReallyStudy:
            return "Did not really study"
        }
    }

    var shortTitle: String {
        switch self {
        case .focused:
            return "Focused"
        case .partlyDistracted:
            return "Partly"
        case .didNotReallyStudy:
            return "Not really"
        }
    }

    var focusQualityMultiplier: Double {
        switch self {
        case .focused:
            return 1.0
        case .partlyDistracted:
            return 0.7
        case .didNotReallyStudy:
            return 0.1
        }
    }
}

struct UserProgress: Codable, Equatable {
    var totalXP: Int
    var level: Int
    var xpInCurrentLevel: Int
    var xpNeededForNextLevel: Int
    var bond: Int
    var momentum: Int
    var currentStreak: Int
    var bestStreak: Int
    var lastActiveDayKey: String?
    var today: DailyStudyStats

    init(
        totalXP: Int = 0,
        level: Int = 1,
        xpInCurrentLevel: Int = 0,
        xpNeededForNextLevel: Int = 100,
        bond: Int = 50,
        momentum: Int = 0,
        currentStreak: Int = 0,
        bestStreak: Int = 0,
        lastActiveDayKey: String? = nil,
        today: DailyStudyStats = DailyStudyStats()
    ) {
        self.totalXP = totalXP
        self.level = level
        self.xpInCurrentLevel = xpInCurrentLevel
        self.xpNeededForNextLevel = xpNeededForNextLevel
        self.bond = bond
        self.momentum = momentum
        self.currentStreak = currentStreak
        self.bestStreak = bestStreak
        self.lastActiveDayKey = lastActiveDayKey
        self.today = today
    }

    var levelProgress: Double {
        guard xpNeededForNextLevel > 0 else { return 0 }
        return Double(xpInCurrentLevel) / Double(xpNeededForNextLevel)
    }
}

struct DailyStudyStats: Codable, Equatable {
    var dayKey: String
    var completedSessions: Int
    var focusedMinutes: Int
    var xpEarned: Int

    init(
        dayKey: String = DailyStudyStats.currentDayKey(),
        completedSessions: Int = 0,
        focusedMinutes: Int = 0,
        xpEarned: Int = 0
    ) {
        self.dayKey = dayKey
        self.completedSessions = completedSessions
        self.focusedMinutes = focusedMinutes
        self.xpEarned = xpEarned
    }

    static func currentDayKey(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

enum PetMood: String, Codable, Equatable {
    case neutral
    case encouraged
    case proud
    case tired

    var face: String {
        switch self {
        case .neutral:
            return "▣"
        case .encouraged:
            return "◈"
        case .proud:
            return "◆"
        case .tired:
            return "◇"
        }
    }

    var title: String {
        switch self {
        case .neutral:
            return "Neutral"
        case .encouraged:
            return "Encouraged"
        case .proud:
            return "Proud"
        case .tired:
            return "Tired"
        }
    }

    var description: String {
        switch self {
        case .neutral:
            return "Foku is ready to build a rhythm."
        case .encouraged:
            return "Foku notices your effort."
        case .proud:
            return "Foku is proud of your consistency."
        case .tired:
            return "Foku thinks a gentle restart may help."
        }
    }
}

struct SessionRuleResult: Codable, Equatable {
    var xpEarned: Int
    var bondChange: Int
    var momentumChange: Int
    var message: String
    var ruleSummary: String
}

enum DeterministicRuleEngine {
    static func evaluate(session: FocusSession, rating: SelfRating) -> SessionRuleResult {
        let plannedMinutes = max(1, session.plannedMinutes)
        let baseXP = Int(Double(plannedMinutes) * 1.2)

        let completionMultiplier = session.completed ? 1.0 : 0.25
        let ratingMultiplier = rating.focusQualityMultiplier
        let calculatedXP = Double(baseXP) * completionMultiplier * ratingMultiplier
        let xp = max(1, Int(calculatedXP.rounded()))

        let bondChange: Int
        let momentumChange: Int
        let message: String

        if session.completed {
            switch rating {
            case .focused:
                bondChange = 3
                momentumChange = 8
                message = "Strong focused effort. Foku is proud. +\(xp) XP"
            case .partlyDistracted:
                bondChange = 2
                momentumChange = 4
                message = "Honest check-in saved. Progress still counts. +\(xp) XP"
            case .didNotReallyStudy:
                bondChange = 1
                momentumChange = -2
                message = "Thanks for being honest. Let's restart gently. +\(xp) XP"
            }
        } else {
            switch rating {
            case .focused:
                bondChange = 1
                momentumChange = -1
                message = "Even though it was abandoned, some focus happened. +\(xp) XP"
            case .partlyDistracted:
                bondChange = 1
                momentumChange = -3
                message = "Not the best session, but the check-in helps. +\(xp) XP"
            case .didNotReallyStudy:
                bondChange = 0
                momentumChange = -5
                message = "That session did not really work. Try a smaller restart. +\(xp) XP"
            }
        }

        let status = session.completed ? "Completed" : "Abandoned"

        return SessionRuleResult(
            xpEarned: xp,
            bondChange: bondChange,
            momentumChange: momentumChange,
            message: message,
            ruleSummary: "\(status) × \(rating.title) → +\(xp) XP, \(signed(bondChange)) Bond, \(signed(momentumChange)) Momentum"
        )
    }

    static func mood(for progress: UserProgress) -> PetMood {
        if progress.momentum < 15 {
            return .neutral
        }

        if progress.bond >= 70 && progress.momentum >= 50 {
            return .proud
        }

        if progress.momentum >= 25 || progress.bond >= 60 {
            return .encouraged
        }

        return .neutral
    }

    private static func signed(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)"
        }

        return "\(value)"
    }
}

struct FocusSession: Identifiable, Codable, Equatable {
    let id: UUID
    let startTime: Date
    var endTime: Date?
    let plannedSeconds: Int
    var actualSeconds: Int
    var completed: Bool
    var abandoned: Bool
    var pauseCount: Int
    let modeUsed: String
    var selfRating: SelfRating?
    var xpEarned: Int
    var bondChange: Int
    var momentumChange: Int
    var ruleSummary: String?

    init(
        id: UUID = UUID(),
        startTime: Date = Date(),
        endTime: Date? = nil,
        plannedSeconds: Int,
        actualSeconds: Int = 0,
        completed: Bool = false,
        abandoned: Bool = false,
        pauseCount: Int = 0,
        modeUsed: String = "Trust",
        selfRating: SelfRating? = nil,
        xpEarned: Int = 0,
        bondChange: Int = 0,
        momentumChange: Int = 0,
        ruleSummary: String? = nil
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.plannedSeconds = plannedSeconds
        self.actualSeconds = actualSeconds
        self.completed = completed
        self.abandoned = abandoned
        self.pauseCount = pauseCount
        self.modeUsed = modeUsed
        self.selfRating = selfRating
        self.xpEarned = xpEarned
        self.bondChange = bondChange
        self.momentumChange = momentumChange
        self.ruleSummary = ruleSummary
    }

    var actualMinutesRoundedDown: Int {
        actualSeconds / 60
    }

    var plannedMinutes: Int {
        plannedSeconds / 60
    }

    var statusText: String {
        if completed {
            return "Completed"
        }

        if abandoned {
            return "Abandoned"
        }

        return "In progress"
    }

    var ratingText: String {
        guard let selfRating else {
            return "Not rated yet"
        }

        return selfRating.title
    }
}
