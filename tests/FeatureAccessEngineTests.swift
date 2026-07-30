import Foundation

@main
struct FeatureAccessEngineTestRunner {
    static func main() {
        var failures: [String] = []

        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() {
                failures.append(message)
            }
        }

        let freeItems = FeatureAccessEngine.accessItems(for: .free)
        let plusItems = FeatureAccessEngine.accessItems(for: .plusPreview)

        func item(
            _ feature: FokuFeature,
            in items: [FokuFeatureAccessItem]
        ) -> FokuFeatureAccessItem? {
            items.first { $0.feature == feature }
        }

        expect(
            freeItems.count == FokuFeature.allCases.count,
            "Free plan should return one access item for every feature."
        )

        expect(
            plusItems.count == FokuFeature.allCases.count,
            "Plus Preview plan should return one access item for every feature."
        )

        expect(
            Set(freeItems.map { $0.id }).count == freeItems.count,
            "Free plan access item ids should be unique."
        )

        expect(
            Set(plusItems.map { $0.id }).count == plusItems.count,
            "Plus Preview access item ids should be unique."
        )

        let expectedFreeIncluded: Set<FokuFeature> = [
            .coreTimer,
            .localProgress,
            .basicDashboard,
            .moodColours,
            .levelAccessories,
            .accessoryPreview
        ]

        for feature in FokuFeature.allCases {
            let freeItem = item(feature, in: freeItems)
            expect(
                freeItem != nil,
                "Free plan should include an item for \(feature.rawValue)."
            )

            expect(
                freeItem?.isIncluded == expectedFreeIncluded.contains(feature),
                "Free plan access state is wrong for \(feature.rawValue)."
            )
        }

        let expectedFreeLocked: Set<FokuFeature> = [
            .advancedCosmetics,
            .advancedAnalytics,
            .exportEvidence
        ]

        for feature in expectedFreeLocked {
            expect(
                item(feature, in: freeItems)?.isIncluded == false,
                "Future paid candidate \(feature.rawValue) should not be included in Free."
            )

            expect(
                item(feature, in: freeItems)?.note.lowercased().contains("future") == true,
                "Future paid candidate \(feature.rawValue) should have a future-facing note."
            )
        }

        for feature in FokuFeature.allCases {
            expect(
                item(feature, in: plusItems)?.isIncluded == true,
                "Plus Preview should include \(feature.rawValue)."
            )

            expect(
                item(feature, in: plusItems)?.note == "Included",
                "Plus Preview note for \(feature.rawValue) should be Included."
            )
        }

        let repeatedA = FeatureAccessEngine.accessItems(for: .free)
        let repeatedB = FeatureAccessEngine.accessItems(for: .free)

        expect(
            repeatedA == repeatedB,
            "FeatureAccessEngine output should be deterministic for identical input."
        )

        expect(
            FokuPlan.free.title == "Foku Free",
            "Free plan title should be stable."
        )

        expect(
            FokuPlan.plusPreview.title == "Foku Plus Preview",
            "Plus Preview plan title should be stable."
        )

        if failures.isEmpty {
            print("✅ FeatureAccessEngine tests passed.")
            print("Checked:")
            print("- every feature gets one access item")
            print("- access item ids are unique")
            print("- Free includes only core prototype features")
            print("- future paid candidates stay excluded from Free")
            print("- Plus Preview includes all listed features")
            print("- future paid candidates have future-facing notes")
            print("- plan titles are stable")
            print("- output is deterministic")
        } else {
            print("❌ FeatureAccessEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
