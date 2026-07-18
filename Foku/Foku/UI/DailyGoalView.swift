import SwiftUI

struct DailyGoalView: View {
    @AppStorage("foku.dailyGoalMinutes") private var dailyGoalMinutes: Int = 60

    let focusedMinutesToday: Int

    private var clampedGoal: Int {
        min(max(dailyGoalMinutes, 15), 240)
    }

    private var progress: Double {
        guard clampedGoal > 0 else {
            return 0
        }

        return min(Double(focusedMinutesToday) / Double(clampedGoal), 1.0)
    }

    private var remainingMinutes: Int {
        max(clampedGoal - focusedMinutesToday, 0)
    }

    private var statusText: String {
        if focusedMinutesToday >= clampedGoal {
            return "Daily goal reached"
        }

        return "\(remainingMinutes)m remaining"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Daily focus goal")
                        .font(.headline)

                    Text("Set a local goal for today's focused minutes")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(statusText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            ProgressView(value: progress)

            HStack {
                goalMetric(title: "Today", value: "\(focusedMinutesToday)m")
                goalMetric(title: "Goal", value: "\(clampedGoal)m")
                goalMetric(title: "Progress", value: "\(Int((progress * 100).rounded()))%")
            }

            Stepper(value: $dailyGoalMinutes, in: 15...240, step: 15) {
                Text("Goal: \(clampedGoal)m")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            Text("This goal is saved locally on this Mac and does not require an account.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .onAppear {
            dailyGoalMinutes = clampedGoal
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func goalMetric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondary.opacity(0.10))
        )
    }
}
