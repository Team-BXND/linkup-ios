//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var VM = SignupViewModel()
    @Binding var step: Int
    @State private var pswdcheck = ""
    
    var body: some View {
        VStack{
            Image("Logo2")
                .padding(.top, 192)
            
            Text("회원가입")
                .font(.semibold(40))
                .padding(.top, 4)
                .padding(.bottom, 64)
            
            VStack(spacing: 12) {
                AuthTextField(placeholder: "이메일을 입력하세요", bindingText: $VM.inputinfo.email)
                
                AuthTextField(placeholder: "닉네임을 입력하세요", bindingText: $VM.inputinfo.username)
                
                AuthTextField(placeholder: "비밀번호를 입력하세요", bindingText: $VM.inputinfo.password, isSecure: true)
                
                AuthTextField(placeholder: "비밀번호를 다시 입력하세요", bindingText: $pswdcheck, isSecure: true)
                    .padding(.bottom, 32)
                
                AuthButton(shape: .fill, title: "회원가입") {
                    Task {
                        if VM.inputinfo.password == pswdcheck {
                            try await VM.signup()
                        } else {
                            
                        }
                    }
                }
                AuthButton(shape: .empty, title: "로그인하기") {
                    step = 2
                }
            }
        }
        .padding(.bottom, 192)
    }
}

#Preview {
    @Previewable @State var yaho = 1
    SignupView( step: $yaho)
}
