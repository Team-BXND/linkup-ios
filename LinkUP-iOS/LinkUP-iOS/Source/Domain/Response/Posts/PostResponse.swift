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

    // 서버 엔드포인트마다 키 이름이 달라 두 경우 모두 처리
    // - 글 목록: totalElements, currentPage
    // - 프로필 활동: total, page
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        // Decode total with support for both keys without throwing in the RHS of ??
        if let t = try c.decodeIfPresent(Int.self, forKey: .total) {
            total = t
        } else if let t2 = try c.decodeIfPresent(Int.self, forKey: .totalElements) {
            total = t2
        } else {
            throw DecodingError.keyNotFound(CodingKeys.total, DecodingError.Context(codingPath: c.codingPath, debugDescription: "Missing both 'total' and 'totalElements'"))
        }

        // Decode page with support for both keys
        if let p = try c.decodeIfPresent(Int.self, forKey: .page) {
            page = p
        } else if let p2 = try c.decodeIfPresent(Int.self, forKey: .currentPage) {
            page = p2
        } else {
            throw DecodingError.keyNotFound(CodingKeys.page, DecodingError.Context(codingPath: c.codingPath, debugDescription: "Missing both 'page' and 'currentPage'"))
        }

        pageSize   = try c.decode(Int.self, forKey: .pageSize)
        totalPages = try c.decode(Int.self, forKey: .totalPages)
        hasNext    = try c.decode(Bool.self, forKey: .hasNext)
        hasPrevious = try c.decode(Bool.self, forKey: .hasPrevious)
    }

    init(total: Int, page: Int, pageSize: Int, totalPages: Int, hasNext: Bool, hasPrevious: Bool) {
        self.total = total; self.page = page; self.pageSize = pageSize
        self.totalPages = totalPages; self.hasNext = hasNext; self.hasPrevious = hasPrevious
    }

    enum CodingKeys: String, CodingKey {
        case total, totalElements
        case page, currentPage
        case pageSize, totalPages, hasNext, hasPrevious
    }
}
