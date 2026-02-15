//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct PWView: View {
    @State private var password = ""
    @Binding var step: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("Logo2")
            
            Text("비밀번호 찾기")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                AuthTextField(placeholder: "새 비밀번호를 입력하세요", bindingText: $password)
                
                
                AuthTextField(placeholder: "새 비밀번호를 다시 입력하세요", bindingText: $password, isSecure: true)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            
            VStack(spacing: 16) {
                AuthButton(shape: .fill, title: "비밀번호 변경") {
                    
                }

            }
            .padding(.horizontal, 32)
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var step = 1
    PWView(step: $step)
}
