//
//  PostsDetailView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/12/26.
//

import SwiftUI

struct PostsDetailView: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 헤더 (제목 + 좋아요)
                HStack(alignment: .top, spacing: 12) {
                    // Q 아이콘
                    Text("Q")
                        .font(.bold(36))
                        .foregroundColor(Color("MainColor"))
                        .frame(width: 50, height: 50)
                    
                    // 제목
                    Text(post.title)
                        .font(.bold(16))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    // 유용해요 버튼
                    Button(action: {
                        viewModel.toggleLike(for: post)
                    }) {
                        Image(systemName: (post.isLike ?? false) ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.semibold(12))
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background((post.isLike ?? false) ? Color("MainColor") : Color.gray)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // 메타 정보
                HStack(spacing: 8) {
                    Text("\(post.author)님")
                        .font(.medium(10))
                        .foregroundColor(.gray)
                    
                    Text(post.category.rawValue)
                        .font(.medium(10))
                        .foregroundColor(.gray)
                    
                    Text("작성일 : \(post.createdAt)")
                        .font(.medium(10))
                        .foregroundColor(.gray)
                    
                    Text("유용해요 : \(post.like)개")
                        .font(.medium(10))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                // 본문
                Text(post.content ?? "")
                    .font(.medium(12))
                    .foregroundColor(.primary)
                    .lineSpacing(6)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Divider()
                    .padding(.vertical, 24)
                    .padding(.horizontal, 20)
                
                // 답변 섹션
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(post.comments?.count ?? 0)개의 답변")
                        .font(.semibold(16))
                        .padding(.horizontal, 20)
                    
                    ForEach(post.comments ?? []) { comment in
                        VStack(alignment: .leading, spacing: 12) {
                            // 답변 헤더
                            HStack(spacing: 8) {
                                Text("A")
                                    .font(.bold(26))
                                    .foregroundColor(.red)
                                    .frame(width: 40, height: 40)
                                    .background(Color.red.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text("\(comment.author)님의 답변")
                                    .font(.bold(14))
                                
                                Spacer()
                            }
                            
                            // 답변 날짜
                            Text("작성일 : \(comment.createdAt)")
                                .font(.medium(10))
                                .foregroundColor(.gray)
                            
                            // 답변 내용
                            Text(comment.content)
                                .font(.medium(12))
                                .foregroundColor(.primary)
                                .lineSpacing(6)
                        }
                        .padding(20)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(comment.isAccepted ? Color("MainColor") : Color.clear, lineWidth: 2)
                        )
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            viewModel.selectPost(post)
        }
    }
}

#Preview {
    NavigationView {
        PostsDetailView(post: Post(
            id: 1,
            title: "샘플 질문",
            author: "작성자",
            category: .school,
            like: 5,
            createdAt: "2026-01-18",
            isAccepted: false,
            preview: nil,
            commentCount: nil,
            content: "샘플 내용입니다.",
            isLike: false,
            isAuthor: false,
            comments: []
        ))
        .environmentObject(PostsViewModel())
    }
}
