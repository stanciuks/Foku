import Foundation

struct SessionInsight: Identifiable, Hashable {
    let id: String
    let title: String
    let value: String
    let detail: String
}

enum SessionInsightEngine {
    static func insights(for session: FocusSession) -> [SessionInsight] {
        [
            focusOutcomeInsight(for: session),
            subjectInsight(for: session),
            reflectionInsight(for: session),
            nextStepInsight(for: session)
        ]
    }

    private static func focusOutcomeInsight(for session: FocusSession) -> SessionInsight {
        if session.completed {
            return SessionInsight(
                id: "focus-outcome",
                title: "Best part",
                value: "Session completed",
                detail: "You finished a real focus block and submitted a self-check."
            )
        }

        return SessionInsight(
            id: "focus-outcome",
            title: "Best part",
            value: "Session recorded",
            detail: "Even incomplete sessions can help you notice patterns."
        )
    }

    private static func subjectInsight(for session: FocusSession) -> SessionInsight {
        let subjects = bracketTags(from: cleanIntention(session.intentionText))
        let value: String

        if subjects.isEmpty {
            value = "No subject tag"
        } else {
            value = subjects.joined(separator: ", ")
        }

        return SessionInsight(
            id: "subject",
            title: "Subject",
            value: value,
            detail: subjects.isEmpty
                ? "Add a subject tag next time to improve your subject analytics."
                : "This session will count toward your subject breakdown."
        )
    }

    private static func reflectionInsight(for session: FocusSession) -> SessionInsight {
        let note = session.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines)

        if note.isEmpty {
            return SessionInsight(
                id: "reflection",
                title: "Reflection",
                value: "Not saved",
                detail: "A short note next time will make your session history more useful."
            )
        }

        return SessionInsight(
            id: "reflection",
            title: "Reflection",
            value: "Saved",
            detail: "Your note was saved locally with this session."
        )
    }

    private static func nextStepInsight(for session: FocusSession) -> SessionInsight {
        if session.actualMinutesRoundedDown < 5 {
            return SessionInsight(
                id: "next-step",
                title: "Next improvement",
                value: "Try a longer block",
                detail: "Aim for at least five focused minutes next time."
            )
        }

        if session.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return SessionInsight(
                id: "next-step",
                title: "Next improvement",
                value: "Add reflection",
                detail: "Write one sentence about what helped or distracted you."
            )
        }

        if bracketTags(from: cleanIntention(session.intentionText)).isEmpty {
            return SessionInsight(
                id: "next-step",
                title: "Next improvement",
                value: "Tag the subject",
                detail: "Use a subject tag so Foku can show better analytics."
            )
        }

        return SessionInsight(
            id: "next-step",
            title: "Next improvement",
            value: "Repeat the pattern",
            detail: "Use the same intention → focus → reflection loop again."
        )
    }

    private static func cleanIntention(_ text: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasPrefix("Intention: ") {
            return String(trimmed.dropFirst("Intention: ".count))
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return trimmed
    }

    private static func bracketTags(from text: String) -> [String] {
        var tags: [String] = []
        var current = ""
        var isInsideBracket = false

        for character in text {
            if character == "[" {
                current = ""
                isInsideBracket = true
            } else if character == "]" {
                let tag = current.trimmingCharacters(in: .whitespacesAndNewlines)
                if !tag.isEmpty {
                    tags.append(tag)
                }
                current = ""
                isInsideBracket = false
            } else if isInsideBracket {
                current.append(character)
            }
        }

        return Array(Set(tags)).sorted()
    }
}
