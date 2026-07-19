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
    var rating: SelfRating?
    var xpEarned: Int
    var bondChange: Int
    var momentumChange: Int
    var ruleSummary: String
    let intention: String
    var reflectionNote: String

    var selfRating: SelfRating? {
        get {
            rating
        }

        set {
            rating = newValue
        }
    }

    var plannedMinutes: Int {
        max(1, plannedSeconds / 60)
    }

    var actualMinutesRoundedDown: Int {
        if actualSeconds > 0 {
            return actualSeconds / 60
        }

        guard let endTime else {
            return 0
        }

        let seconds = max(0, endTime.timeIntervalSince(startTime))
        return Int(seconds / 60)
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
        let cleanedIntention = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        if cleanedIntention.isEmpty {
            return "No study intention."
        }

        return "Intention: \(cleanedIntention)"
    }

    var ratingText: String {
        guard let rating else {
            return "Not rated"
        }

        return rating.title
    }

    init(
        id: UUID = UUID(),
        startTime: Date = Date(),
        endTime: Date? = nil,
        plannedSeconds: Int,
        actualSeconds: Int = 0,
        completed: Bool = false,
        abandoned: Bool = false,
        pauseCount: Int = 0,
        rating: SelfRating? = nil,
        selfRating: SelfRating? = nil,
        xpEarned: Int = 0,
        bondChange: Int = 0,
        momentumChange: Int = 0,
        ruleSummary: String = "",
        intention: String = "",
        reflectionNote: String = ""
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.plannedSeconds = plannedSeconds
        self.actualSeconds = actualSeconds
        self.completed = completed
        self.abandoned = abandoned
        self.pauseCount = pauseCount
        self.rating = rating ?? selfRating
        self.xpEarned = xpEarned
        self.bondChange = bondChange
        self.momentumChange = momentumChange
        self.ruleSummary = ruleSummary
        self.intention = intention
        self.reflectionNote = reflectionNote
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
        case rating
        case selfRating
        case xpEarned
        case bondChange
        case momentumChange
        case ruleSummary
        case intention
        case reflectionNote
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.startTime = try container.decodeIfPresent(Date.self, forKey: .startTime) ?? Date()
        self.endTime = try container.decodeIfPresent(Date.self, forKey: .endTime)
        self.plannedSeconds = try container.decodeIfPresent(Int.self, forKey: .plannedSeconds) ?? 1500
        self.actualSeconds = try container.decodeIfPresent(Int.self, forKey: .actualSeconds) ?? 0
        self.completed = try container.decodeIfPresent(Bool.self, forKey: .completed) ?? false
        self.abandoned = try container.decodeIfPresent(Bool.self, forKey: .abandoned) ?? false
        self.pauseCount = try container.decodeIfPresent(Int.self, forKey: .pauseCount) ?? 0
        self.rating = try container.decodeIfPresent(SelfRating.self, forKey: .rating)
            ?? container.decodeIfPresent(SelfRating.self, forKey: .selfRating)
        self.xpEarned = try container.decodeIfPresent(Int.self, forKey: .xpEarned) ?? 0
        self.bondChange = try container.decodeIfPresent(Int.self, forKey: .bondChange) ?? 0
        self.momentumChange = try container.decodeIfPresent(Int.self, forKey: .momentumChange) ?? 0
        self.ruleSummary = try container.decodeIfPresent(String.self, forKey: .ruleSummary) ?? ""
        self.intention = try container.decodeIfPresent(String.self, forKey: .intention) ?? ""
        self.reflectionNote = try container.decodeIfPresent(String.self, forKey: .reflectionNote) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(startTime, forKey: .startTime)
        try container.encodeIfPresent(endTime, forKey: .endTime)
        try container.encode(plannedSeconds, forKey: .plannedSeconds)
        try container.encode(actualSeconds, forKey: .actualSeconds)
        try container.encode(completed, forKey: .completed)
        try container.encode(abandoned, forKey: .abandoned)
        try container.encode(pauseCount, forKey: .pauseCount)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(rating, forKey: .selfRating)
        try container.encode(xpEarned, forKey: .xpEarned)
        try container.encode(bondChange, forKey: .bondChange)
        try container.encode(momentumChange, forKey: .momentumChange)
        try container.encode(ruleSummary, forKey: .ruleSummary)
        try container.encode(intention, forKey: .intention)
        try container.encode(reflectionNote, forKey: .reflectionNote)
    }
}
