//
//  ProfileService.swift
//  LinkUP-iOS
//
//  Created by maple on 1/27/26.
//

import Foundation
import Moya

class ProfileService {
    static let shared = ProfileService()
    private let provider = MoyaProvider<ProfileAPI>()
    
    private init() {}
    
}
