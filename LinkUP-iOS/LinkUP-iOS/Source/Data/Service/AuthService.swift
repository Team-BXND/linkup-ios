//
//  AuthService.swift
//  LinkUP-iOS
//
//  Created by maple on 1/24/26.
//

import Foundation
import Moya

struct AuthService {
    var provider = MoyaProvider<AuthAPI>()
}
