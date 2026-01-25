//
//  AuthRequest.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct AuthRequest: RequestProtocol {
    let email: String
    let username: String?
    let password: String?
    let code: Int?
    
}
