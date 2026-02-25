import SwiftUI

@main
struct LinkUP_iOSApp: App {
    @StateObject var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authManager)
        }
    }
}
