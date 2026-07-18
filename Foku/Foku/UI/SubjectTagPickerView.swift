import SwiftUI

struct SubjectTagPickerView: View {
    @Binding var intention: String

    private let subjects = [
        "General",
        "Biology",
        "Math",
        "History",
        "English",
        "Psychology",
        "Other"
    ]

    private var selectedSubject: String {
        let trimmed = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        for subject in subjects where subject != "General" {
            if trimmed.hasPrefix("[\(subject)]") {
                return subject
            }
        }

        return "General"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Subject tag")
                .font(.caption)
                .foregroundStyle(.secondary)

            FlowLayout(spacing: 8) {
                ForEach(subjects, id: \.self) { subject in
                    Button {
                        applySubject(subject)
                    } label: {
                        Text(subject)
                            .font(.caption)
                            .fontWeight(selectedSubject == subject ? .semibold : .regular)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(selectedSubject == subject ? Color.accentColor.opacity(0.22) : Color.secondary.opacity(0.12))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }

            if selectedSubject != "General" {
                Text("Selected: \(selectedSubject)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func applySubject(_ subject: String) {
        let base = intentionWithoutSubjectTag()

        if subject == "General" {
            intention = base
        } else if base.isEmpty {
            intention = "[\(subject)] "
        } else {
            intention = "[\(subject)] \(base)"
        }
    }

    private func intentionWithoutSubjectTag() -> String {
        var output = intention.trimmingCharacters(in: .whitespacesAndNewlines)

        for subject in subjects where subject != "General" {
            let prefix = "[\(subject)]"

            if output.hasPrefix(prefix) {
                output = String(output.dropFirst(prefix.count))
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                break
            }
        }

        return output
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let width = proposal.width ?? 360
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX + size.width > width && currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }

            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }

        return CGSize(width: width, height: currentY + rowHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX + size.width > bounds.maxX && currentX > bounds.minX {
                currentX = bounds.minX
                currentY += rowHeight + spacing
                rowHeight = 0
            }

            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                proposal: ProposedViewSize(size)
            )

            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
