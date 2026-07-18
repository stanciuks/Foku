import SwiftUI

struct WeeklyStatsView: View {
    let sessions: [FocusSession]

    private var weekSessions: [FocusSession] {
        sessions.filter { session in
            Calendar.current.isDate(session.startTime, equalTo: Date(), toGranularity: .weekOfYear)
        }
    }

    private var completedWeekSessions: [FocusSession] {
        weekSessions.filter { $0.completed }
    }

    private var totalFocusedMinutes: Int {
        completedWeekSessions.reduce(0) { total, session in
            guard let endTime = session.endTime else {
                return total
            }

            let seconds = max(0, endTime.timeIntervalSince(session.startTime))
            return total + Int(seconds / 60)
        }
    }

    private var activeDays: Int {
        let dayKeys = Set(completedWeekSessions.map { session in
            DailyStudyStats.currentDayKey(date: session.startTime)
        })

        return dayKeys.count
    }

    private var averageMinutesPerActiveDay: Int {
        guard activeDays > 0 else {
            return 0
        }

        return totalFocusedMinutes / activeDays
    }

    private var bestDayText: String {
        let grouped = Dictionary(grouping: completedWeekSessions) { session in
            DailyStudyStats.currentDayKey(date: session.startTime)
        }

        let dayTotals = grouped.mapValues { sessions in
            sessions.reduce(0) { total, session in
                guard let endTime = session.endTime else {
                    return total
                }

                let seconds = max(0, endTime.timeIntervalSince(session.startTime))
                return total + Int(seconds / 60)
            }
        }

        guard let best = dayTotals.max(by: { $0.value < $1.value }) else {
            return "No study yet"
        }

        return "\(best.value)m"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This week")
                .font(.headline)

            HStack(spacing: 12) {
                weeklyMetric(title: "Sessions", value: "\(completedWeekSessions.count)")
                weeklyMetric(title: "Minutes", value: "\(totalFocusedMinutes)m")
                weeklyMetric(title: "Active days", value: "\(activeDays)")
            }

            HStack(spacing: 12) {
                weeklyMetric(title: "Avg / active day", value: "\(averageMinutesPerActiveDay)m")
                weeklyMetric(title: "Best day", value: bestDayText)
            }

            if completedWeekSessions.isEmpty {
                Text("Complete a session this week to start weekly progress tracking.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("Weekly stats are calculated locally from completed sessions.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func weeklyMetric(title: String, value: String) -> some View {
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
