import SwiftUI

struct PixelPetView: View {
    let mood: PetMood

    private let pixelSize: CGFloat = 7
    private let pixelSpacing: CGFloat = 1.4

    var body: some View {
        VStack(spacing: 7) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.secondary.opacity(0.12))

                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.secondary.opacity(0.26), lineWidth: 1)

                pixelPet
            }
            .frame(width: 104, height: 104)

            Text(mood.title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Foku pet mood: \(mood.title)")
    }

    private var pixelPet: some View {
        VStack(spacing: pixelSpacing) {
            ForEach(Array(pixelRows.enumerated()), id: \.offset) { _, row in
                HStack(spacing: pixelSpacing) {
                    ForEach(Array(row.enumerated()), id: \.offset) { _, symbol in
                        RoundedRectangle(cornerRadius: 1.2)
                            .fill(pixelColor(for: symbol))
                            .frame(width: pixelSize, height: pixelSize)
                    }
                }
            }
        }
        .padding(10)
    }

    private func pixelColor(for symbol: Character) -> Color {
        switch symbol {
        case "X":
            return Color.primary.opacity(0.88)
        case "H":
            return Color.primary
        case "E":
            return Color.black.opacity(0.70)
        case "M":
            return Color.black.opacity(0.62)
        case "B":
            return Color.primary.opacity(0.36)
        case "S":
            return Color.black.opacity(0.45)
        default:
            return Color.clear
        }
    }

    private var pixelRows: [String] {
        switch style {
        case .proud:
            return [
                "...........",
                "...HHHHH...",
                "..HXXXXXH..",
                ".HXXXXXXXH.",
                ".XXEXXXEXX.",
                ".XXBXXXBXX.",
                ".XXXMMMXXX.",
                "..XXXXXXX..",
                "...XX.XX...",
                "..XXX.XXX.."
            ]

        case .focused:
            return [
                "...........",
                "...XXXXX...",
                "..XXXXXXX..",
                ".XXXXXXXXX.",
                ".XXEXXXEXX.",
                ".XXXXXXXXX.",
                ".XXXMMMXXX.",
                "..XXXXXXX..",
                "...XX.XX...",
                "..XXX.XXX.."
            ]

        case .happy:
            return [
                "...........",
                "...HHHHH...",
                "..HXXXXXH..",
                ".HXXXXXXXH.",
                ".XXEXXXEXX.",
                ".XXBXXXBXX.",
                ".XXMMMMMXX.",
                "..XXXXXXX..",
                "...XX.XX...",
                "..XXX.XXX.."
            ]

        case .tired:
            return [
                "...........",
                "...XXXXX...",
                "..XXXXXXX..",
                ".XXXXXXXXX.",
                ".XXSXXXSXX.",
                ".XXXXXXXXX.",
                ".XXXXMXXXX.",
                "..XXXXXXX..",
                "...XX.XX...",
                "..XX...XX.."
            ]

        case .sad:
            return [
                "...........",
                "...XXXXX...",
                "..XXXXXXX..",
                ".XXXXXXXXX.",
                ".XXEXXXEXX.",
                ".XXBXXXBXX.",
                ".XXXXMXXXX.",
                "...XXMXX...",
                "...XX.XX...",
                "..XX...XX.."
            ]

        case .neutral:
            return [
                "...........",
                "...XXXXX...",
                "..XXXXXXX..",
                ".XXXXXXXXX.",
                ".XXEXXXEXX.",
                ".XXXXXXXXX.",
                ".XXXMMMXXX.",
                "..XXXXXXX..",
                "...XX.XX...",
                "..XXX.XXX.."
            ]
        }
    }

    private var style: PixelPetMoodStyle {
        PixelPetMoodStyle.make(for: mood.title)
    }
}

private enum PixelPetMoodStyle {
    case proud
    case focused
    case happy
    case tired
    case sad
    case neutral

    static func make(for moodTitle: String) -> PixelPetMoodStyle {
        let title = moodTitle.lowercased()

        if title.contains("proud") {
            return .proud
        }

        if title.contains("focus") || title.contains("locked") {
            return .focused
        }

        if title.contains("happy") || title.contains("calm") || title.contains("good") {
            return .happy
        }

        if title.contains("tired") || title.contains("sleep") || title.contains("low") {
            return .tired
        }

        if title.contains("sad") || title.contains("lonely") || title.contains("neglect") {
            return .sad
        }

        return .neutral
    }
}
