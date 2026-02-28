//
//  PostsView.swift
//  LinkUP-iOS
//
import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel.shared
    @StateObject private var popularViewModel = PopularViewModel()
    @State private var showWriteView = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        Text("💬대소고에서 궁금한 점이 있다면?")
                            .font(.semibold(18))
                            .foregroundColor(.primary)
                            .padding(.leading, 32)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["School", "Code", "Project"], id: \.self) { name in
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 180)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.horizontal, 32)
                        }

                        HStack(spacing: 12) {
                            Button(action: {
                                viewModel.selectedTab = .hot
                                popularViewModel.fetchPopular()
                            }) {
                                Text("🔥가장 유용했던 글")
                                    .font(.bold(16))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(viewModel.selectedTab == .hot ? Color.main : Color.white)
                                    .foregroundColor(viewModel.selectedTab == .hot ? .white : .black)
                                    .cornerRadius(25)
                                    .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                            }

                            Button(action: {
                                viewModel.selectedTab = .list
                                viewModel.selectCategory(nil)
                            }) {
                                Text("🧐질문 목록")
                                    .font(.bold(16))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(viewModel.selectedTab == .list ? .main : Color.white)
                                    .foregroundColor(viewModel.selectedTab == .list ? .white : .black)
                                    .cornerRadius(25)
                                    .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                            }
                        }
                        .padding(.leading, 32)

                        if viewModel.selectedTab == .list {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    Button(action: { viewModel.selectCategory(nil) }) {
                                        Text("전체")
                                            .font(.medium(12))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(viewModel.selectedCategory == nil ? .main : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                    ForEach(Category.allCases) { category in
                                        Button(action: { viewModel.selectCategory(category) }) {
                                            Text(category.displayName)
                                                .font(.medium(12))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(viewModel.selectedCategory == category ? .main : Color.gray)
                                                .foregroundColor(.white)
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                            }
                        }

                        if viewModel.selectedTab == .hot {
                            LazyVStack(spacing: 12) {
                                ForEach(Array(popularViewModel.populars.prefix(3).enumerated()), id: \.element.id) { index, item in
                                    NavigationLink(destination:
                                        PostsDetailView(post: convertPopularToPost(item))
                                            .environmentObject(viewModel)
                                    ) {
                                        HStack(alignment: .top, spacing: 16) {
                                            Text("\(index + 1)")
                                                .font(.semibold(16))
                                                .foregroundColor(.main)
                                                .frame(width: 30)

                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(item.title)
                                                    .font(.semibold(16))
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.leading)

                                                HStack(spacing: 16) {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "hand.thumbsup").font(.system(size: 12))
                                                        Text("유용해요 \(item.like)").font(.system(size: 12))
                                                    }
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "message.fill").font(.system(size: 12))
                                                        Text("답변수 \(item.commentCount ?? 0)").font(.system(size: 12))
                                                    }
                                                }
                                                .foregroundColor(.gray)
                                            }
                                            Spacer()
                                        }
                                        .padding(20)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 100)
                        }

                        if viewModel.selectedTab == .list {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.posts) { post in
                                    NavigationLink(destination:
                                        PostsDetailView(post: post)
                                            .environmentObject(viewModel)
                                    ) {
                                        HStack(alignment: .top, spacing: 16) {
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(post.title)
                                                    .font(.semibold(16))
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.leading)

                                                HStack(spacing: 16) {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "hand.thumbsup").font(.system(size: 12))
                                                        Text("유용해요 \(post.like)").font(.system(size: 12))
                                                    }
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "message.fill").font(.system(size: 12))
                                                        Text("답변수 \(post.commentCount)").font(.system(size: 12))
                                                    }
                                                }
                                                .foregroundColor(.gray)
                                            }
                                            Spacer()
                                        }
                                        .padding(20)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .onAppear {
                                        if post.id == viewModel.posts.last?.id {
                                            viewModel.loadMorePosts()
                                        }
                                    }
                                }

                                if viewModel.isLoading {
                                    ProgressView().padding(.vertical, 12)
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 100)
                        }
                    }
                    .padding(.top)
                }

                Button(action: { showWriteView = true }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(.main)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showWriteView) {
            WriteView().environmentObject(viewModel)
        }
        .onAppear {
            print("🔵 [PostsView onAppear 호출]") // ✅ 추가
            popularViewModel.fetchPopular()
            viewModel.fetchPosts(page: 1)
        }
    }

    private func convertPopularToPost(_ popular: PopularDataInfo) -> Post {
        Post(
            id: popular.id,
            title: popular.title,
            author: popular.author ?? "익명",
            category: popular.category,
            like: popular.like,
            createdAt: popular.createdAt,
            isAccepted: popular.isAccepted,
            preview: popular.preview ?? "",
            commentCount: popular.commentCount ?? 0,
            content: popular.preview,
            isLike: false,
            isAuthor: false,
            comments: []
        )
    }
}

#Preview {
    PostsView()
}
