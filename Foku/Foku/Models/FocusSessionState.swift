import Foundation

enum FocusSessionState {
    case idle
    case running
    case paused
    case completed
    case abandoned
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

    init(
        id: UUID = UUID(),
        startTime: Date = Date(),
        endTime: Date? = nil,
        plannedSeconds: Int,
        actualSeconds: Int = 0,
        completed: Bool = false,
        abandoned: Bool = false,
        pauseCount: Int = 0,
        modeUsed: String = "Trust"
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
}
