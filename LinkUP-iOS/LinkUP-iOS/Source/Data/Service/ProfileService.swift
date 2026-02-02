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
    private let provider = MoyaProvider<ProfileAPI>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    func fetchUserInfo() async throws -> UserInfo {
        let response = try await provider.request(target: .userInfo)
        
        let filteredResponse = try response.filterSuccessfulStatusCodes()
        
        return try filteredResponse.map(UserInfo.self)
    }
    
    func fetchUserActivity(Activity: Activity, page: Int) async throws -> UserActivity {
        
        let response = try await {
            switch Activity {
            case .Question:
                return try await provider.request(target: .myquestion(page: page))
            case .Answer:
                return try await provider.request(target: .myanswer(page: page))
            }
        }()

        return try response.filterSuccessfulStatusCodes().map(UserActivity.self)
        
    }
}

