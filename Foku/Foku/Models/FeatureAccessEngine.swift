import Foundation

enum FokuPlan: String, CaseIterable, Codable, Identifiable {
    case free
    case plusPreview

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .free:
            return "Foku Free"
        case .plusPreview:
            return "Foku Plus Preview"
        }
    }

    var subtitle: String {
        switch self {
        case .free:
            return "Core focus companion features"
        case .plusPreview:
            return "Future paid tier placeholder"
        }
    }
}

enum FokuFeature: String, CaseIterable, Codable, Identifiable {
    case coreTimer
    case localProgress
    case basicDashboard
    case moodColours
    case levelAccessories
    case accessoryPreview
    case advancedCosmetics
    case advancedAnalytics
    case exportEvidence

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .coreTimer:
            return "Focus timer"
        case .localProgress:
            return "Local XP, Bond, and Momentum"
        case .basicDashboard:
            return "Dashboard overview"
        case .moodColours:
            return "Mood colours"
        case .levelAccessories:
            return "Level accessories"
        case .accessoryPreview:
            return "Accessory preview"
        case .advancedCosmetics:
            return "Advanced cosmetics"
        case .advancedAnalytics:
            return "Advanced analytics"
        case .exportEvidence:
            return "Evidence export"
        }
    }

    var freeDescription: String {
        switch self {
        case .coreTimer:
            return "Start, pause, complete, and reflect on focus sessions."
        case .localProgress:
            return "Keep local XP, level, Bond, Momentum, and streaks."
        case .basicDashboard:
            return "See current progress, history, privacy, and basic analytics."
        case .moodColours:
            return "Pet colours react to mood."
        case .levelAccessories:
            return "Unlock simple accessories through levels."
        case .accessoryPreview:
            return "Preview the current accessory path."
        case .advancedCosmetics:
            return "More pet cosmetics could become a future paid feature."
        case .advancedAnalytics:
            return "Deeper long-term analytics could become a future paid feature."
        case .exportEvidence:
            return "One-click evidence exports could become a future paid/student feature."
        }
    }
}

struct FokuFeatureAccessItem: Identifiable, Hashable {
    let feature: FokuFeature
    let isIncluded: Bool
    let note: String

    var id: String {
        feature.id
    }
}

enum FeatureAccessEngine {
    static func accessItems(for plan: FokuPlan) -> [FokuFeatureAccessItem] {
        FokuFeature.allCases.map { feature in
            FokuFeatureAccessItem(
                feature: feature,
                isIncluded: isIncluded(feature, in: plan),
                note: note(for: feature, in: plan)
            )
        }
    }

    static func isIncluded(_ feature: FokuFeature, in plan: FokuPlan) -> Bool {
        switch plan {
        case .free:
            switch feature {
            case .coreTimer,
                 .localProgress,
                 .basicDashboard,
                 .moodColours,
                 .levelAccessories,
                 .accessoryPreview:
                return true
            case .advancedCosmetics,
                 .advancedAnalytics,
                 .exportEvidence:
                return false
            }

        case .plusPreview:
            return true
        }
    }

    static func note(for feature: FokuFeature, in plan: FokuPlan) -> String {
        if isIncluded(feature, in: plan) {
            return "Included"
        }

        switch feature {
        case .advancedCosmetics:
            return "Future Plus candidate"
        case .advancedAnalytics:
            return "Future Plus candidate"
        case .exportEvidence:
            return "Future Plus/student candidate"
        default:
            return "Not included"
        }
    }
}
