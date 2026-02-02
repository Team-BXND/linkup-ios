//
//  RankingResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct RankingResponse: ResponseProtocol {
    let data: [RankingInfo]
}

struct RankingInfo: ResponseProtocol {
    let username: String
    let point: Int
    let rank: Int
}
