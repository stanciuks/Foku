import SwiftUI

struct FeatureAccessCardView: View {
    @AppStorage("foku.previewPlan") private var previewPlanRawValue = FokuPlan.free.rawValue

    private var previewPlan: FokuPlan {
        get {
            FokuPlan(rawValue: previewPlanRawValue) ?? .free
        }
        nonmutating set {
            previewPlanRawValue = newValue.rawValue
        }
    }

    private var accessItems: [FokuFeatureAccessItem] {
        FeatureAccessEngine.accessItems(for: previewPlan)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Feature access")
                .font(.headline)

            Text("Monetization-ready structure only. No payments, subscriptions, ads, or App Store logic are active in this prototype.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Picker("Preview plan", selection: Binding(
                get: { previewPlan },
                set: { previewPlan = $0 }
            )) {
                ForEach(FokuPlan.allCases) { plan in
                    Text(plan.title)
                        .tag(plan)
                }
            }
            .pickerStyle(.segmented)

            Text(previewPlan.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(accessItems) { item in
                    featureRow(item)
                }
            }

            Text("Future idea: keep the timer free, then monetize optional cosmetics, deeper analytics, and export tools.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func featureRow(_ item: FokuFeatureAccessItem) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(item.isIncluded ? "✓" : "○")
                .font(.caption)
                .fontWeight(.bold)
                .frame(width: 16)
                .foregroundStyle(item.isIncluded ? .primary : .secondary)

            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline) {
                    Text(item.feature.title)
                        .font(.caption)
                        .fontWeight(.semibold)

                    Spacer()

                    Text(item.note)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Text(item.feature.freeDescription)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(9)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.secondary.opacity(item.isIncluded ? 0.10 : 0.055))
        )
    }
}
