import SwiftUI

struct PixelPetView: View {
    let mood: PetMood
    var size: CGFloat = 7

    private var pixels: [String] {
        switch mood {
        case .neutral:
            return [
                "00111100",
                "01111110",
                "11011011",
                "11111111",
                "11100111",
                "01111110",
                "00100100"
            ]
        case .encouraged:
            return [
                "00111100",
                "01111110",
                "11011011",
                "11111111",
                "11000011",
                "01111110",
                "00100100"
            ]
        case .proud:
            return [
                "00111100",
                "01111110",
                "10111101",
                "11111111",
                "11000011",
                "01111110",
                "00100100"
            ]
        case .tired:
            return [
                "00111100",
                "01111110",
                "10011001",
                "11111111",
                "11100111",
                "01111110",
                "00100100"
            ]
        }
    }

    private var moodLabel: String {
        switch mood {
        case .neutral:
            return "Neutral"
        case .encouraged:
            return "Encouraged"
        case .proud:
            return "Proud"
        case .tired:
            return "Tired"
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            VStack(spacing: 1) {
                ForEach(Array(pixels.enumerated()), id: \.offset) { _, row in
                    HStack(spacing: 1) {
                        ForEach(Array(row.enumerated()), id: \.offset) { _, pixel in
                            Rectangle()
                                .fill(pixel == "1" ? Color.primary : Color.clear)
                                .frame(width: size, height: size)
                        }
                    }
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary.opacity(0.10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
            )

            Text(moodLabel)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .accessibilityLabel("Foku pet mood: \(moodLabel)")
    }
}
