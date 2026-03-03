import SwiftUI

struct MainView: View {
    @StateObject private var tabManager = TabManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            tabManager.selectedTab = .popular
                        }) {
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding(.leading, 13)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .padding(.top, 60)

                    Tabbar(tabManager: tabManager)
                }
                .ignoresSafeArea()
            }
        }
        .environmentObject(tabManager)
    }
}

#Preview {
    MainView()
}
