//
//  RankingViewModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI
import Combine

class RankingViewModel: ObservableObject {
    @Published var rankings: [RankingModel] = []
    
    init() {
        loadSampleData()
    }
    
    var sortedRankings: [RankingModel] {
        rankings.sorted {
            if $0.point == $1.point {
                return $0.rank < $1.rank
            }
            return $0.point > $1.point
        }
    }
    
    private func loadSampleData() {
        rankings = [
            RankingModel(username: "이세계 유니콘", point: 50, rank: 1),
            RankingModel(username: "천재 베이시스트", point: 40, rank: 2),
            RankingModel(username: "밥스카이", point: 30, rank: 3),
            RankingModel(username: "정윤희", point: 28, rank: 4),
            RankingModel(username: "대두", point: 26, rank: 5),
            RankingModel(username: "빵따스카이", point: 25, rank: 6),
            RankingModel(username: "빵따스카이", point: 23, rank: 7),
            RankingModel(username: "빵따스카이", point: 22, rank: 8),
            RankingModel(username: "빵따스카이", point: 21, rank: 9),
            RankingModel(username: "빵따스카이", point: 18, rank: 10),
            RankingModel(username: "빵따스카이", point: 15, rank: 11)
        ]
    }

}
