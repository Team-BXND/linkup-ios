//
//  UserInfo.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct UserInfo: ResponseProtocol {
    let username: String
    let email: String
    let point: Int
    let ranking: Int
}

struct ProfileResponse: ResponseProtocol {
    let data: UserInfo
}
