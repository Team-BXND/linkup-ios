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
    case signup(userInfo: AuthRequest)
    case signin(loginInfo: AuthRequest)
    case codesend(email: String)
    case verify(verifyInfo: AuthRequest)
    case change(change: AuthRequest)
    case refresh(refresh: String)
}

let requestEncoder = JSONEncoding.default

extension AuthAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
        case .signup: "auth/signup"
        case .signin: "auth/signin"
        case .codesend: "auth/pwchange/send"
        case .verify: "auth/pwchange/verify"
        case .change: "auth/pwchange/change"
        case .refresh: "auth/refresh"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .signup(userInfo: let Info): .requestJSONEncodable(Info)
            
        case .signin(loginInfo: let Info): .requestJSONEncodable(Info)
            
        case .codesend(email: let email): .requestParameters(parameters: ["email": email], encoding: requestEncoder)
            
        case .verify(verifyInfo: let Info): .requestJSONEncodable(Info)
            
        case .change(change: let change): .requestJSONEncodable(change)
            
        case .refresh(refresh: let refresh): .requestParameters(parameters: ["refresh": refresh], encoding: requestEncoder)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
