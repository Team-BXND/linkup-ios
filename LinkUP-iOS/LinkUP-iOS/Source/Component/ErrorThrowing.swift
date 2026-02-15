//
//  ErrorThrowing.swift
//  LinkUP-iOS
//
//  Created by maple on 2/15/26.
//

import Foundation
import Moya


func ErrorThrowing<T: Decodable>(_ response: Response) throws -> T {
    if (200...299).contains(response.statusCode) {
        return try response.map(T.self)
    } else {
        print(response)
        switch response.statusCode {
        case 400: throw ErrorType.invalidRequest
        case 401: throw ErrorType.unauthorized
        case 404: throw ErrorType.notfound
        case 409: throw ErrorType.duplicatedUser
        case 500: throw ErrorType.serverError
        default: throw ErrorType.unknown
        }
    }
}
