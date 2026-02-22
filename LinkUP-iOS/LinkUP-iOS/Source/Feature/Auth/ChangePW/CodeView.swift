//
//  ChangePWView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/11/26.
//

import SwiftUI

struct CodeView: View {
    @State private var code = ""
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
                AuthTextField(placeholder: "인증번호를 입력하세요", bindingText: $code)
                    .keyboardType(.numberPad)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            
            VStack(spacing: 16) {
                AuthButton(shape: .fill, title: "인증번호 확인") {
                    Task {
                        if code.isEmpty {
                            PWVM.message = "인증번호를 입력하세요"
                            PWVM.showalert = true
                        } else {
                            PWVM.changeinfo.code = Int(code)
                            try await PWVM.codecheck()
                        }
                    }
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


