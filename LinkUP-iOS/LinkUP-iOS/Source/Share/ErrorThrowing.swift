//
//  ErrorThrowing.swift
//  LinkUP-iOS
//
import Foundation
import Moya

func ErrorThrowing<T: Decodable>(_ response: Response) throws -> T {
    if (200...299).contains(response.statusCode) {
        do {
            return try response.map(T.self)
        } catch {
            if let json = String(data: response.data, encoding: .utf8) {
            }
            throw error
        }
    }

    let errorData = (try? response.map(APIResponse.self)) ?? APIResponse(data: Message(message: "알 수 없는 오류", email: "알 수 없는 오류"))

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
    case .invalidRequest(let data): return data.data.message ?? "알 수 없는 오류"
    case .unauthorized(let data):   return data.data.message ?? "알 수 없는 오류"
    case .notfound(let data):       return data.data.message ?? "알 수 없는 오류"
    case .duplicatedUser(let data): return data.data.message ?? "알 수 없는 오류"
    case .serverError:              return "서버 오류"
    case .unknown:                  return "알 수 없는 오류"
    }
}
