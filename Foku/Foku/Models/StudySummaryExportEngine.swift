import Foundation

enum StudySummaryExportEngine {
    static func makeMarkdown(
        progress: UserProgress,
        recentSessions: [FocusSession],
        dailyGoalMinutes: Int,
        privacyModeTitle: String,
        generatedAt: Date = Date()
    ) -> String {
        let completedSessions = recentSessions.filter { $0.completed }
        let ratedSessions = recentSessions.filter { $0.selfRating != nil }
        let totalRecentMinutes = completedSessions.reduce(0) { $0 + $1.actualMinutesRoundedDown }
        let achievements = AchievementEngine.achievements(
            progress: progress,
            recentSessions: recentSessions,
            dailyGoalMinutes: dailyGoalMinutes
        )
        let unlockedAchievements = achievements.filter { $0.isUnlocked }

        var lines: [String] = []

        lines.append("# Foku Study Summary")
        lines.append("")
        lines.append("Generated: \(formatDate(generatedAt))")
        lines.append("Privacy mode: \(privacyModeTitle)")
        lines.append("")
        lines.append("## Progress")
        lines.append("")
        lines.append("- Level: \(progress.level)")
        lines.append("- Total XP: \(progress.totalXP)")
        lines.append("- Bond: \(progress.bond)/100")
        lines.append("- Momentum: \(progress.momentum)/100")
        lines.append("- Current streak: \(progress.currentStreak) day(s)")
        lines.append("- Best streak: \(progress.bestStreak) day(s)")
        lines.append("")
        lines.append("## Today")
        lines.append("")
        lines.append("- Focused minutes today: \(progress.today.focusedMinutes) / \(dailyGoalMinutes)m")
        lines.append("- Completed sessions today: \(progress.today.completedSessions)")
        lines.append("- XP earned today: \(progress.today.xpEarned)")
        lines.append("")
        lines.append("## Recent activity")
        lines.append("")
        lines.append("- Recent completed sessions: \(completedSessions.count)")
        lines.append("- Recent rated sessions: \(ratedSessions.count)")
        lines.append("- Recent focused minutes: \(totalRecentMinutes)m")
        lines.append("")

        let subjectMinutes = subjectMinutes(from: recentSessions)
        lines.append("## Subject breakdown")
        lines.append("")

        if subjectMinutes.isEmpty {
            lines.append("- No subject data yet.")
        } else {
            let sortedSubjects = subjectMinutes.sorted { lhs, rhs in
                if lhs.value == rhs.value {
                    return lhs.key < rhs.key
                }

                return lhs.value > rhs.value
            }

            for item in sortedSubjects {
                lines.append("- \(item.key): \(item.value)m")
            }
        }

        lines.append("")
        lines.append("## Achievements")
        lines.append("")
        lines.append("- Unlocked achievements: \(unlockedAchievements.count) / \(achievements.count)")
        lines.append("")

        lines.append("## Recent sessions")
        lines.append("")

        if recentSessions.isEmpty {
            lines.append("- No recent sessions yet.")
        } else {
            for session in recentSessions.prefix(5) {
                lines.append("- \(sessionSummaryLine(session))")
            }
        }

        lines.append("")
        lines.append("## Privacy note")
        lines.append("")
        lines.append("Foku is local-first in this prototype. It does not collect websites, messages, files, screen contents, keyboard activity, or browser history.")
        lines.append("")

        return lines.joined(separator: "\n")
    }

    static func fileName(generatedAt: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm"
        return "Foku-study-summary-\(formatter.string(from: generatedAt)).md"
    }

    private static func sessionSummaryLine(_ session: FocusSession) -> String {
        let status = session.completed ? "Completed" : "Incomplete"
        let rating = session.ratingText
        let intention = cleanIntention(session.intentionText)
        let reflection = session.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines)

        var parts: [String] = [
            "\(formatDate(session.startTime))",
            status,
            "\(session.actualMinutesRoundedDown)m",
            "+\(session.xpEarned) XP",
            rating
        ]

        if !intention.isEmpty {
            parts.append("Intention: \(intention)")
        }

        if !reflection.isEmpty {
            parts.append("Reflection: \(reflection)")
        }

        return parts.joined(separator: " | ")
    }

    private static func subjectMinutes(from sessions: [FocusSession]) -> [String: Int] {
        var result: [String: Int] = [:]

        for session in sessions where session.completed {
            let subjects = subjects(from: session.intentionText)

            if subjects.isEmpty {
                continue
            }

            for subject in subjects {
                result[subject, default: 0] += session.actualMinutesRoundedDown
            }
        }

        return result
    }

    private static func subjects(from intentionText: String) -> [String] {
        let cleanText = cleanIntention(intentionText)

        var subjects: [String] = []
        var current = ""
        var isInsideBracket = false

        for character in cleanText {
            if character == "[" {
                current = ""
                isInsideBracket = true
            } else if character == "]" {
                let subject = current.trimmingCharacters(in: .whitespacesAndNewlines)
                if !subject.isEmpty {
                    subjects.append(subject)
                }
                current = ""
                isInsideBracket = false
            } else if isInsideBracket {
                current.append(character)
            }
        }

        if subjects.isEmpty && !cleanText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return ["Other"]
        }

        return Array(Set(subjects)).sorted()
    }

    private static func cleanIntention(_ text: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasPrefix("Intention: ") {
            return String(trimmed.dropFirst("Intention: ".count))
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return trimmed
    }

    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
