import Foundation

struct SubjectBreakdownItem: Identifiable, Hashable {
    let subject: String
    let sessionCount: Int
    let focusedMinutes: Int

    var id: String { subject }
}

struct SubjectBreakdownSummary: Hashable {
    let items: [SubjectBreakdownItem]
    let totalSubjects: Int
    let topSubject: String
    let topSubjectMinutes: Int
}

enum SubjectTagEngine {
    static func summary(from sessions: [FocusSession]) -> SubjectBreakdownSummary {
        let items = breakdownItems(from: sessions)
        let topItem = items.first

        return SubjectBreakdownSummary(
            items: items,
            totalSubjects: items.count,
            topSubject: topItem?.subject ?? "None",
            topSubjectMinutes: topItem?.focusedMinutes ?? 0
        )
    }

    static func breakdownItems(from sessions: [FocusSession]) -> [SubjectBreakdownItem] {
        var sessionCounts: [String: Int] = [:]
        var focusedMinutesBySubject: [String: Int] = [:]

        for session in sessions {
            let subjects = subjects(from: session.intention)

            for subject in subjects {
                sessionCounts[subject, default: 0] += 1
                focusedMinutesBySubject[subject, default: 0] += max(0, session.actualMinutesRoundedDown)
            }
        }

        return sessionCounts
            .map { subject, count in
                SubjectBreakdownItem(
                    subject: subject,
                    sessionCount: count,
                    focusedMinutes: focusedMinutesBySubject[subject, default: 0]
                )
            }
            .sorted { first, second in
                if first.focusedMinutes != second.focusedMinutes {
                    return first.focusedMinutes > second.focusedMinutes
                }

                if first.sessionCount != second.sessionCount {
                    return first.sessionCount > second.sessionCount
                }

                return first.subject.localizedCaseInsensitiveCompare(second.subject) == .orderedAscending
            }
    }

    static func subjects(from intention: String) -> [String] {
        let trimmed = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return []
        }

        let bracketSubjects = bracketTags(from: trimmed)

        if !bracketSubjects.isEmpty {
            return bracketSubjects
        }

        return ["Other"]
    }

    static func bracketTags(from text: String) -> [String] {
        var tags: [String] = []
        var current = ""
        var isInsideBracket = false

        for character in text {
            if character == "[" {
                current = ""
                isInsideBracket = true
            } else if character == "]", isInsideBracket {
                let cleaned = current.trimmingCharacters(in: .whitespacesAndNewlines)

                if !cleaned.isEmpty {
                    tags.append(cleaned)
                }

                current = ""
                isInsideBracket = false
            } else if isInsideBracket {
                current.append(character)
            }
        }

        return Array(Set(tags)).sorted {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        }
    }
}
