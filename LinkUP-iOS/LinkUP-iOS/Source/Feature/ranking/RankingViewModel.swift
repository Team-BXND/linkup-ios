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
    
    init() {
        loadSampleData()
    }
    
    private var sortedRankings: [RankingInfo] {
        rankings.data.sorted {
            if $0.point == $1.point {
                return $0.rank < $1.rank
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
    
    private func loadSampleData() {
        rankings = RankingResponse(
            data: [
                RankingInfo(username: "이세계 유니콘", point: 50, rank: 1),
                RankingInfo(username: "천재 베이시스트", point: 40, rank: 2),
                RankingInfo(username: "밥스카이", point: 30, rank: 3),
                RankingInfo(username: "정윤희", point: 28, rank: 4),
            ]
        )
    }
}
