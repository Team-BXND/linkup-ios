//
//  DiscoveryAPI.swift
//  LinkUP-iOS
//
//  Created by maple on 1/23/26.
//

import Moya
internal import Alamofire
import Foundation

enum DiscoveryAPI {
    case popular
    case hot
    case ranking
}

extension DiscoveryAPI: TargetType {
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
            
        case .popular:
            return "popular"
        case .hot:
            return "popular/hot"
        case .ranking:
            return "ranking"
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
