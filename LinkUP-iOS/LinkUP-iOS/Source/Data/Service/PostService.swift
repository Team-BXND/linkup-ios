//
//  PostService.swift
//  LinkUP-iOS
//
import Foundation
import Moya

class PostService {
    static let shared = PostService()
    private let provider = MoyaProvider<PostAPI>()
    private init() {}

    func fetchPosts(category: Category? = nil, page: Int = 1) async throws -> PostsResponse {
        let response = try await provider.request(target: .getposting(category: category, page: page))
        return try ErrorThrowing(response)
    }

    func fetchPostDetail(id: Int) async throws -> PostDetailResponse {
        let response = try await provider.request(target: .getpost(id: id))
        return try ErrorThrowing(response)
    }

    // ✅ 반환 타입 Void — 서버 응답 구조 불일치 디코딩 에러 우회
    func createPost(content: CreatePostRequest) async throws {
        let response = try await provider.request(target: .posting(content: content))
        print("📦 [createPost] statusCode: \(response.statusCode)")
        if let json = String(data: response.data, encoding: .utf8) {
            print("📦 [createPost JSON]: \(json)")
        }
        guard (200...299).contains(response.statusCode) else {
            throw ErrorType.unknown
        }
    }

    func updatePost(id: Int, content: UpdatePostRequest) async throws {
        let response = try await provider.request(target: .patchposting(id: id, content: content))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }

    func deletePost(id: Int) async throws {
        let response = try await provider.request(target: .deleteposting(id: id))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }

    func createAnswer(postId: Int, content: String) async throws {
        let response = try await provider.request(target: .answering(content: content, id: postId))
        print("📦 [createAnswer] statusCode: \(response.statusCode)")
        if let json = String(data: response.data, encoding: .utf8) {
            print("📦 [createAnswer JSON]: \(json)")
        }
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }

    func deleteAnswer(id: Int) async throws {
        let response = try await provider.request(target: .deleteanswer(id: id))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }

    func acceptAnswer(postId: Int, commentId: Int) async throws {
        let response = try await provider.request(target: .acceptanswer(id: postId, commentId: commentId))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }

    // ✅ 반환 타입 Void — toggleLike 응답 구조 불일치 우회
    func toggleLike(id: Int) async throws {
        let response = try await provider.request(target: .like(id: id))
        print("📦 [toggleLike] statusCode: \(response.statusCode)")
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }
}
