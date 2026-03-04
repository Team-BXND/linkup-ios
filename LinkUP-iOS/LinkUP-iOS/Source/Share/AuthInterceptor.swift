//
//  AuthInterceptor.swift
//  LinkUP-iOS
//

internal import Alamofire
import Foundation
import Moya

final class AuthInterceptor: RequestInterceptor {
    
    static let shared = AuthInterceptor()
    private init() {}
    
    // MARK: - adapt: 모든 요청에 액세스 토큰 자동 주입
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        
        if let accessToken = TokenStorage.shared.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(request))
    }
    
    // MARK: - retry: 401 응답 시 토큰 재발급 후 재시도
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard
            let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401,
            request.retryCount < 1  // 무한루프 방지
        else {
            completion(.doNotRetry)
            return
        }
        
        _Concurrency.Task {
            do {
                try await refreshToken()
                completion(.retry)
            } catch {
                // 리프레시도 실패 → 로그아웃 처리
                TokenStorage.shared.clear()
                NotificationCenter.default.post(name: .didSessionExpire, object: nil)
                completion(.doNotRetryWithError(error))
            }
        }
    }
    
    // MARK: - Private
    private func refreshToken() async throws {
        guard let refreshToken = TokenStorage.shared.refreshToken else {
            throw AuthError.noRefreshToken
        }
        
        let provider = MoyaProvider<AuthAPI>()  // 인터셉터 없는 provider 사용
        let response = try await provider.request(target: .refresh(refresh: refreshToken))
        
        // 응답에서 새 토큰 파싱
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
        TokenStorage.shared.accessToken = tokenResponse.data.accessToken
        // 리프레시 토큰도 갱신되는 경우
        // TokenStorage.shared.refreshToken = tokenResponse.refreshToken
    }
}

// MARK: - 토큰 저장소
final class TokenStorage {
    static let shared = TokenStorage()
    private init() {}
    
    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }
    
    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: "refreshToken") }
        set { UserDefaults.standard.set(newValue, forKey: "refreshToken") }
    }
    
    func clear() {
        accessToken = nil
        refreshToken = nil
    }
}

// MARK: - 에러 / 노티
enum AuthError: Error {
    case noRefreshToken
    case tokenRefreshFailed
}

extension Notification.Name {
    static let didSessionExpire = Notification.Name("didSessionExpire")
}
