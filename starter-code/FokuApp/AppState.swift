import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published var focusManager = FocusSessionManager()
    @Published var fokuMood: String = "Ready to focus"
    @Published var menuBarSymbol: String = "🐾"

    func updateMoodForCurrentSession() {
        if focusManager.isRunning {
            fokuMood = "Studying"
            menuBarSymbol = "📚"
        } else if focusManager.isPaused {
            fokuMood = "Paused"
            menuBarSymbol = "⏸"
        } else {
            fokuMood = "Ready to focus"
            menuBarSymbol = "🐾"
        }
    }
}
