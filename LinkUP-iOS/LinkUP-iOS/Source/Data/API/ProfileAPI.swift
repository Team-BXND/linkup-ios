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
    case myanswer(page: Int)
    case myquestion(page: Int)
}

extension ProfileAPI: TargetType {
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
        case .userInfo: "profile"
        case .myanswer: "profile/myans"
        case .myquestion: "profile/myque"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .userInfo: return .requestPlain
            
        case .myanswer(page: let page), .myquestion(page: let page): return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: "access")
        return ["Content-Type": "application/json", "Authorization": "Bearer \(token!)"]
    }
    
    
}
