//
//  UploadAPI.swift
//  LinkUP-iOS
//
import Foundation
import Moya
internal import Alamofire

enum UploadAPI {
    case uploadImage(data: Data, fileName: String)
    case getPresignedURL(s3Key: String)
}

extension UploadAPI: TargetType {

    var baseURL: URL { URL(string: baseurl)! }

    var path: String { "/upload" }

    var method: Moya.Method {
        switch self {
        case .uploadImage:      return .post
        case .getPresignedURL:  return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .uploadImage(let data, let fileName):
            let formData = MultipartFormData(
                provider: .data(data),
                name: "file",
                fileName: fileName,
                mimeType: "image/jpeg"
            )
            return .uploadMultipart([formData])

        case .getPresignedURL(let s3Key):
            return .requestParameters(
                parameters: ["s3Key": s3Key],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        let token = UserDefaults.standard.string(forKey: "access") ?? ""
        switch self {
        case .uploadImage:
            return ["Authorization": "Bearer \(token)"]
        case .getPresignedURL:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
