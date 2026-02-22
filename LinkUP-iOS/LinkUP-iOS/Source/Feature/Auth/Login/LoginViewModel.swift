//
//  SignupViewModel.swift
//  dodum-iOS
//
//  Created by maple on 10/27/25.
//
import SwiftUI
import Combine
class LoginViewModel : ObservableObject{
    @Published var loginInfo: LoginModel = LoginModel(email: "", password: "")
    @Published var isfailed = false
    @Published var errormessage = ""
    
    func login() async throws {
        let logindata = AuthRequest(email: loginInfo.email,username: nil, password: loginInfo.password, code: nil)
        print(logindata)
        do {
            let response = try await AuthService.shared.signin(loginInfo: logindata)
            UserDefaults.standard.set(response.data.accessToken, forKey: "access")
            UserDefaults.standard.set(response.data.refreshToken, forKey: "refresh")
            print(response)
        } catch {
            isfailed = true
            
            print(error.localizedDescription)
            
        }
    }
    
}
