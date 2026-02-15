//
//  ErrorType.swift
//  LinkUP-iOS
//
//  Created by maple on 2/14/26.
//

import Foundation

enum ErrorType: Error {
    
    case invalidRequest // 400
    case unauthorized   // 401
    case notfound       // 404
    case duplicatedUser // 409
    case serverError    // 500
    case unknown
}
