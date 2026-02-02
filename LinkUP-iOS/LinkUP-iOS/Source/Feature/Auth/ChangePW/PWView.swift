//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct PWView: View {
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("비밀번호 찾기")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                TextField("새 비밀번호를 입력하세요", text: $password)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                
                SecureField("새 비밀번호를 다시 입력하세요.", text: $password)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            
            VStack(spacing: 16) {
                Button("비밀번호 변경") { }
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color("MainColor"))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 32)
            Spacer()
        }
    }
}

#Preview {
    PWView()
}
