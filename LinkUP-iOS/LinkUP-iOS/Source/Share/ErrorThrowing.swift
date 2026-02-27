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
            // ✅ 디코딩 실패 시 어떤 필드가 문제인지 출력
            print("❌ [디코딩 실패] 타입: \(T.self)")
            print("❌ [디코딩 실패] 에러: \(error)")
            if let json = String(data: response.data, encoding: .utf8) {
                print("❌ [디코딩 실패] JSON: \(json)")
            }
            throw error
        }
    }

    if let json = String(data: response.data, encoding: .utf8) {
        print("❌ [서버 에러] statusCode: \(response.statusCode), JSON: \(json)")
    }

    let errorData = (try? response.map(APIResponse.self)) ?? APIResponse(data: Message(message: "알 수 없는 오류"))

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
    case .invalidRequest(let data): return data.data.message
    case .unauthorized(let data):   return data.data.message
    case .notfound(let data):       return data.data.message
    case .duplicatedUser(let data): return data.data.message
    case .serverError:              return "서버 오류"
    case .unknown:                  return "알 수 없는 오류"
    }
}
