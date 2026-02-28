import SwiftUI
import Combine

class SignupViewModel: ObservableObject {
    @Published var inputinfo: SignupModel = SignupModel(email: "", username: "", password: "")
    @Published var showalert = false
    @Published var signupError: SignupErrorType?
    @Published var successMessage: String?

    func signup() async {
        // 1. 클라이언트 측 검증 (빈칸)
        if inputinfo.email.isEmpty || inputinfo.username.isEmpty || inputinfo.password.isEmpty {
            self.signupError = .emptyinfo
            self.showalert = true
            return
        }
        
        let signupdata = AuthRequest(email: inputinfo.email, username: inputinfo.username, password: inputinfo.password, code: nil)
        
        do {
            let response = try await AuthService.shared.signup(userInfo: signupdata)
            // 201 성공 처리
            await MainActor.run {
                self.successMessage = "회원가입이 완료되었습니다."
                self.signupError = nil
                self.showalert = true
            }
        } catch let error as ErrorType {
            await MainActor.run {
                self.successMessage = nil
                
                switch error {
                case .invalidRequest(let apiResponse):
                    // JSON 데이터 내 "email" 키가 있는지 확인
                    let msg = apiResponse.data
                    if (msg.email != nil)  {
                        self.signupError = .invalidemail
                    } else if msg.message?.contains("비밀번호") ?? false {
                        self.signupError = .invalidpassword
                    } else {
                        self.signupError = .emptyinfo
                    }
                    
                case .duplicatedUser(let apiResponse):
                    let msg = apiResponse.data.message
                    if msg!.contains("이메일") {
                        self.signupError = .duplicateemail
                    } else if msg!.contains("닉네임") {
                        self.signupError = .duplicateusername
                    }
                    
                default:
                    self.signupError = nil // 알 수 없는 오류는 message 섹션에서 처리
                }
                self.showalert = true
            }
        } catch {
            await MainActor.run {
                self.signupError = nil
                self.showalert = true
            }
        }
    }
}
