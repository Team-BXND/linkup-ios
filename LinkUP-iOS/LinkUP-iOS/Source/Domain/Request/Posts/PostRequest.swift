//
//  PatchModel.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct PostingModel: RequestProtocol {
    let category: Category
    let title: String
    let content: String
    let author: String?
}
