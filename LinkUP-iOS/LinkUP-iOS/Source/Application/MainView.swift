import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(.leading, 13)
                        
                        Spacer()
                        
                        NavigationLink(destination: LoginView()) {
                            Text("TestLogin")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                                .padding(.trailing, 13)
                        }
                    }
                    .frame(height: 40)
                    .padding(.top, 60)
                    
                    Tabbar()
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    MainView()
}
