//
//  PostResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation


struct PostModel: ResponseProtocol {
    let data: [Data]
    let meta: Meta
}

struct Data: ResponseProtocol {
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

struct Meta: ResponseProtocol {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool
}
