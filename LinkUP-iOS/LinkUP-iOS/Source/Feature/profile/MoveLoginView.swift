//
//  MoveLoginView.swift
//  LinkUP-iOS
//
//  Created by maple on 2/27/26.
//

import Foundation
import SwiftUI

struct MoveLoginView: View {
    @State var ispresent = false
    @State var a = 0
    var body: some View {
        NavigationStack {
            VStack {
                Text("로그인이 필요합니다.")
                    .font(.semibold(32))
                    .padding(.bottom, 8)
                Text("로그인을 하고 더 많은 기능을 사용하세요")
                    .font(.semibold(20))
                    .foregroundStyle(.gray)
                    .padding(.bottom, 64)
                
                AuthButton(shape: .fill, title: "로그인하기") {
                    ispresent = true
                    a = 0
                }
                .padding(.bottom, 16)
                
                AuthButton(shape: .empty, title: "회원가입하기" ) {
                    ispresent = true
                    a = 1
                }
            }
            .navigationDestination(isPresented: $ispresent) {
                AuthView(a: a)
            }
        }
    }
}

#Preview {
    MoveLoginView()
}
