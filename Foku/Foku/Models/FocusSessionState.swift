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

    init(
        totalXP: Int = 0,
        level: Int = 1,
        xpInCurrentLevel: Int = 0,
        xpNeededForNextLevel: Int = 100
    ) {
        self.totalXP = totalXP
        self.level = level
        self.xpInCurrentLevel = xpInCurrentLevel
        self.xpNeededForNextLevel = xpNeededForNextLevel
    }

    var levelProgress: Double {
        guard xpNeededForNextLevel > 0 else { return 0 }
        return Double(xpInCurrentLevel) / Double(xpNeededForNextLevel)
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
        xpEarned: Int = 0
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
