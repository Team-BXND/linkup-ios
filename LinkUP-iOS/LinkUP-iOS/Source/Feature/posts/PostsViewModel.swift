//
//  PostsViewModel.swift
//  LinkUP-iOS
//
import SwiftUI
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var selectedTab: TabCase = .hot
    @Published var selectedCategory: Category? = nil
    @Published var selectedPost: Post?
    @Published var isLoading: Bool = false
    @Published var hasNextPage: Bool = false

    private var currentPage: Int = 1

    static let shared = PostsViewModel()
    private let service = PostService.shared

    // MARK: - 게시글 목록 조회
    func fetchPosts(category: Category? = nil, page: Int = 1) {
        guard !isLoading else { return }
        Task {
            await MainActor.run { self.isLoading = true }
            do {
                let response = try await service.fetchPosts(category: category, page: page)
                await MainActor.run {
                    if page == 1 {
                        self.posts = response.data.map { Post(from: $0) }
                    } else {
                        self.posts += response.data.map { Post(from: $0) }
                    }
                    self.currentPage = page
                    self.hasNextPage = response.meta.hasNext
                    self.isLoading = false
                }
            } catch {
                await MainActor.run { self.isLoading = false }
            }
        }
    }

    func loadMorePosts() {
        guard hasNextPage, !isLoading else { return }
        fetchPosts(category: selectedCategory, page: currentPage + 1)
    }

    // MARK: - 게시글 상세 조회
    func fetchPostDetail(id: Int) {
        Task {
            do {
                let response = try await service.fetchPostDetail(id: id)
                await MainActor.run {
                    self.selectedPost = Post(id: id, from: response.data)
                }
            } catch {
                print("❌ [fetchPostDetail 실패]: \(error)")
            }
        }
    }

    // MARK: - 게시글 작성
    func createPost(category: Category, title: String, content: String, author: String) {
        Task {
            do {
                let request = CreatePostRequest(
                    category: category.rawValue,
                    title: title,
                    content: content,
                    author: author
                )
                try await service.createPost(content: request)
            } catch {
                print("❌ [createPost 실패]: \(error)")
            }
            await MainActor.run {
                self.fetchPosts(category: self.selectedCategory, page: 1)
            }
        }
    }

    // MARK: - 게시글 수정
    func updatePost(id: Int, category: Category, title: String, content: String, author: String) {
        Task {
            do {
                let request = UpdatePostRequest(category: category.rawValue, title: title, content: content, author: author)
                try await service.updatePost(id: id, content: request)
                await MainActor.run { self.fetchPosts(category: self.selectedCategory, page: 1) }
            } catch {
                print("❌ [updatePost 실패]: \(error)")
            }
        }
    }

    // MARK: - 게시글 삭제
    func deletePost(id: Int) {
        Task {
            do {
                try await service.deletePost(id: id)
                await MainActor.run { self.posts.removeAll { $0.id == id } }
            } catch {
                print("❌ [deletePost 실패]: \(error)")
            }
        }
    }

    // MARK: - 답변 작성
    func createAnswer(postId: Int, content: String) {
        Task {
            do {
                try await service.createAnswer(postId: postId, content: content)
            } catch {
                print("❌ [createAnswer 실패]: \(error)")
            }
            await MainActor.run { self.fetchPostDetail(id: postId) }
        }
    }

    // MARK: - 답변 삭제
    func deleteAnswer(id: Int) {
        Task {
            do {
                try await service.deleteAnswer(id: id)
            } catch {
                print("❌ [deleteAnswer 실패]: \(error)")
            }
        }
    }

    // MARK: - 답변 채택
    func acceptAnswer(postId: Int, commentId: Int) {
        Task {
            do {
                try await service.acceptAnswer(postId: postId, commentId: commentId)
                await MainActor.run { self.fetchPostDetail(id: postId) }
            } catch {
                print("❌ [acceptAnswer 실패]: \(error)")
            }
        }
    }

    // MARK: - 유용해요 토글
    func toggleLike(postId: Int) {
        Task {
            do {
                try await service.toggleLike(id: postId)
            } catch {
                print("❌ [toggleLike 실패]: \(error)")
            }
            await MainActor.run {
                if let idx = self.posts.firstIndex(where: { $0.id == postId }) {
                    let liked = !(self.posts[idx].isLike ?? false)
                    self.posts[idx].isLike = liked
                    self.posts[idx].like += liked ? 1 : -1
                }
                if self.selectedPost?.id == postId {
                    let liked = !(self.selectedPost?.isLike ?? false)
                    self.selectedPost?.isLike = liked
                    self.selectedPost?.like += liked ? 1 : -1
                }
            }
        }
    }

    // MARK: - UI Helpers
    func selectPost(_ post: Post) { selectedPost = post }

    func selectCategory(_ category: Category?) {
        selectedCategory = category
        fetchPosts(category: category, page: 1)
    }
}
