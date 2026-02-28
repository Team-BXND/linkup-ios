//
//  ErrorThrowing.swift
//  LinkUP-iOS
//
import Foundation
import Moya

func ErrorThrowing<T: Decodable>(_ response: Response) throws -> T {
    if (200...299).contains(response.statusCode) {
        return try response.map(T.self)
    } else {
        let errorData = try? response.map(APIResponse.self) // 이새끼가 범인임
        let defaultData = APIResponse(data: Message(message: "알 수 없는 오류", email: "알 수 없는 오류"))
        
        let finalData = errorData ?? defaultData
        
        if let jsonString = String(data: response.data, encoding: .utf8) {
            print(jsonString)
        }
        print(finalData)
        switch response.statusCode {
        case 400: throw ErrorType.invalidRequest(data: finalData)
        case 401: throw ErrorType.unauthorized(data: finalData)
        case 404: throw ErrorType.notfound(data: finalData)
        case 409: throw ErrorType.duplicatedUser(data: finalData)
        case 500: throw ErrorType.serverError
        default: throw ErrorType.unknown
        }
    }

    if let json = String(data: response.data, encoding: .utf8) {
        print("❌ [서버 에러] statusCode: \(response.statusCode), JSON: \(json)")
    }

    let errorData = (try? response.map(APIResponse.self)) ?? APIResponse(data: Message(message: "알 수 없는 오류", email: ""))

    switch response.statusCode {
    case 400: throw ErrorType.invalidRequest(data: errorData)
    case 401: throw ErrorType.unauthorized(data: errorData)
    case 404: throw ErrorType.notfound(data: errorData)
    case 409: throw ErrorType.duplicatedUser(data: errorData)
    case 500: throw ErrorType.serverError
    default:  throw ErrorType.unknown
    }
}

func ErrorMessage(error: ErrorType) -> String {
    switch error {
    case .invalidRequest(data: let data):
        data.data.message!
    case .unauthorized(data: let data):
        data.data.message!
    case .notfound(data: let data):
        data.data.message!
    case .duplicatedUser(data: let data):
        data.data.message!
    case .serverError:
        "서버 오류"
    case .unknown:
        "알 수 없는 오류"
    }
}
