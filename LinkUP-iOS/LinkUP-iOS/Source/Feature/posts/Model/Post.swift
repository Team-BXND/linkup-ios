//
//  Post.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/29/26.
//

import Foundation

struct Post: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: Category
    let like: Int
    let createdAt: String
    let isAccepted: Bool
    let preview: String
    let commentCount: Int
    
    // 상세 조회 시 추가 정보
    var content: String?
    var isLike: Bool?
    var isAuthor: Bool?
    var comments: [Comment]?
    
    // PostListItem으로부터 생성
    init(from listItem: PostListItem) {
        self.id = listItem.id
        self.title = listItem.title
        self.author = listItem.author
        self.category = listItem.category
        self.like = listItem.like
        self.createdAt = listItem.createdAt
        self.isAccepted = listItem.isAccepted
        self.preview = listItem.preview
        self.commentCount = listItem.commentCount
    }
    
    // PostDetail로부터 생성
    init(id: Int, from detail: PostDetail) {
        self.id = id
        self.title = detail.title
        self.author = detail.author
        self.category = detail.category
        self.like = detail.like
        self.createdAt = detail.createdAt
        self.isAccepted = detail.isAccepted
        self.preview = String(detail.content.prefix(50)) + "..."
        self.commentCount = detail.comment.count
        self.content = detail.content
        self.isLike = detail.isLike
        self.isAuthor = detail.isAuthor
        self.comments = detail.comment.map { Comment(from: $0) }
    }
    
    // 샘플 데이터용 생성자
    init(
        id: Int,
        title: String,
        author: String,
        category: Category,
        like: Int,
        createdAt: String,
        isAccepted: Bool,
        preview: String,
        commentCount: Int,
        content: String? = nil,
        isLike: Bool? = nil,
        isAuthor: Bool? = nil,
        comments: [Comment]? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.category = category
        self.like = like
        self.createdAt = createdAt
        self.isAccepted = isAccepted
        self.preview = preview
        self.commentCount = commentCount
        self.content = content
        self.isLike = isLike
        self.isAuthor = isAuthor
        self.comments = comments
    }
}
