//
//  PopularResponse.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/14/26.
//

import Foundation

struct PopularResponse: ResponseProtocol {
    let data: [PopularDataInfo]
    let meta: PopularMetaInfo
}

struct PopularDataInfo: ResponseProtocol, Identifiable, Hashable {
    let id: Int
    let title: String
    let author: String
    let category: Category
    let like: Int
    let preview: String
    let isAccepted: Bool
    let commentCount: Int
    let createdAt: Date
}

struct PopularMetaInfo: ResponseProtocol {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool
}
