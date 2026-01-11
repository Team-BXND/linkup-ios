import SwiftUI

enum TabViewItem {
    case popular
    case posts
    case ranking
}

struct MainView: View {
    @State var viewSelected: TabViewItem = .popular
    @State var isLogin: Bool = false
    
    var body: some View {
        ZStack {
            
            if isLogin == false {
                VStack(spacing: 0) {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(.leading, 13)
                        
                        Spacer()
                        
//                        Button("testlogin") {
//                            isLogin = true
//                        }
                        
//                        Button {
//                            // 프로필 액션
//                        } label: {
//                            Image(systemName: "person.circle.fill")
//                                .font(.system(size: 28))
//                                .foregroundColor(.primary)
//                                .padding(.trailing, 16)
//                        }
                    }
                    .frame(height: 40)
                    .padding(.top, 60)
                    
                    TabView()
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    MainView()
}
