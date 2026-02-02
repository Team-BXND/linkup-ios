//
//  UpdatePostRequest.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/29/26.
//

import Foundation

struct UpdatePostRequest: Codable {
    let category: String
    let title: String
    let content: String
}
