//
//  PostService.swift
//  LinkUP-iOS
//
import Foundation
import Moya
internal import Alamofire

class PostService {
    static let shared = PostService()
    private let provider: MoyaProvider<PostAPI> = {
        let session = Session(interceptor: AuthInterceptor.shared)
        return MoyaProvider<PostAPI>(session: session)
    }()
    private init() {}

    func fetchPosts(category: Category? = nil, page: Int = 1) async throws -> PostsResponse {
        let response = try await provider.request(target: .getposting(category: category, page: page))
        return try ErrorThrowing(response)
    }

    func fetchPostDetail(id: Int) async throws -> PostDetailResponse {
        let response = try await provider.request(target: .getpost(id: id))
        return try ErrorThrowing(response)
    }

    func createPost(content: CreatePostRequest) async throws {
        let response = try await provider.request(target: .posting(content: content))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
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

    func toggleLike(id: Int) async throws {
        let response = try await provider.request(target: .like(id: id))
        guard (200...299).contains(response.statusCode) else { throw ErrorType.unknown }
    }
}
