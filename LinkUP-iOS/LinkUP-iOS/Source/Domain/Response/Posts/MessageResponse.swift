//
//  MessageResponse.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/29/26.
//

import Foundation

struct MessageResponse: Codable {
    let data: MessageData
}

struct MessageData: Codable {
    let message: String
}
