//
//  AuthService.swift
//  LinkUP-iOS
//
//  Created by maple on 1/24/26.
//

import Foundation
import Moya

class AuthService {
    var provider = MoyaProvider<AuthAPI>()
    
    static var shared = AuthService()
    
    private init() {}
    
    func signup(userInfo: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .signup(userInfo: userInfo))
        
        
        return try ErrorThrowing(response)
    }
    
    func signin(loginInfo: AuthRequest) async throws -> TokenResponse {
        let response = try await provider.request(target: .signin(loginInfo: loginInfo))
        
        return try ErrorThrowing(response)
    }
    
    func codesend(email: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .codesend(email: email))
        
        return try ErrorThrowing(response)
    }
    
    func codecheck(verifyInfo: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .verify(verifyInfo: verifyInfo))
        
        return try ErrorThrowing(response)
    }
    
    func pwchange(changeInfo: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .change(change: changeInfo))
        
        return try ErrorThrowing(response)
    }
    
    func refresh(refresh: String) async throws -> TokenResponse {
        let response = try await provider.request(target: .refresh(refresh: refresh))
        
        return try ErrorThrowing(response)
    }
}
