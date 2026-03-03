//
//  UploadService.swift
//  LinkUP-iOS
//
import Foundation
import Moya

class UploadService {
    static let shared = UploadService()
    private let provider = MoyaProvider<UploadAPI>()
    private init() {}

    // 이미지 업로드 → s3Key 반환
    func uploadImage(data: Data, fileName: String) async throws -> String {
        let response = try await provider.request(target: .uploadImage(data: data, fileName: fileName))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
        let result = try response.map(UploadResponse.self)
        return result.data
    }

    // s3Key → Presigned URL 반환
    func getPresignedURL(s3Key: String) async throws -> String {
        let token = UserDefaults.standard.string(forKey: "access") ?? ""

        // s3Key의 슬래시를 그대로 유지하면서 URL 생성
        var components = URLComponents(string: "\(baseurl)/upload")!
        components.queryItems = [URLQueryItem(name: "s3Key", value: s3Key)]
        guard let url = components.url else { throw ErrorType.unknown }


        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let json = String(data: data, encoding: .utf8) {
        }

        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            if let http = response as? HTTPURLResponse {
            }
            throw ErrorType.unknown
        }

        let result = try JSONDecoder().decode(UploadResponse.self, from: data)
        return result.data
    }
}

struct UploadResponse: Decodable {
    let status: Int
    let data: String
}
