//
//  ChangePWView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/11/26.
//

import SwiftUI

struct EmailView: View {
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("비밀번호 찾기")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                TextField("이메일을 입력하세요.", text: $email)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            
            VStack(spacing: 16) {
                Button("인증번호 발송") { }
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color("MainColor"))
                    .cornerRadius(10)
                
                Button("로그인 하기") { }
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
    EmailView()
}
