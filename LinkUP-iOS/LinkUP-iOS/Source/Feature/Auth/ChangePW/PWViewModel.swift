//
//  PWViewModel.swift
//  LinkUP-iOS
//
//  Created by maple on 2/13/26.
//

import Foundation
import Combine


class PWViewModel: ObservableObject {
    @Published var changeinfo: AuthRequest = AuthRequest(email: "", username: "", password: "", code: 0)
    @Published var showalert = false
    @Published var goodalert = false
    @Published var message = ""
    
    var nav: AuthNavigation?
    
    func codesend() async throws {
        do {
            let response = try await AuthService.shared.codesend(email: changeinfo)
            nav?.step = 3
            
        } catch let error as ErrorType{
            message = ErrorMessage(error: error)
            showalert = true
        }
    }
    
    func codecheck() async throws {
        do {
            let response = try await AuthService.shared.codecheck(verifyInfo: changeinfo)
            nav?.step = 4
        } catch let error as ErrorType{
            message = ErrorMessage(error: error)
            showalert = true
        }
    }
    
    func pwchange () async throws {
        do {
            let response = try await AuthService.shared.pwchange(changeInfo: changeinfo)
            goodalert = true
        } catch let error as ErrorType {
            showalert = true
            message = ErrorMessage(error: error)
        }
    }
}
