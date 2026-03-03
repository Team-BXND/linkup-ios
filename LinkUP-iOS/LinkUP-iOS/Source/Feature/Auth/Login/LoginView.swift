//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var VM = LoginViewModel()
    @EnvironmentObject private var nav: AuthNavigation
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("로그인")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                AuthTextField(placeholder: "이메일을 입력하세요", bindingText: $VM.loginInfo.email)
                
                AuthTextField(placeholder: "비밀번호를 입력하세요", bindingText: $VM.loginInfo.password, isSecure: true)
                
                HStack {
                    Spacer()
                    Button("비밀번호를 잊으셨나요?") {
                        nav.step = 2
                    }
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            
            VStack(spacing: 16) {
                
                AuthButton(shape: .fill, title: "로그인") {
                    Task {
                        try await VM.login()
                        if authManager.isLogin == true {
                            dismiss()
                        }
                    }
                }
                
                AuthButton(shape: .empty, title: "회원가입 하기") {
                    nav.step = 1
                }
            }
            .padding(.horizontal, 32)
            Spacer()
        }
        .onAppear {
            VM.authManager = authManager
        }
    }
}

#Preview {
    LoginView()
}
