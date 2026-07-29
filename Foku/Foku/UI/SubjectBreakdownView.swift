import SwiftUI

struct SubjectBreakdownView: View {
    let sessions: [FocusSession]

    private var summary: SubjectBreakdownSummary {
        SubjectTagEngine.summary(from: sessions)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Subject breakdown")
                .font(.headline)

            HStack(spacing: 10) {
                summaryBox(title: "Top subject", value: summary.topSubject)
                summaryBox(title: "Subjects", value: "\(summary.totalSubjects)")
            }

            if summary.items.isEmpty {
                Text("Add subject tags or study intentions before starting sessions to see a breakdown here.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                VStack(spacing: 8) {
                    ForEach(summary.items) { item in
                        subjectRow(item)
                    }
                }
            }

            Text("Subject breakdown is calculated locally from intention tags.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private func summaryBox(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.secondary.opacity(0.10))
        )
    }

    private func subjectRow(_ item: SubjectBreakdownItem) -> some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 3) {
                Text(item.subject)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text("\(item.sessionCount) session(s)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("\(item.focusedMinutes)m")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.secondary.opacity(0.10))
        )
    }
}
