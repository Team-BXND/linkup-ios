import SwiftUI

@main
struct LinkUP_iOSApp: App {
    @StateObject var authManager = AuthManager.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authManager)
        }
    }
}
