//
//  RankingViewModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI
import Combine

class RankingViewModel: ObservableObject {
    @Published var rankings: [RankingResponse] = []
    
    init() {
        loadSampleData()
    }
    
    var sortedRankings: [RankingResponse] {
        rankings.sorted {
            if $0.point == $1.point {
                return $0.rank < $1.rank
            }
            return $0.point > $1.point
        }
    }
    
    private func loadSampleData() {
        rankings = [
            RankingResponse(username: "이세계 유니콘", point: 50, rank: 1),
            RankingResponse(username: "천재 베이시스트", point: 40, rank: 2),
            RankingResponse(username: "밥스카이", point: 30, rank: 3),
            RankingResponse(username: "정윤희", point: 28, rank: 4),
            RankingResponse(username: "대두", point: 26, rank: 5),
            RankingResponse(username: "빵따스카이", point: 25, rank: 6),
            RankingResponse(username: "빵따스카이", point: 23, rank: 7),
            RankingResponse(username: "빵따스카이", point: 22, rank: 8),
            RankingResponse(username: "빵따스카이", point: 21, rank: 9),
            RankingResponse(username: "빵따스카이", point: 18, rank: 10),
            RankingResponse(username: "빵따스카이", point: 15, rank: 11),
            RankingResponse(username: "빵따스카이", point: 14, rank: 12),
            RankingResponse(username: "빵따스카이", point: 14, rank: 13),
            RankingResponse(username: "빵따스카이", point: 10, rank: 14),
            RankingResponse(username: "빵따스카이", point: 7, rank: 15)
        ]
    }
}
