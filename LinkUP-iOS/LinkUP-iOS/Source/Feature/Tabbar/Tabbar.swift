import SwiftUI

struct Tabbar: View {
    @ObservedObject var tabManager: TabManager
    @EnvironmentObject private var login: AuthManager
    
    var body: some View {
        TabView(selection: $tabManager.selectedTab) {
            PopularView()
                .environmentObject(tabManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(TabPage.popular)
            
            PostsView()
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Q & A")
                }
                .tag(TabPage.posts)
            
            RankingView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Ranking")
                }
                .tag(TabPage.ranking)
            
            if login.isLogin {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    .tag(TabPage.profile)
            } else {
                MoveLoginView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
            }
        }
        .tint(Color("MainColor"))
    }
}

#Preview {
    Tabbar(tabManager: TabManager())
}
