//
//  ServiceAPI.swift
//  LinkUP-iOS
//
//  Created by maple on 1/23/26.
//
import Foundation
import Moya
internal import Alamofire

enum ProfileAPI {
    case userInfo
    case myanswer
    case myquestion
}

extension ProfileAPI: TargetType {
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
        case .userInfo:
            return "profile"
        case .myanswer:
            return "profile/myans"
        case .myquestion:
            return "profile/myque"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
}
