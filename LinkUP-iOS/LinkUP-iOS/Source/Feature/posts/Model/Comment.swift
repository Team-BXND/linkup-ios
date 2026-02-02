//
//  Comment.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/29/26.
//

import Foundation

struct Comment: Identifiable {
    let id: Int
    let author: String
    let content: String
    let isAccepted: Bool
    let createdAt: String
    
    // CommentItem으로부터 생성
    init(from item: CommentItem) {
        self.id = item.commentId
        self.author = item.author
        self.content = item.content
        self.isAccepted = item.isAccepted
        self.createdAt = item.createdAt
    }
    
    // 샘플 데이터용 생성자
    init(
        id: Int,
        author: String,
        content: String,
        isAccepted: Bool,
        createdAt: String
    ) {
        self.id = id
        self.author = author
        self.content = content
        self.isAccepted = isAccepted
        self.createdAt = createdAt
    }
}
