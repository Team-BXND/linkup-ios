//
//  PostAPI.swift
//  LinkUP-iOS
//
import Foundation
import Moya
internal import Alamofire

enum PostAPI {
    case getposting(category: Category?, page: Int)
    case getpost(id: Int)
    case posting(content: CreatePostRequest)
    case patchposting(id: Int, content: UpdatePostRequest)
    case deleteposting(id: Int)
    case answering(content: String, id: Int)
    case deleteanswer(id: Int)
    case acceptanswer(id: Int, commentId: Int)
    case like(id: Int)
}

extension PostAPI: TargetType {

    var baseURL: URL {
        URL(string: baseurl)!
    }

    var path: String {
        switch self {
        case .getposting:                      return "/posts"
        case .getpost(let id):                 return "/posts/\(id)"
        case .posting:                         return "/posts"
        case .patchposting(let id, _):         return "/posts/\(id)"
        case .deleteposting(let id):           return "/posts/\(id)"
        case .answering(_, let id):            return "/posts/\(id)/answer"
        case .deleteanswer(let id):            return "/posts/\(id)/answer"
        case .acceptanswer(let id, _):         return "/posts/\(id)/accept"
        case .like(let id):                    return "/posts/\(id)/like"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getposting, .getpost:                 return .get
        case .patchposting:                         return .patch
        case .deleteanswer, .deleteposting:         return .delete
        default:                                    return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .getposting(let category, let page):
            var params: [String: Any] = ["page": page - 1]
            if let category { params["category"] = category.rawValue }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)

        case .posting(let content):
            return .requestJSONEncodable(content)

        case .patchposting(_, let content):
            return .requestJSONEncodable(content)

        case .answering(let content, _):
            return .requestParameters(parameters: ["content": content], encoding: JSONEncoding.default)

        case .acceptanswer(_, let commentId):
            return .requestParameters(parameters: ["commentId": commentId], encoding: JSONEncoding.default)

        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let token = UserDefaults.standard.string(forKey: "access") ?? ""
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
}
