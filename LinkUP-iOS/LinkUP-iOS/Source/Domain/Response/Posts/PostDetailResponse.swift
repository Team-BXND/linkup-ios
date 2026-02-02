//
//  PostDetailResponse.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/29/26.
//

import Foundation

struct PostDetailResponse: Codable {
    let data: PostDetail
}

struct PostDetail: Codable {
    let title: String
    let author: String
    let category: Category
    let content: String
    let like: Int
    let createdAt: String
    let isAccepted: Bool
    let isLike: Bool
    let isAuthor: Bool
    let comment: [CommentItem]
}

struct CommentItem: Codable {
    let commentId: Int
    let author: String
    let content: String
    let isAccepted: Bool
    let createdAt: String
}
