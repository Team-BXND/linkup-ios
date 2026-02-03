//
//  etcInfoView.swift
//  dodum-iOS
//
//  Created by maple on 9/27/25.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel.shared
    @State private var showWriteView = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // 질문 프롬프트
                        Text("💬대소고에서 궁금한 점이 있다면?")
                            .font(.semibold(18))
                            .foregroundColor(.primary)
                            .padding(.leading, 32)
                        
                        // 카드 배너
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                Image("Banner1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                                    .cornerRadius(20)
                                
                                Image("Banner2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                                    .cornerRadius(20)
                                
                                Image("Banner3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                                    .cornerRadius(20)
                            }
                            .padding(.horizontal, 32)
                        }
                        
                        // 탭 버튼
                        HStack(spacing: 12) {
                            Button(action: {
                                viewModel.selectedTab = .hot
                                viewModel.selectCategory(nil)
                            }) {
                                Text("🔥가장 유용했던 글")
                                    .font(.bold(16))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(viewModel.selectedTab == .hot ? Color("MainColor") : Color.white)
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
                                    .background(viewModel.selectedTab == .list ? Color("MainColor") : Color.white)
                                    .foregroundColor(viewModel.selectedTab == .list ? .white : .black)
                                    .cornerRadius(25)
                                    .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                            }
                        }
                        .padding(.leading, 32)
                        
                        // 카테고리 필터 (질문 목록 탭일 때만 표시)
                        if viewModel.selectedTab == .list {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    Button(action: {
                                        viewModel.selectCategory(nil)
                                    }) {
                                        Text("전체")
                                            .font(.medium(12))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(viewModel.selectedCategory == nil ? Color("MainColor") : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                    
                                    ForEach(Category.allCases) { category in
                                        Button(action: {
                                            viewModel.selectCategory(category)
                                        }) {
                                            Text(category.rawValue)
                                                .font(.medium(12))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(viewModel.selectedCategory == category ? Color("MainColor") : Color.gray)
                                                .foregroundColor(.white)
                                                .cornerRadius(20)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                            }
                        }
                        
                        // 질문 목록
                        VStack(spacing: 12) {
                            ForEach(viewModel.selectedTab == .list ? viewModel.filteredPosts : viewModel.posts) { post in
                                NavigationLink(destination:
                                    PostsDetailView(post: post)
                                        .environmentObject(viewModel)
                                ) {
                                    HStack(alignment: .top, spacing: 16) {
                                        Text("\(post.id)")
                                            .font(.semibold(16))
                                            .foregroundColor(Color("MainColor"))
                                            .frame(width: 30)
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text(post.title)
                                                .font(.semibold(16))
                                                .foregroundColor(.primary)
                                            
                                            HStack(spacing: 16) {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "hand.thumbsup")
                                                        .font(.regular(12))
                                                    Text("유용해요 \(post.like)")
                                                        .font(.regular(12))
                                                }
                                                
                                                HStack(spacing: 4) {
                                                    Image(systemName: "message.fill")
                                                        .font(.regular(12))
                                                    Text("답변수 \(post.commentCount ?? 0)")
                                                        .font(.regular(12))
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
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 100)
                    }
                    .padding(.top)
                }
                
                // 플로팅 버튼
                Button(action: { showWriteView = true }) {
                    Image(systemName: "plus")
                        .font(.medium(24))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color("MainColor"))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showWriteView) {
            WriteView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    PostsView()
}
