//
//  PostResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct PostsResponse: ResponseProtocol {
    let status: Int                 // ✅ status 추가
    let data: [PostListItem]
    let meta: PageMeta
}

struct PostListItem: ResponseProtocol {
    let id: Int
    let title: String
    let author: String
    let category: Category
    let like: Int
    let preview: String
    let isAccepted: Bool
    let commentCount: Int
    let createdAt: String
}

struct PageMeta: ResponseProtocol {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool

    // ✅ 서버 응답 필드명과 맞추기 (PopularMetaInfo와 동일 구조)
    enum CodingKeys: String, CodingKey {
        case total       = "totalElements"
        case page        = "currentPage"
        case pageSize
        case totalPages
        case hasNext
        case hasPrevious
    }
}
