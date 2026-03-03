//
//  RankingViewModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI
import Combine

class RankingViewModel: ObservableObject {
    
    @Published var rankings: RankingResponse = RankingResponse(data: [])
    
    private let service = DiscoveryService.shared
    
    private var sortedRankings: [RankingInfo] {
        rankings.data.sorted {
            if $0.point == $1.point {
                return $0.username < $1.username
            }
            return $0.point > $1.point
        }
    }
    
    var topRankings: [RankingInfo] {
        Array(sortedRankings.prefix(3))
    }
    
    var rowRankings: [RankingInfo] {
        Array(sortedRankings.dropFirst(3))
    }
    
    func fetchRanking() {
        Task {
            do {
                let response = try await service.fetchRanking()
                self.rankings = response
            } catch {
            }
        }
    }
}
