import SwiftUI

struct PixelPetView: View {
    let mood: PetMood
    let level: Int

    private let pixelSize: CGFloat = 7
    private let pixelSpacing: CGFloat = 1.4

    init(mood: PetMood, level: Int = 1) {
        self.mood = mood
        self.level = max(level, 1)
    }

    var body: some View {
        VStack(spacing: 7) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(style.background.opacity(0.18))

                RoundedRectangle(cornerRadius: 20)
                    .stroke(style.accent.opacity(0.42), lineWidth: 1)

                Circle()
                    .fill(style.accent.opacity(0.10))
                    .frame(width: 78, height: 78)

                pixelPet

                petAccessory
            }
            .frame(width: 104, height: 104)

            VStack(spacing: 2) {
                Text(mood.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                if accessoryKind != .none {
                    Text(accessoryKind.label)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Foku pet mood: \(mood.title), level \(level)")
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
        .shadow(color: style.accent.opacity(0.18), radius: 4, x: 0, y: 2)
    }

    @ViewBuilder
    private var petAccessory: some View {
        switch accessoryKind {
        case .none:
            EmptyView()

        case .headband:
            RoundedRectangle(cornerRadius: 2)
                .fill(style.highlight.opacity(0.88))
                .frame(width: 52, height: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.primary.opacity(0.16), lineWidth: 1)
                )
                .offset(y: -30)

        case .studyStar:
            Image(systemName: "star.fill")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(style.highlight)
                .padding(5)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.12))
                )
                .overlay(
                    Circle()
                        .stroke(style.highlight.opacity(0.45), lineWidth: 1)
                )
                .offset(x: 30, y: -30)

        case .crown:
            Image(systemName: "crown.fill")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(style.highlight)
                .shadow(color: style.highlight.opacity(0.26), radius: 3, x: 0, y: 1)
                .offset(y: -34)
        }
    }

    private func pixelColor(for symbol: Character) -> Color {
        switch symbol {
        case "X":
            return style.accent
        case "H":
            return style.highlight
        case "E":
            return style.eye
        case "M":
            return style.mouth
        case "B":
            return style.blush
        case "S":
            return style.eye.opacity(0.55)
        default:
            return Color.clear
        }
    }

    private var pixelRows: [String] {
        switch style.kind {
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

    private var accessoryKind: PixelPetAccessoryKind {
        PixelPetAccessoryKind.make(forLevel: level)
    }
}

private enum PixelPetAccessoryKind: Equatable {
    case none
    case headband
    case studyStar
    case crown

    var label: String {
        switch self {
        case .none:
            return ""
        case .headband:
            return "Level \(3)+ headband"
        case .studyStar:
            return "Level \(5)+ study star"
        case .crown:
            return "Level \(8)+ crown"
        }
    }

    static func make(forLevel level: Int) -> PixelPetAccessoryKind {
        if level >= 8 {
            return .crown
        }

        if level >= 5 {
            return .studyStar
        }

        if level >= 3 {
            return .headband
        }

        return .none
    }
}

private struct PixelPetMoodStyle {
    enum Kind {
        case proud
        case focused
        case happy
        case tired
        case sad
        case neutral
    }

    let kind: Kind
    let accent: Color
    let highlight: Color
    let background: Color
    let eye: Color
    let mouth: Color
    let blush: Color

    static func make(for moodTitle: String) -> PixelPetMoodStyle {
        let title = moodTitle.lowercased()

        if title.contains("proud") {
            return PixelPetMoodStyle(
                kind: .proud,
                accent: Color.purple.opacity(0.84),
                highlight: Color.pink.opacity(0.86),
                background: Color.purple,
                eye: Color.primary.opacity(0.84),
                mouth: Color.primary.opacity(0.70),
                blush: Color.pink.opacity(0.55)
            )
        }

        if title.contains("focus") || title.contains("locked") {
            return PixelPetMoodStyle(
                kind: .focused,
                accent: Color.blue.opacity(0.82),
                highlight: Color.cyan.opacity(0.88),
                background: Color.blue,
                eye: Color.primary.opacity(0.84),
                mouth: Color.primary.opacity(0.70),
                blush: Color.cyan.opacity(0.36)
            )
        }

        if title.contains("happy") || title.contains("calm") || title.contains("good") {
            return PixelPetMoodStyle(
                kind: .happy,
                accent: Color.green.opacity(0.80),
                highlight: Color.mint.opacity(0.88),
                background: Color.green,
                eye: Color.primary.opacity(0.84),
                mouth: Color.primary.opacity(0.72),
                blush: Color.mint.opacity(0.46)
            )
        }

        if title.contains("tired") || title.contains("sleep") || title.contains("low") {
            return PixelPetMoodStyle(
                kind: .tired,
                accent: Color.orange.opacity(0.74),
                highlight: Color.yellow.opacity(0.72),
                background: Color.orange,
                eye: Color.primary.opacity(0.72),
                mouth: Color.primary.opacity(0.62),
                blush: Color.yellow.opacity(0.30)
            )
        }

        if title.contains("sad") || title.contains("lonely") || title.contains("neglect") {
            return PixelPetMoodStyle(
                kind: .sad,
                accent: Color.indigo.opacity(0.72),
                highlight: Color.blue.opacity(0.64),
                background: Color.indigo,
                eye: Color.primary.opacity(0.78),
                mouth: Color.primary.opacity(0.62),
                blush: Color.blue.opacity(0.28)
            )
        }

        return PixelPetMoodStyle(
            kind: .neutral,
            accent: Color.secondary.opacity(0.80),
            highlight: Color.secondary.opacity(0.56),
            background: Color.secondary,
            eye: Color.primary.opacity(0.80),
            mouth: Color.primary.opacity(0.66),
            blush: Color.secondary.opacity(0.35)
        )
    }
}
