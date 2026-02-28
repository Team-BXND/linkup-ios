import SwiftUI

enum TabbarItem {
    case popular
    case posts
    case ranking
}

struct Tabbar: View {
    @State private var selectedTab = 0
    @EnvironmentObject private var login: AuthManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PopularView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            PostsView()
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Q & A")
                }
                .tag(1)
            
            RankingView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Ranking")
                }
                .tag(2)
            
            if login.isLogin {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    .tag(3)
            } else {
                MoveLoginView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
            }
        }
        .tint(.main)
    }
}

#Preview {
    Tabbar()
}
