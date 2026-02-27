//
//  MoyaRequestExt.swift
//  LinkUP-iOS
//
import Foundation
import Moya

extension MoyaProvider {
    func request(target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response): continuation.resume(returning: response)
                case .failure(let error):    continuation.resume(throwing: error)
                }
            }
        }
    }
}
