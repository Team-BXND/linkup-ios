//
//  DiscoveryAPI.swift
//  LinkUP-iOS
//
//  Created by maple on 1/23/26.
//

import Foundation
import Moya
internal import Alamofire

enum DiscoveryAPI {
    case popular(page: Int)
    case popularhot(page: Int)
    case ranking
}

extension DiscoveryAPI: TargetType {
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
            case .popular: "popular"
            case .popularhot: "popular/hot"
            case .ranking: "ranking"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
            case .popular(page: let page), .popularhot(page: let page):
                return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
            case .ranking:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
