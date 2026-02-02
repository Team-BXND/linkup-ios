//
//  PatchModel.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct CreatePostRequest: Codable {
    let category: String
    let title: String
    let content: String
    let author: String
}
