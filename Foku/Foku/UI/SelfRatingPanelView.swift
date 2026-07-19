import SwiftUI

struct SelfRatingPanelView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Self-check")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("How focused was this session?")
                .font(.subheadline)
                .fontWeight(.medium)


            Text("Reflection note")
                .font(.caption)
                .foregroundStyle(.secondary)

            TextEditor(text: $sessionManager.sessionReflectionNote)
                .frame(height: 58)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondary.opacity(0.10))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.20), lineWidth: 1)
                )

            Text("Optional: what helped, what distracted you, or what to try next.")
                .font(.caption2)
                .foregroundStyle(.secondary)

            HStack {
                ForEach(SelfRating.allCases, id: \.self) { rating in
                    Button(rating.shortTitle) {
                        sessionManager.submitSelfRating(rating)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
