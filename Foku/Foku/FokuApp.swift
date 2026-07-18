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

        WindowGroup("Foku Dashboard", id: "dashboard") {
            DashboardView()
                .environmentObject(sessionManager)
        }
        .defaultSize(width: 980, height: 720)
    }
}
