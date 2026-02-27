import SwiftUI

struct SignupView: View {
    @StateObject var VM = SignupViewModel()
    @EnvironmentObject var nav: AuthNavigation
    @State private var pswdcheck = ""
    
    var body: some View {
        VStack {
            Image("Logo2")
                .padding(.top, 100)
            
            Text("회원가입")
                .font(.system(size: 40, weight: .semibold))
                .padding(.top, 4)
                .padding(.bottom, 40)
            
            VStack(spacing: 12) {
                AuthTextField(placeholder: "이메일을 입력하세요", bindingText: $VM.inputinfo.email)
                AuthTextField(placeholder: "닉네임을 입력하세요", bindingText: $VM.inputinfo.username)
                AuthTextField(placeholder: "비밀번호를 입력하세요", bindingText: $VM.inputinfo.password, isSecure: true)
                AuthTextField(placeholder: "비밀번호를 다시 입력하세요", bindingText: $pswdcheck, isSecure: true)
                
                AuthButton(shape: .fill, title: "회원가입") {
                    // 클라이언트 측 유효성 검사 (비밀번호 일치 여부)
                    if VM.inputinfo.password != pswdcheck {
                        VM.signupError = .notduplicatepassword
                        VM.showalert = true
                    } else {
                        Task {
                            await VM.signup()
                        }
                    }
                }
                .padding(.top, 20)
                
                AuthButton(shape: .empty, title: "로그인하기") {
                    nav.step = 0
                }
            }
            .padding(.horizontal, 20)
        }
        .alert("알림", isPresented: $VM.showalert) {
            Button("확인") {
                if VM.successMessage != nil {
                    nav.step = 0 // 성공 시에만 로그인 화면으로 전환
                }
            }
        } message: {
            // 1순위: 정의된 에러 타입 메시지
            if let error = VM.signupError {
                Text(error.errortext)
            }
            // 2순위: 성공 메시지
            else if let success = VM.successMessage {
                Text(success)
            }
            // 3순위: 기타 예외 상황
            else {
                Text("네트워크 연결이 원활하지 않거나\n서버 오류가 발생했습니다.")
            }
        }
    }
}
