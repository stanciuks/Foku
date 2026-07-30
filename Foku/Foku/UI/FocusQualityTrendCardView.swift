import SwiftUI

@MainActor
struct FocusQualityTrendCardView: View {
    let sessions: [FocusSession]

    private var trend: FocusQualityTrend {
        FocusQualityTrendEngine.trend(from: sessions)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("Focus quality trend")
                    .font(.headline)

                Spacer()

                Text("\(trend.scorePercent)%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.secondary.opacity(0.12))
                    )
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(trend.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(trend.detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            VStack(alignment: .leading, spacing: 8) {
                qualityBar

                HStack {
                    Text(trend.summaryLine)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("Last \(trend.ratedSessionCount) rated")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            Text("Based on self-check ratings only. Foku does not inspect your screen or browser history.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var qualityBar: some View {
        GeometryReader { proxy in
            HStack(spacing: 3) {
                barSegment(
                    count: trend.focusedCount,
                    total: max(trend.ratedSessionCount, 1),
                    width: proxy.size.width
                )

                barSegment(
                    count: trend.mixedCount,
                    total: max(trend.ratedSessionCount, 1),
                    width: proxy.size.width
                )

                barSegment(
                    count: trend.unfocusedCount,
                    total: max(trend.ratedSessionCount, 1),
                    width: proxy.size.width
                )
            }
        }
        .frame(height: 10)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.secondary.opacity(0.08))
        )
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }

    private func barSegment(
        count: Int,
        total: Int,
        width: CGFloat
    ) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.secondary.opacity(count == 0 ? 0.08 : 0.34))
            .frame(width: max(width * CGFloat(count) / CGFloat(total), count == 0 ? 0 : 8))
    }
}
