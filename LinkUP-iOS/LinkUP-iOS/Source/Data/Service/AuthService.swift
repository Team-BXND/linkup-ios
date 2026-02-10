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
        
        return try response.filterSuccessfulStatusCodes().map(APIResponse.self)
    }
    
    func signin(loginInfo: AuthRequest) async throws -> TokenResponse {
        let response = try await provider.request(target: .signin(loginInfo: loginInfo))
        
        return try response.filterSuccessfulStatusCodes().map(TokenResponse.self)
    }
    
    func codesend(email: String) async throws -> APIResponse {
        let response = try await provider.request(target: .codesend(email: email))
        
        
        return try response.filterSuccessfulStatusCodes().map(APIResponse.self)
    }
    
    func codecheck(verifyInfo: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .verify(verifyInfo: verifyInfo))
        
        return try response.filterSuccessfulStatusCodes().map(APIResponse.self)
    }
    
    func pwchange(changeInfo: AuthRequest) async throws -> APIResponse {
        let response = try await provider.request(target: .change(change: changeInfo))
        
        return try response.filterSuccessfulStatusCodes().map(APIResponse.self)
    }
    
    func refresh(refresh: String) async throws -> TokenResponse {
        let response = try await provider.request(target: .refresh(refresh: refresh))
        
        return try response.filterSuccessfulStatusCodes().map(TokenResponse.self)
    }
}
