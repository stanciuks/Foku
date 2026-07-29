import SwiftUI

struct OnboardingCardView: View {
    @AppStorage("foku.hasDismissedIntro") private var hasDismissedIntro = false

    var body: some View {
        if !hasDismissedIntro {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "sparkles")
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome to Foku")
                            .font(.headline)

                        Text("A local-first focus companion that rewards real study sessions.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Button {
                        hasDismissedIntro = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.caption)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("Dismiss welcome guide")
                }

                VStack(alignment: .leading, spacing: 10) {
                    onboardingStep(
                        icon: "target",
                        title: "Set an intention",
                        text: "Choose a subject and write what you plan to study."
                    )

                    onboardingStep(
                        icon: "timer",
                        title: "Focus honestly",
                        text: "Start a session, pause when needed, then complete it."
                    )

                    onboardingStep(
                        icon: "checkmark.seal",
                        title: "Reflect and grow",
                        text: "Rate your focus. Foku updates XP, Bond, Momentum, goals, and achievements using deterministic local rules."
                    )
                }

                HStack(spacing: 8) {
                    Text("Trust Mode")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.secondary.opacity(0.14))
                        )

                    Text("No websites, messages, files, screen contents, keyboard activity, or browser history are collected.")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.secondary.opacity(0.10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondary.opacity(0.16), lineWidth: 1)
            )
        }
    }

    private func onboardingStep(
        icon: String,
        title: String,
        text: String
    ) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.caption)
                .frame(width: 18)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)

                Text(text)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
