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
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color("MainColor"))
                        .frame(width: 50, height: 50)
                    
                    // 제목
                    Text(post.title)
                        .font(.system(size: 18, weight: .bold))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    // 좋아요 버튼
                    Button(action: {
                        viewModel.toggleHelpful()
                    }) {
                        Image(systemName: viewModel.isHelpful ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(viewModel.isHelpful ? Color("MainColor") : Color.gray)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // 메타 정보
                HStack(spacing: 8) {
                    Text(post.author)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text(post.category)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text("작성일 : \(post.date)")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text("유용해요 : \(post.helpfulCount)개")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                // 본문
                Text(post.content)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .lineSpacing(6)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Divider()
                    .padding(.vertical, 24)
                    .padding(.horizontal, 20)
                
                // 답변 섹션
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(post.answers.count)개의 답변")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 20)
                    
                    ForEach(post.answers) { answer in
                        VStack(alignment: .leading, spacing: 12) {
                            // 답변 헤더
                            HStack(spacing: 8) {
                                Text("A")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.red)
                                    .frame(width: 40, height: 40)
                                    .background(Color.red.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text("\(answer.author)님의 답변")
                                    .font(.system(size: 16, weight: .bold))
                                
                                Spacer()
                            }
                            
                            // 답변 날짜
                            Text("작성일 : \(answer.date)")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                            
                            // 답변 내용
                            Text(answer.content)
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                                .lineSpacing(6)
                        }
                        .padding(20)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
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
            category: "카테고리",
            date: "2026-01-18",
            helpfulCount: 5,
            answersCount: 3,
            content: "샘플 내용입니다.",
            answers: []
        ))
        .environmentObject(PostsViewModel())
    }
}
