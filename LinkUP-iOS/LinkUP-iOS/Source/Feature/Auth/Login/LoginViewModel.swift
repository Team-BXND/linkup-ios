//
//  SignupViewModel.swift
//  dodum-iOS
//
//  Created by maple on 10/27/25.
//
import SwiftUI
import Combine
class LoginViewModel : ObservableObject{
    @Published var loginInfo: LoginModel = LoginModel(email: "a@b.c", password: "qqqqqq1!")
    @Published var isfailed = false
    @Published var errormessage = ""
    var authManager: AuthManager?
    
    func login() async throws {
        let logindata = AuthRequest(email: loginInfo.email,username: nil, password: loginInfo.password, code: nil)
        do {
            let response = try await AuthService.shared.signin(loginInfo: logindata)
            UserDefaults.standard.set(response.data.accessToken, forKey: "access")
            UserDefaults.standard.set(response.data.refreshToken, forKey: "refresh")
            authManager?.isLogin = true
        } catch {
            isfailed = true
            
            
        }
    }
    
    func logout() {
        authManager?.isLogin = false
        UserDefaults.standard.removeObject(forKey: "access")
        UserDefaults.standard.removeObject(forKey: "refresh")
        
    }
    
}
