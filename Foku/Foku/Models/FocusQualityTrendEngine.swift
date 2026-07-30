import Foundation

struct FocusQualityTrend: Hashable {
    let title: String
    let detail: String
    let ratedSessionCount: Int
    let focusedCount: Int
    let mixedCount: Int
    let unfocusedCount: Int
    let scorePercent: Int

    var summaryLine: String {
        "\(focusedCount) focused • \(mixedCount) mixed • \(unfocusedCount) reset"
    }
}

@MainActor
enum FocusQualityTrendEngine {
    static func trend(
        from sessions: [FocusSession],
        limit: Int = 7
    ) -> FocusQualityTrend {
        let ratedSessions = Array(
            sessions
                .filter { $0.selfRating != nil }
                .prefix(max(limit, 1))
        )

        if ratedSessions.isEmpty {
            return FocusQualityTrend(
                title: "No data yet",
                detail: "Complete and rate a few sessions to see your focus quality trend.",
                ratedSessionCount: 0,
                focusedCount: 0,
                mixedCount: 0,
                unfocusedCount: 0,
                scorePercent: 0
            )
        }

        let classifications = ratedSessions.map(classify)

        let focusedCount = classifications.filter { $0 == .focused }.count
        let mixedCount = classifications.filter { $0 == .mixed }.count
        let unfocusedCount = classifications.filter { $0 == .unfocused }.count

        let score = classifications.reduce(0) { total, quality in
            total + quality.score
        }

        let maxScore = ratedSessions.count * FocusQuality.focused.score
        let scorePercent = maxScore == 0
            ? 0
            : Int(round((Double(score) / Double(maxScore)) * 100))

        let title: String
        let detail: String

        if scorePercent >= 75 {
            title = "Mostly focused"
            detail = "Recent self-checks show a strong focus pattern. Keep repeating this routine."
        } else if scorePercent >= 45 {
            title = "Mixed focus"
            detail = "Recent sessions are useful, but distractions still appear. Try a clearer intention or shorter block."
        } else {
            title = "Needs reset"
            detail = "Recent sessions look difficult. Start smaller and rebuild momentum with one short focused block."
        }

        return FocusQualityTrend(
            title: title,
            detail: detail,
            ratedSessionCount: ratedSessions.count,
            focusedCount: focusedCount,
            mixedCount: mixedCount,
            unfocusedCount: unfocusedCount,
            scorePercent: scorePercent
        )
    }

    private static func classify(_ session: FocusSession) -> FocusQuality {
        let rating = session.ratingText.lowercased()

        if rating.contains("partly") || rating.contains("distract") {
            return .mixed
        }

        if rating.contains("did not") ||
            rating.contains("not really") ||
            rating.contains("reset") ||
            rating.contains("poor") {
            return .unfocused
        }

        if rating.contains("focused") {
            return .focused
        }

        return session.completed ? .mixed : .unfocused
    }
}

private enum FocusQuality {
    case focused
    case mixed
    case unfocused

    var score: Int {
        switch self {
        case .focused:
            return 2
        case .mixed:
            return 1
        case .unfocused:
            return 0
        }
    }
}
