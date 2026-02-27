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
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
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
