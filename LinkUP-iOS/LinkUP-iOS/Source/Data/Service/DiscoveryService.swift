//
//  DiscoveryService.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 2/3/26.
//

import Foundation
import Combine
import Moya

class DiscoveryService {
    static let shared = DiscoveryService()
    private let provider = MoyaProvider<DiscoveryAPI>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    enum PopularType {
        case popular
        case popularhot
    }

    func fetchPopular(type: PopularType, page: Int) async throws -> PopularResponse {
        let response = try await {
            switch type {
            case .popular:
                return try await provider.request(target: .popular(page: page))
            case .popularhot:
                return try await provider.request(target: .popularhot(page: page))
            }
        }()
        
        return try response
            .filterSuccessfulStatusCodes()
            .map(PopularResponse.self)
    }

    func fetchRanking() async throws -> RankingResponse {
        let response = try await provider.request(target: .ranking)
        return try response
            .filterSuccessfulStatusCodes()
            .map(RankingResponse.self)
    }
}
