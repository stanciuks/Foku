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

enum PetMood: String, Codable, Equatable {
    case calm
    case focused
    case encouraged
    case patient
    case tired
    case cautious

    var title: String {
        switch self {
        case .calm:
            return "Calm"
        case .focused:
            return "Focused"
        case .encouraged:
            return "Encouraged"
        case .patient:
            return "Patient"
        case .tired:
            return "Tired"
        case .cautious:
            return "Cautious"
        }
    }

    var face: String {
        switch self {
        case .calm:
            return "▣"
        case .focused:
            return "◈"
        case .encouraged:
            return "◆"
        case .patient:
            return "◇"
        case .tired:
            return "◌"
        case .cautious:
            return "□"
        }
    }

    var description: String {
        switch self {
        case .calm:
            return "Foku is steady and ready."
        case .focused:
            return "Foku feels locked in with you."
        case .encouraged:
            return "Foku sees your effort building."
        case .patient:
            return "Foku is waiting without pressure."
        case .tired:
            return "Foku thinks the rhythm needs rebuilding."
        case .cautious:
            return "Foku is still learning your habits."
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

    init(
        totalXP: Int = 0,
        level: Int = 1,
        xpInCurrentLevel: Int = 0,
        xpNeededForNextLevel: Int = 100,
        bond: Int = 50,
        momentum: Int = 0
    ) {
        self.totalXP = totalXP
        self.level = level
        self.xpInCurrentLevel = xpInCurrentLevel
        self.xpNeededForNextLevel = xpNeededForNextLevel
        self.bond = bond
        self.momentum = momentum
    }

    var levelProgress: Double {
        guard xpNeededForNextLevel > 0 else { return 0 }
        return Double(xpInCurrentLevel) / Double(xpNeededForNextLevel)
    }

    var bondProgress: Double {
        Double(bond) / 100.0
    }

    var momentumProgress: Double {
        Double(momentum) / 100.0
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
        momentumChange: Int = 0
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

struct FokuSaveData: Codable, Equatable {
    var progress: UserProgress
    var recentSessions: [FocusSession]
    var completedSessions: Int

    init(
        progress: UserProgress = UserProgress(),
        recentSessions: [FocusSession] = [],
        completedSessions: Int = 0
    ) {
        self.progress = progress
        self.recentSessions = recentSessions
        self.completedSessions = completedSessions
    }
}

struct SessionRuleResult: Equatable {
    let xpEarned: Int
    let bondChange: Int
    let momentumChange: Int
    let message: String
    let ruleSummary: String
}

struct DeterministicRuleEngine {
    static func evaluate(session: FocusSession, rating: SelfRating) -> SessionRuleResult {
        let xp = calculateXP(for: session, rating: rating)
        let bondChange = calculateBondChange(for: session, rating: rating)
        let momentumChange = calculateMomentumChange(for: session, rating: rating)

        let message: String
        switch rating {
        case .focused:
            message = "Focused effort saved. +\(xp) XP"
        case .partlyDistracted:
            message = "Honest check-in saved. +\(xp) XP"
        case .didNotReallyStudy:
            message = "Thanks for being honest. +\(xp) XP"
        }

        let status = session.completed ? "completed" : "abandoned"
        let ruleSummary = "Rule: \(status) session × \(rating.title) → +\(xp) XP, Bond \(signed(bondChange)), Momentum \(signed(momentumChange))"

        return SessionRuleResult(
            xpEarned: xp,
            bondChange: bondChange,
            momentumChange: momentumChange,
            message: message,
            ruleSummary: ruleSummary
        )
    }

    static func petMood(for progress: UserProgress) -> PetMood {
        if progress.bond < 35 {
            return .cautious
        }

        if progress.momentum >= 70 && progress.bond >= 70 {
            return .focused
        }

        if progress.momentum >= 40 && progress.bond >= 55 {
            return .encouraged
        }

        if progress.momentum < 20 && progress.bond >= 60 {
            return .patient
        }

        if progress.momentum < 20 {
            return .tired
        }

        return .calm
    }

    private static func calculateXP(for session: FocusSession, rating: SelfRating) -> Int {
        let plannedMinutes = max(1, session.plannedMinutes)
        let baseXP = Int(Double(plannedMinutes) * 1.2)

        let completionMultiplier = session.completed ? 1.0 : 0.25
        let ratingMultiplier = rating.focusQualityMultiplier

        let calculatedXP = Double(baseXP) * completionMultiplier * ratingMultiplier

        return max(1, Int(calculatedXP.rounded()))
    }

    private static func calculateBondChange(for session: FocusSession, rating: SelfRating) -> Int {
        if session.abandoned {
            switch rating {
            case .focused:
                return 1
            case .partlyDistracted:
                return 1
            case .didNotReallyStudy:
                return 0
            }
        }

        switch rating {
        case .focused:
            return 3
        case .partlyDistracted:
            return 2
        case .didNotReallyStudy:
            return 1
        }
    }

    private static func calculateMomentumChange(for session: FocusSession, rating: SelfRating) -> Int {
        if session.abandoned {
            return -4
        }

        switch rating {
        case .focused:
            return 5
        case .partlyDistracted:
            return 2
        case .didNotReallyStudy:
            return -2
        }
    }

    private static func signed(_ value: Int) -> String {
        value >= 0 ? "+\(value)" : "\(value)"
    }
}
