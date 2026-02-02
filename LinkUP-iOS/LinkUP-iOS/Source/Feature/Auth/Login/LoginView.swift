//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("로그인")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                TextField("이메일을 입력하세요.", text: $email)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                
                SecureField("비밀번호를 입력하세요.", text: $password)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                HStack {
                    Spacer()
                    Button("비밀번호를 잊으셨나요?") { }
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            
            VStack(spacing: 16) {
                Button("로그인 하기") { }
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color("MainColor"))
                    .cornerRadius(10)
                
                Button("회원가입 하기") { }
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("MainColor"))
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("MainColor"), lineWidth: 1))
            }
            .padding(.horizontal, 32)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
