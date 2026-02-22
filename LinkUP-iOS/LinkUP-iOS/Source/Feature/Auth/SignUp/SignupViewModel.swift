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
    @Published var showalert = false
    @Published var message = ""
    var signupError: SignupErrorType?
    
    func signup() async throws {
        let signupdata = AuthRequest(email: inputinfo.email, username: inputinfo.username, password: inputinfo.password, code: nil)
        do {
            let response = try await AuthService.shared.signup(userInfo: signupdata)
            message = response.data.message
        } catch let error as ErrorType {
            switch ErrorMessage(error: error) {
            case "이미 사용 중인 이메일입니다.": signupError = .duplicateemail
            case "이미 사용 중인 닉네임입니다.": signupError = .duplicateusername
            case "비밀번호 형식이 맞지 않습니다.": signupError = .invalidpassword
            default: "얘 nil임"
            }
            
            showalert = true
            
        }
        print(signupdata)
        
        
    }
}
