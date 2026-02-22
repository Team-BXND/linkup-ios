//
//  LoginView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct PWView: View {
    @State private var password = ""
    @State private var passwordck = ""
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
                AuthTextField(placeholder: "새 비밀번호를 입력하세요", bindingText: $password, isSecure: true)
                
                AuthTextField(placeholder: "새 비밀번호를 다시 입력하세요", bindingText: $passwordck, isSecure: true)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            VStack(spacing: 16) {
                AuthButton(shape: .fill, title: "비밀번호 변경") {
                    Task {
                        if password == passwordck {
                            PWVM.changeinfo.password = password
                            try await PWVM.pwchange()
                        } else {
                            PWVM.message = "비밀번호가 일치하지 않습니다."
                            PWVM.showalert = true
                        }
                    }
                }
                .alert("오류", isPresented: $PWVM.showalert) {
                    
                } message: {
                    Text(PWVM.message)
                }
                .alert("완료", isPresented: $PWVM.goodalert) {
                    Button ("확인"){
                        nav.step = 0
                    }
                    
                } message: {
                    Text("비밀번호가 변경되었습니다.")
                }

            }
            .padding(.horizontal, 32)
            Spacer()
        }
        

    }
}


