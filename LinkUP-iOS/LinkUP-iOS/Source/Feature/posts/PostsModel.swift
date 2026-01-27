//
//  PostsModel.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/12/26.
//

import Foundation

enum Category: String, CaseIterable, Identifiable, Codable {
    case school = "학교생활"
    case code = "코드"
    case project = "프로젝트"
    
    var id: String { self.rawValue }
    
    // API 요청용 값
    var apiValue: String {
        switch self {
        case .school: return "school"
        case .code: return "code"
        case .project: return "project"
        }
    }
}

// MARK: - 게시글 모델
struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let author: String
    let category: Category
    let like: Int
    let createdAt: String
    let isAccepted: Bool
    
    // 목록 조회에서만 사용
    let preview: String?
    let commentCount: Int?
    
    // 상세 조회에서만 사용
    let content: String?
    let isLike: Bool?
    let isAuthor: Bool?
    let comments: [Comment]?
}

// MARK: - 댓글(답변) 모델
struct Comment: Identifiable, Codable {
    let commentId: Int
    let author: String
    let content: String
    let isAccepted: Bool
    let createdAt: String
    
    var id: Int { commentId }
}

// MARK: - API 응답 모델
struct PostsResponse: Codable {
    let data: [Post]
    let meta: PageMeta
}

struct PageMeta: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool
}

struct PostDetailResponse: Codable {
    let data: Post
}

struct MessageResponse: Codable {
    let data: MessageData
}

struct MessageData: Codable {
    let message: String
}
