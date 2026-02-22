import SwiftUI
import Foundation


struct AuthView: View {
    @StateObject var PWVM = PWViewModel()
    @StateObject var AuthNav = AuthNavigation()
    var showalert = false
    var body: some View {
        Group {
            switch AuthNav.step {
            case 0:
                LoginView()
            case 1:
                SignupView()
            case 2:
                EmailView()
            case 3:
                CodeView()
            case 4:
                PWView()
            default:
                LoginView()
            }
        }
        .environmentObject(AuthNav)
        .environmentObject(PWVM)
        .onAppear {
            PWVM.nav = AuthNav
        }
    }
}

#Preview {
    AuthView()
}

