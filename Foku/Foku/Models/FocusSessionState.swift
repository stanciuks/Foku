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

struct DailyMission: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let description: String
    let completed: Bool

    var statusText: String {
        completed ? "Done" : "Open"
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
    var intention: String
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
        intention: String = "",
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
        self.intention = intention
        self.selfRating = selfRating
        self.xpEarned = xpEarned
        self.bondChange = bondChange
        self.momentumChange = momentumChange
        self.ruleSummary = ruleSummary
    }

    enum CodingKeys: String, CodingKey {
        case id
        case startTime
        case endTime
        case plannedSeconds
        case actualSeconds
        case completed
        case abandoned
        case pauseCount
        case modeUsed
        case intention
        case selfRating
        case xpEarned
        case bondChange
        case momentumChange
        case ruleSummary
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decodeIfPresent(Date.self, forKey: .endTime)
        plannedSeconds = try container.decode(Int.self, forKey: .plannedSeconds)
        actualSeconds = try container.decode(Int.self, forKey: .actualSeconds)
        completed = try container.decode(Bool.self, forKey: .completed)
        abandoned = try container.decode(Bool.self, forKey: .abandoned)
        pauseCount = try container.decode(Int.self, forKey: .pauseCount)
        modeUsed = try container.decode(String.self, forKey: .modeUsed)

        // Backward compatibility:
        // Older saved sessions did not have an intention field.
        intention = try container.decodeIfPresent(String.self, forKey: .intention) ?? ""

        selfRating = try container.decodeIfPresent(SelfRating.self, forKey: .selfRating)
        xpEarned = try container.decodeIfPresent(Int.self, forKey: .xpEarned) ?? 0
        bondChange = try container.decodeIfPresent(Int.self, forKey: .bondChange) ?? 0
        momentumChange = try container.decodeIfPresent(Int.self, forKey: .momentumChange) ?? 0
        ruleSummary = try container.decodeIfPresent(String.self, forKey: .ruleSummary)
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

    var intentionText: String {
        let trimmed = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            return "No intention set"
        }

        return trimmed
    }

    var ratingText: String {
        guard let selfRating else {
            return "Not rated yet"
        }

        return selfRating.title
    }
}
