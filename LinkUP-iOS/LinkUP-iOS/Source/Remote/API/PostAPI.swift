//
//  PostAPI.swift
//  LinkUP-iOS
//
//  Created by maple on 1/23/26.
//
import Foundation
import Moya
internal import Alamofire

enum PostAPI {
    case getposting
    case getpost(id: Int) //query parameter
    case posting
    case patchposting
    case deleteposting
    case answering
    case deleteanswer
    case acceptanswer
    case like
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
            
        case .getposting:
            <#code#>
        case .getpost(id: let id):
            <#code#>
        case .posting:
            <#code#>
        case .patchposting:
            <#code#>
        case .deleteposting:
            <#code#>
        case .answering:
            <#code#>
        case .deleteanswer:
            <#code#>
        case .acceptanswer:
            <#code#>
        case .like:
            <#code#>
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getposting, .getpost:
            return .get
            
        case .patchposting:
            return .patch
            
        case .deleteanswer, .deleteposting:
            return .delete
            
        default:
            return .post
       
        }
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
}
