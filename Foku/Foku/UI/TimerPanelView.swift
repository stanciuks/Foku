import SwiftUI

struct TimerPanelView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager

    private let durationOptions: [(title: String, seconds: Int)] = [
        ("5", 5 * 60),
        ("15", 15 * 60),
        ("25", 25 * 60),
        ("45", 45 * 60)
    ]

    var body: some View {
        VStack(spacing: 14) {
            Text(sessionManager.formattedTime)
                .font(.system(size: 54, weight: .bold, design: .rounded))
                .monospacedDigit()

            intentionField

            durationPicker

            controls
        }
    }

    private var intentionField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Study intention")
                SubjectTagPickerView(intention: $sessionManager.sessionIntention)
                .font(.caption)
                .foregroundStyle(.secondary)

            TextField("e.g. Biology notes, math practice, essay plan", text: $sessionManager.sessionIntention)
                .textFieldStyle(.roundedBorder)
                .disabled(sessionManager.state == .running || sessionManager.state == .paused)

            Text(sessionManager.sessionIntentionSummary)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private var durationPicker: some View {
        VStack(spacing: 8) {
            Text("Focus length")
                .font(.caption)
                .foregroundStyle(.secondary)

                CustomDurationView()
                    .environmentObject(sessionManager)

            HStack {
                ForEach(durationOptions, id: \.seconds) { option in
                    Button("\(option.title)m") {
                        sessionManager.setPlannedDuration(option.seconds)
                    }
                    .disabled(sessionManager.state == .running || sessionManager.state == .paused)
                    .buttonStyle(.bordered)
                }
            }

            if sessionManager.state == .running || sessionManager.state == .paused {
                Text("Duration and intention are locked during a session.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private var controls: some View {
        switch sessionManager.state {
        case .idle:
            Button("Start Focus") {
                sessionManager.startSession()
            }
            .buttonStyle(.borderedProminent)

        case .running:
            HStack {
                Button("Pause") {
                    sessionManager.pauseSession()
                }

                Button("Complete") {
                    sessionManager.completeSession()
                }
                .buttonStyle(.borderedProminent)

                Button("Abandon") {
                    sessionManager.abandonSession()
                }
            }

        case .paused:
            HStack {
                Button("Resume") {
                    sessionManager.resumeSession()
                }
                .buttonStyle(.borderedProminent)

                Button("Complete") {
                    sessionManager.completeSession()
                }

                Button("Abandon") {
                    sessionManager.abandonSession()
                }
            }

        case .completed, .abandoned:
            VStack(spacing: 10) {
                Button("Start Focus") {
                    sessionManager.startSession()
                }
                .buttonStyle(.borderedProminent)

                Button("Reset") {
                    sessionManager.resetToIdle()
                }
            }
        }
    }
}
