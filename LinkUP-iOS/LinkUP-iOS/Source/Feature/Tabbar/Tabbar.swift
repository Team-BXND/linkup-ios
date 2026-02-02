import SwiftUI

enum TabbarItem {
    case popular
    case posts
    case ranking
}

struct Tabbar: View {
    @State private var selectedTab = 0
    
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
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(Color("MainColor"))
    }
}

#Preview {
    Tabbar()
}
