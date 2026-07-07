import SwiftUI

@main
struct FokuApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra {
            PopoverRootView()
                .environmentObject(appState)
                .frame(width: 340)
        } label: {
            Text(appState.menuBarSymbol)
        }
        .menuBarExtraStyle(.window)
    }
}
