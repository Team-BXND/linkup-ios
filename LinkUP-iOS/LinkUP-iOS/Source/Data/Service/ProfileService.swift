//
//  ProfileService.swift
//  LinkUP-iOS
//
//  Created by maple on 1/27/26.
//

import Moya
import Foundation
import Combine
class ProfileService {
    static let shared = ProfileService()
    private let provider = MoyaProvider<ProfileAPI>()
    
    private init() {}
    
    func fetchUserInfo() async throws -> ProfileResponse {
        let response = try await provider.request(target: .userInfo)
        return try ErrorThrowing(response)
    }
    
    func fetchUserActivity(type: Activity, page: Int) async throws -> UserActivity {
        
        let response = try await {
            switch type {
            case .Question:
                return try await provider.request(target: .myquestion(page: page))
            case .Answer:
                return try await provider.request(target: .myanswer(page: page))
            }
        }()
        
        return try ErrorThrowing(response)
        
    }
}

