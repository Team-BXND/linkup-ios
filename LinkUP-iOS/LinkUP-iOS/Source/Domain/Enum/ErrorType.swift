//
//  ErrorType.swift
//  LinkUP-iOS
//
//  Created by maple on 2/14/26.
//

import Foundation

enum ErrorType: Error {
    
    case invalidRequest(data: APIResponse) // 400
    case unauthorized(data: APIResponse)   // 401
    case notfound(data: APIResponse)   // 404
    case duplicatedUser(data: APIResponse) // 409
    case serverError    // 500
    case unknown
}

enum SignupErrorType: String, Error {
    case invalidemail
    case invalidpassword
    case duplicateemail
    case duplicateusername
    case notduplicatepassword
    case emptyinfo
    
    var errortext: String {
        switch self {
            
        case .invalidemail:
            "유효하지 않은 이메일입니다"
        case .invalidpassword:
            "비밀번호는 8자 이상의 소문자, 숫자, 특수문자로 이루어져야 합니다."
        case .duplicateemail:
            "중복된 이메일입니다."
        case .duplicateusername:
            "중복된 닉네임입니다."
        case .notduplicatepassword:
            "비밀번호가 일치하지 않습니다."
        case .emptyinfo:
            "입력하지 않은 정보가 있습니다."
        }
    }
}
