import SwiftUI

struct PopoverRootView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 18) {
            VStack(spacing: 6) {
                Text("Foku")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(appState.menuBarSymbol)
                    .font(.system(size: 54))

                Text(appState.fokuMood)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            TimerPanelView()

            if let session = appState.focusManager.lastFinishedSession {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last session")
                        .font(.headline)
                    Text("Status: \(session.status.rawValue)")
                    Text("Time studied: \(session.actualDurationSeconds / 60) min")
                }
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .onReceive(appState.focusManager.$isRunning) { _ in
            appState.updateMoodForCurrentSession()
        }
        .onReceive(appState.focusManager.$isPaused) { _ in
            appState.updateMoodForCurrentSession()
        }
    }
}
