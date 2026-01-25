//
//  MessageResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct APIResponse: ResponseProtocol {
    let data: Message
    
    struct Message: ResponseProtocol {
        let message: String
    }
}
