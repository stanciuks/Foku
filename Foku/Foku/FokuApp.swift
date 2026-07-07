import SwiftUI

@main
struct FokuApp: App {
    @StateObject private var sessionManager = FocusSessionManager()

    var body: some Scene {
        MenuBarExtra {
            PopoverRootView()
                .environmentObject(sessionManager)
        } label: {
            Text(sessionManager.menuBarIcon)
        }
        .menuBarExtraStyle(.window)
    }
}
