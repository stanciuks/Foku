import SwiftUI

struct WeeklyFocusChartView: View {
    let sessions: [FocusSession]

    private let calendar = Calendar.current

    private var days: [Date] {
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset - 6, to: today)
        }
    }

    private var dayMinutes: [(date: Date, minutes: Int)] {
        days.map { day in
            let minutes = sessions
                .filter { session in
                    session.completed &&
                    calendar.isDate(session.startTime, inSameDayAs: day)
                }
                .reduce(0) { total, session in
                    guard let endTime = session.endTime else {
                        return total
                    }

                    let seconds = max(0, endTime.timeIntervalSince(session.startTime))
                    return total + Int(seconds / 60)
                }

            return (date: day, minutes: minutes)
        }
    }

    private var maxMinutes: Int {
        max(dayMinutes.map(\.minutes).max() ?? 0, 1)
    }

    private var totalMinutes: Int {
        dayMinutes.reduce(0) { $0 + $1.minutes }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("7-day focus chart")
                        .font(.headline)

                    Text("Completed focus minutes from the last 7 days")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(totalMinutes)m")
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            HStack(alignment: .bottom, spacing: 10) {
                ForEach(dayMinutes, id: \.date) { item in
                    VStack(spacing: 6) {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.12))
                                .frame(height: 96)

                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.accentColor.opacity(item.minutes == 0 ? 0.25 : 0.80))
                                .frame(height: barHeight(for: item.minutes))
                        }

                        Text("\(item.minutes)m")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)

                        Text(dayLabel(for: item.date))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }

            Text("This chart is calculated locally from saved completed sessions.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func barHeight(for minutes: Int) -> CGFloat {
        let minimumHeight: CGFloat = 8
        let maximumHeight: CGFloat = 96

        guard minutes > 0 else {
            return minimumHeight
        }

        let ratio = CGFloat(minutes) / CGFloat(maxMinutes)
        return max(minimumHeight, maximumHeight * ratio)
    }

    private func dayLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}
