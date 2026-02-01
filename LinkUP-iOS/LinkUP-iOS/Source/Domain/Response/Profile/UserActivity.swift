//
//  UserActivity.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct UserActivity: ResponseProtocol {
    let data: [Info]
    let meta: Meta
}

struct Info: ResponseProtocol {
    // 공통
    let id: Int
    let title: String
    let preview: String
    let category: Category
    
    // 답변
    let answer: String?
    
    // 질문
    let like: Int?
    let commentCount: Int?
    let isAccepted: Bool?
    let page: Int?
}

