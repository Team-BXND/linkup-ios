//
//  AuthTextField.swift
//  LinkUP-iOS
//
import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var bindingText: String
    var isSecure = false
    @State private var ishidden = true

    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .overlay {
                if isSecure {
                    HStack {
                        if ishidden {
                            SecureField(placeholder, text: $bindingText, prompt: Text(placeholder).font(.semibold(16)).foregroundColor(.appPlaceholder))
                                .foregroundStyle(Color.appPrimaryText)
                                .padding(.horizontal, 16)
                        } else {
                            TextField("", text: $bindingText, prompt: Text(placeholder).font(.semibold(16)).foregroundColor(.appPlaceholder))
                                .textInputAutocapitalization(.never)
                                .foregroundStyle(Color.appPrimaryText)
                                .padding(.horizontal, 16)
                        }
                        Button {
                            ishidden.toggle()
                        } label: {
                            Image(systemName: ishidden ? "eye" : "eye.slash")
                                .foregroundColor(.black)
                        }
                    }
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
