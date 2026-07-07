import SwiftUI

struct TimerPanelView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 12) {
            Text(appState.focusManager.formattedRemainingTime)
                .font(.system(size: 42, weight: .semibold, design: .rounded))
                .monospacedDigit()

            Picker("Duration", selection: Binding(
                get: { appState.focusManager.selectedMinutes },
                set: { appState.focusManager.prepareDuration(minutes: $0) }
            )) {
                Text("15 min").tag(15)
                Text("25 min").tag(25)
                Text("45 min").tag(45)
                Text("60 min").tag(60)
            }
            .pickerStyle(.segmented)
            .disabled(appState.focusManager.isRunning)

            if !appState.focusManager.isRunning {
                Button("Start Focus") {
                    appState.focusManager.start()
                    appState.updateMoodForCurrentSession()
                }
                .buttonStyle(.borderedProminent)
            } else {
                HStack {
                    if appState.focusManager.isPaused {
                        Button("Resume") {
                            appState.focusManager.resume()
                            appState.updateMoodForCurrentSession()
                        }
                    } else {
                        Button("Pause") {
                            appState.focusManager.pause()
                            appState.updateMoodForCurrentSession()
                        }
                    }

                    Button("Complete") {
                        appState.focusManager.complete()
                        appState.fokuMood = "Nice work"
                        appState.menuBarSymbol = "✨"
                    }

                    Button("Abandon") {
                        appState.focusManager.abandon()
                        appState.fokuMood = "We can try again"
                        appState.menuBarSymbol = "🐾"
                    }
                }
            }
        }
    }
}
