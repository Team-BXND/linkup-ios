//
//  AuthResponse.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct TokenResponse: ResponseProtocol {
    let data: Token
}

struct Token: ResponseProtocol {
    let accessToken: String
    let responesToken: String
}
