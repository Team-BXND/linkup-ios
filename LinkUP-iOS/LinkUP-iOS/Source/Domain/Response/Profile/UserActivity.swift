//
//  UserActivity.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct UserActivity: ResponseProtocol {
    let data: [Info]
    let meta: PageMeta
}

struct Info: ResponseProtocol {
    let id: Int
    let title: String
    let preview: String
    let category: Category
    let answer: String
}

