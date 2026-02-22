//
//  AuthRequest.swift
//  LinkUP-iOS
//
//  Created by maple on 1/25/26.
//

import Foundation

struct AuthRequest: RequestProtocol {
    var email: String
    var username: String?
    var password: String?
    var code: Int?
    
    init(email: String, username: String?, password: String?, code: Int?) {
        self.email = email
        self.username = username
        self.password = password
        self.code = code
    }
    
}
