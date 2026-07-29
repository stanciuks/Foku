import SwiftUI

struct SelfRatingPanelView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    private let reflectionPrompts = [
        "What helped?",
        "What distracted me?",
        "Next time..."
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Session self-check")
                    .font(.headline)

                Text("Rate your focus honestly. Reflection is optional, but it can help you notice patterns.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Reflection note")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    Text("Optional")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 8) {
                    ForEach(reflectionPrompts, id: \.self) { prompt in
                        Button(prompt) {
                            appendPrompt(prompt)
                        }
                        .font(.caption)
                    }
                }

                TextEditor(text: $sessionManager.sessionReflectionNote)
                    .frame(height: 76)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.secondary.opacity(0.10))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.22), lineWidth: 1)
                    )

                Text("Example: Phone distracted me, or Pomodoro length felt right.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("How focused was this session?")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                VStack(spacing: 8) {
                    ForEach(SelfRating.allCases, id: \.self) { rating in
                        Button {
                            sessionManager.submitSelfRating(rating)
                        } label: {
                            HStack {
                                Text(rating.shortTitle)
                                    .fontWeight(.semibold)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 6)
                        }
                    }
                }
            }

            Text("Rewards are calculated after you submit the self-rating.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func appendPrompt(_ prompt: String) {
        let trimmed = sessionManager.sessionReflectionNote.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            sessionManager.sessionReflectionNote = prompt + " "
        } else {
            sessionManager.sessionReflectionNote = trimmed + "\n" + prompt + " "
        }
    }
}

struct SessionSummaryCardView: View {
    let session: FocusSession

    private var bondText: String {
        session.bondChange >= 0 ? "+\(session.bondChange)" : "\(session.bondChange)"
    }

    private var momentumText: String {
        session.momentumChange >= 0 ? "+\(session.momentumChange)" : "\(session.momentumChange)"
    }

    private var cleanIntentionText: String {
        let text = session.intentionText.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.hasPrefix("Intention: ") {
            return String(text.dropFirst("Intention: ".count))
        }

        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last session summary")
                        .font(.headline)

                    Text(session.statusText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("+\(session.xpEarned) XP")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }

            HStack(spacing: 10) {
                summaryPill(title: "Time", value: "\(session.actualMinutesRoundedDown)m")
                summaryPill(title: "Bond", value: bondText)
                summaryPill(title: "Momentum", value: momentumText)
            }

            Text("Rating: \(session.ratingText)")
                .font(.caption)
                .foregroundStyle(.secondary)

            if !cleanIntentionText.isEmpty {
                Text("Intention: \(cleanIntentionText)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if !session.reflectionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Label("Reflection saved", systemImage: "checkmark.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Label("No reflection note saved", systemImage: "circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if !session.ruleSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(session.ruleSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.secondary.opacity(0.10))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary.opacity(0.18), lineWidth: 1)
        )
    }

    private func summaryPill(title: String, value: String) -> some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary.opacity(0.10))
        )
    }
}


