//
//  ServiceAPI.swift
//  LinkUP-iOS
//
//  Created by maple on 1/23/26.
//

import Moya
import Foundation
internal import Alamofire

enum AuthAPI {
    case signup(_ a: String)
    case signin(a: String)
    case codesend(a: String)
    case verify(a: String)
    case change
    case refresh
}

let requesEncoder = JSONEncoding.default

extension AuthAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
            
        case .signup:
            return "auth/signup"
        case .signin:
            return "auth/signin"
        case .codesend:
            return "auth/pwchange/send"
        case .verify:
            return "auth/pwchange/verify"
        case .change:
            return "auth/pwchange/change"
        case .refresh:
            return "auth/refresh"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .signup(let a):
            return .requestParameters(parameters: <#T##[String : Any]#>, encoding: requesEncoder)
        case .signin(let a):
            <#code#>
        case .codesend(let a):
            <#code#>
        case .verify(let a):
            <#code#>
        case .change:
            <#code#>
        case .refresh:
            <#code#>
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    
}
