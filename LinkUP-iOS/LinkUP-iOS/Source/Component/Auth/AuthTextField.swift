//
//  AuthTextField.swift
//  LinkUP-iOS
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
                        .foregroundStyle(Color.appPrimaryText)
                        .padding(.horizontal, 16)
                } else {
                    TextField("", text: $bindingText, prompt: Text(placeholder).font(.semibold(16)).foregroundColor(.appPlaceholder))
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(Color.appPrimaryText)
                        .padding(.horizontal, 16)
                }
            }
            .foregroundStyle(Color.appSecondaryBackground)
            .frame(width: 330, height: 36)
            .shadow(radius: 1, x: 0.3, y: 1)
            .padding(0)
    }
}
