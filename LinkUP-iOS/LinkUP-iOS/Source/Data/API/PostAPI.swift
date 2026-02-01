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
    case getposting(category: Category, page: Int)
    case getpost(id: Int) //query parameter
    case posting(content: PostingModel)
    case patchposting(id: Int, content: PostingModel)
    case deleteposting(id: Int)
    case answering(content: String, id: Int)
    case deleteanswer(id: Int)
    case acceptanswer(id: Int, commentId: Int)
    case like(id: Int)
}

extension PostAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: baseurl)!
    }
    
    var path: String {
        switch self {
            
        case .getposting: "/posts"
            
        case .getpost(id: let id): "posts/\(id)"
            
        case .posting: "/posts"
            
        case .patchposting(id: let id): "/posts/\(id)"
            
        case .deleteposting(id: let id): "/posts/\(id)"
            
        case .answering(id: let id): "/posts/\(id)/answer"
            
        case .deleteanswer(id: let id): "/posts/\(id)/answer"
            
        case .acceptanswer(id: let id): "posts/\(id)/accept/ansid"
            
        case .like(id: let id): "posts/\(id)/like"
            
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
        switch self {
            
        case .getposting(category: let category, page: let page):
                .requestCompositeParameters(bodyParameters: ["category": category], bodyEncoding: requestEncoder, urlParameters: ["page": page])
            
        case .posting(content: let content), .patchposting(_, content: let content):
                .requestJSONEncodable(content)
            
        case .answering(content: let content):
                .requestParameters(parameters: ["content": content], encoding: requestEncoder)
        case .acceptanswer(_, commentId: let commentId):
                .requestParameters(parameters: ["commentId": commentId], encoding: requestEncoder)
        default:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: "access")
        switch self {
        case .getpost:
            return ["Content-Type": "application/json"]
            
        default:
            return ["Content-Type": "application/json", "Authorization": "Bearer \(token!)"]
        }
    }
    
    
}
