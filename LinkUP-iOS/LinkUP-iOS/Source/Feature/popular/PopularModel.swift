//
//  PopularModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/14/26.
//

import Foundation

struct PopularModel: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: Category
    let like: Int
    let preview: String
    let isAccepted: Bool
    let commentCount: Int
    let createdAt: Date
}
