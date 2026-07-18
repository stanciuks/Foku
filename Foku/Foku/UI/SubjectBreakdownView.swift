import SwiftUI

struct SubjectBreakdownView: View {
    let sessions: [FocusSession]

    private let knownSubjects = [
        "Biology",
        "Math",
        "History",
        "English",
        "Psychology",
        "Other"
    ]

    private var weekCompletedSessions: [FocusSession] {
        sessions.filter { session in
            session.completed &&
            Calendar.current.isDate(session.startTime, equalTo: Date(), toGranularity: .weekOfYear)
        }
    }

    private var subjectStats: [(subject: String, sessions: Int, minutes: Int)] {
        let grouped = Dictionary(grouping: weekCompletedSessions) { session in
            subject(from: session.intention)
        }

        return grouped.map { subject, sessions in
            let minutes = sessions.reduce(0) { total, session in
                guard let endTime = session.endTime else {
                    return total
                }

                let seconds = max(0, endTime.timeIntervalSince(session.startTime))
                return total + Int(seconds / 60)
            }

            return (subject: subject, sessions: sessions.count, minutes: minutes)
        }
        .sorted {
            if $0.minutes == $1.minutes {
                return $0.sessions > $1.sessions
            }

            return $0.minutes > $1.minutes
        }
    }

    private var topSubjectText: String {
        guard let first = subjectStats.first else {
            return "No subject yet"
        }

        return first.subject
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Subject breakdown")
                .font(.headline)

            HStack(spacing: 12) {
                subjectMetric(title: "Top subject", value: topSubjectText)
                subjectMetric(title: "Subjects", value: "\(subjectStats.count)")
            }

            if subjectStats.isEmpty {
                Text("Select a subject tag and complete a session to see subject progress.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 8) {
                    ForEach(subjectStats.prefix(4), id: \.subject) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.subject)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Text("\(item.sessions) session(s)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text("\(item.minutes)m")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.secondary.opacity(0.10))
                        )
                    }
                }

                Text("Subject breakdown is calculated locally from intention tags.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func subjectMetric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

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

    private func subject(from intention: String) -> String {
        let trimmed = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        for subject in knownSubjects {
            if trimmed.hasPrefix("[\(subject)]") {
                return subject
            }
        }

        return "General"
    }
}
