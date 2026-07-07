import SwiftUI

struct ContentView: View {
    var body: some View {
        PopoverRootView()
            .environmentObject(FocusSessionManager())
    }
}

#Preview {
    ContentView()
}
