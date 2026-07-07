import Foundation

enum SessionStatus: String, Codable {
    case planned
    case running
    case paused
    case completed
    case abandoned
}

struct FocusSession: Identifiable, Codable {
    let id: UUID
    let goalName: String
    let plannedDurationSeconds: Int
    let startTime: Date
    var endTime: Date?
    var actualDurationSeconds: Int
    var pauseCount: Int
    var status: SessionStatus

    init(goalName: String, plannedDurationSeconds: Int) {
        self.id = UUID()
        self.goalName = goalName
        self.plannedDurationSeconds = plannedDurationSeconds
        self.startTime = Date()
        self.endTime = nil
        self.actualDurationSeconds = 0
        self.pauseCount = 0
        self.status = .planned
    }
}
