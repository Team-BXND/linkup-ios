//
//  test.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 12/30/25.
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var bindingText: String
    var isSecure = false
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .overlay {
                if isSecure {
                    SecureField(placeholder, text: $bindingText)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 16)
                    
                } else {
                    TextField("", text: $bindingText, prompt: Text(placeholder).font(.semibold(16)))
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 16)
                }
            }
            .foregroundStyle(.white)
            .frame(width: 330, height: 36)
            .shadow(radius: 1, x: 0.3, y: 1)
    }
}

