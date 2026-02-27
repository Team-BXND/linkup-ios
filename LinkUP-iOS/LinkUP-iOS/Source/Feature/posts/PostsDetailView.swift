//
//  PostsDetailView.swift
//  LinkUP-iOS
//
import SwiftUI

struct PostsDetailView: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss
    let post: Post

    @State private var answerText = ""
    @FocusState private var isAnswerFocused: Bool

    var displayPost: Post {
        viewModel.selectedPost ?? post
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── 스크롤 콘텐츠 ─────────────────────────────────────
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // 헤더 (제목 + 좋아요)
                    HStack(alignment: .top, spacing: 12) {
                        Text("Q")
                            .font(.bold(36))
                            .foregroundColor(Color("MainColor"))
                            .frame(width: 50, height: 50)

                        Text(displayPost.title)
                            .font(.bold(16))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()

                        Button(action: { viewModel.toggleLike(postId: displayPost.id) }) {
                            Image(systemName: (displayPost.isLike ?? false) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .font(.semibold(12))
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                                .background((displayPost.isLike ?? false) ? Color("MainColor") : Color.gray)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    // 메타 정보
                    HStack(spacing: 8) {
                        Text("\(displayPost.author) 님")
                        Text(displayPost.category.displayName)
                        Text("작성일 : \(displayPost.createdAt)")
                        Text("유용해요 : \(displayPost.like)개")
                    }
                    .font(.medium(10))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    // 본문
                    Text(displayPost.content ?? "")
                        .font(.medium(12))
                        .foregroundColor(.primary)
                        .lineSpacing(6)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    Divider().padding(.vertical, 24).padding(.horizontal, 20)

                    // 답변 섹션
                    VStack(alignment: .leading, spacing: 16) {
                        Text("\(displayPost.comments?.count ?? 0)개의 답변")
                            .font(.semibold(16))
                            .padding(.horizontal, 20)

                        ForEach(displayPost.comments ?? []) { comment in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 8) {
                                    Text("A")
                                        .font(.bold(26))
                                        .foregroundColor(.red)
                                        .frame(width: 40, height: 40)
                                        .background(Color.red.opacity(0.1))
                                        .clipShape(Circle())

                                    Text("\(comment.author) 님의 답변")
                                        .font(.bold(14))
                                    Spacer()
                                }
                                Text("작성일 : \(comment.createdAt)")
                                    .font(.medium(10))
                                    .foregroundColor(.gray)
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

            // ── 답변 입력 영역 ────────────────────────────────────
            VStack(spacing: 0) {
                Divider()

                // 서식 툴바 (입력창 위)
                if isAnswerFocused {
                    HStack(spacing: 16) {
                        ForEach([("B", "bold"), ("I", "italic"), ("U", "underline"), ("S", "strikethrough")], id: \.0) { label, _ in
                            Button(action: {}) {
                                Text(label)
                                    .font(label == "B" ? .system(size: 15, weight: .bold) :
                                          label == "I" ? .system(size: 15).italic() :
                                          .system(size: 15))
                                    .underline(label == "U")
                                    .strikethrough(label == "S")
                                    .foregroundColor(.gray)
                                    .frame(width: 28, height: 28)
                            }
                        }
                        Button(action: {}) {
                            Image(systemName: "link").foregroundColor(.gray)
                        }
                        Button(action: {}) {
                            Image(systemName: "photo").foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(UIColor.systemGray6))
                }

                // 입력창 + 보내기 버튼
                HStack(spacing: 10) {
                    TextField("답변을 입력하세요.", text: $answerText, axis: .vertical)
                        .font(.medium(14))
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
                        .focused($isAnswerFocused)

                    // 보내기 버튼: 내용 없으면 흰색(비활성), 있으면 파란색
                    Button(action: { submitAnswer() }) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                        ? Color(UIColor.systemGray4)
                                        : Color.blue)
                            .clipShape(Circle())
                    }
                    .disabled(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            viewModel.selectPost(post)
            viewModel.fetchPostDetail(id: post.id)
        }
    }

    // MARK: - 답변 제출
    private func submitAnswer() {
        let trimmed = answerText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        viewModel.createAnswer(postId: displayPost.id, content: trimmed)
        answerText = ""
        isAnswerFocused = false
    }
}

#Preview {
    NavigationView {
        PostsDetailView(post: Post(
            id: 1, title: "샘플 질문", author: "작성자",
            category: .school, like: 5, createdAt: "2026-01-18",
            isAccepted: false, preview: "샘플", commentCount: 0,
            content: "샘플 내용입니다.", isLike: false, isAuthor: false, comments: []
        ))
        .environmentObject(PostsViewModel.shared)
    }
}
