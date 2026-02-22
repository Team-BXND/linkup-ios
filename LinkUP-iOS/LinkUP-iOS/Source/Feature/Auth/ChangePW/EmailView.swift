//
//  ChangePWView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/11/26.
//

import SwiftUI

struct EmailView: View {
    @State private var email = ""
    @EnvironmentObject var PWVM: PWViewModel
    @EnvironmentObject var nav: AuthNavigation
    
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("비밀번호 찾기")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                AuthTextField(placeholder: "이메일을 입력하세요", bindingText: $PWVM.changeinfo.email)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            VStack(spacing: 16) {
                AuthButton(shape: .fill, title: "인증번호 발송") {
                    Task {
                        try await PWVM.codesend()
                    }
                }
                AuthButton(shape: .empty, title: "로그인하기") {
                    nav.step = 0
                }
            }
            .padding(.horizontal, 32)
            Spacer()
        }
        .alert("오류", isPresented: $PWVM.showalert) {
            
        } message: {
            Text(PWVM.message)
        }
    }
}

//#Preview {
//    @Previewable @State var step = 1
//    EmailView()
//}
