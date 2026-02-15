//
//  SignupViewModel.swift
//  dodum-iOS
//
//  Created by maple on 10/27/25.
//
import SwiftUI
import Combine
class SignupViewModel : ObservableObject{
    @Published var inputinfo: SignupModel = SignupModel(email: "", username: "", password: "")
    @Published var responsemessage = ""
    
    func signup() async throws {
        let signupdata = AuthRequest(email: inputinfo.email, username: inputinfo.username, password: inputinfo.password, code: nil)
        let response = try await AuthService.shared.signup(userInfo: signupdata)
        print(signupdata)
        
        responsemessage = response.data.message
    }
}
