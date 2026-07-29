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
