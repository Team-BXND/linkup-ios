//
//  PostResponse.swift
//  LinkUP-iOS
//
import Foundation

struct PostsResponse: ResponseProtocol {
    let status: Int
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

    enum CodingKeys: String, CodingKey {
        case total       = "totalElements"
        case page        = "currentPage"
        case pageSize
        case totalPages
        case hasNext
        case hasPrevious
    }
}
