//
//  additionInfoView.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import SwiftUI

struct UserActivityView: View {
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 330, height: 660)
                .foregroundStyle(.white)
                .shadow(radius: 3)
                .overlay {
                    VStack {
                        HStack {
                            Text("내 답변")
                                .font(.bold(20))
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        ScrollView(showsIndicators: false) {
                                VStack{
                                    ForEach(0..<20) { item in
                                        ProfileAnsItem()
                                }
                            }
                        }
                    }
                    .padding(.horizontal,16)
                    .padding(.top, 16)
                }
        }
        
    }
}

#Preview {
    UserActivityView()
}
