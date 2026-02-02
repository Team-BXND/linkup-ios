//
//  MoyaRequestExt.swift
//  LinkUP-iOS
//
//  Created by maple on 1/31/26.
//

import Foundation
import Moya


extension MoyaProvider {
    func request (target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

