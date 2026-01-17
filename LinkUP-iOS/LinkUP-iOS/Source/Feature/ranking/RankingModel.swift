//
//  RankingModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import Foundation

struct RankingModel: Identifiable {
    var id: Int { rank }
    let username: String
    let point: Int
    let rank: Int
}
