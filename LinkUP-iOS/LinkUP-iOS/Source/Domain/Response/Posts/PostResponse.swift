//
//  PostResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct PostsResponse: Codable {
    let data: [PostListItem]
    let meta: PageMeta
}

struct PostListItem: Codable {
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

struct PageMeta: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool
}
