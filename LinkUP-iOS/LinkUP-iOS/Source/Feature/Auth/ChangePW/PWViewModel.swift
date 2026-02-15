//
//  PWViewModel.swift
//  LinkUP-iOS
//
//  Created by maple on 2/13/26.
//

import Foundation
import Combine


class PWViewModel: Observable {
    
    @Published var changeinfo: AuthRequest = AuthRequest(email: "", username: "", password: "", code: 0)
    
    func codesend() async throws {
        do {
            let response = try await AuthService.shared.codesend(email: changeinfo.email)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func codecheck() async throws {
        do {
            let response = try await AuthService.shared.codecheck(verifyInfo: changeinfo)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pwhange () async throws {
        do {
            let response = try await AuthService.shared.pwchange(changeInfo: changeinfo)
        }
    }
}
