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
    @State private var showDeleteAlert = false
    @State private var showEditView = false
    @State private var showAcceptAlert = false
    @State private var acceptCommentId: Int? = nil
    @FocusState private var isAnswerFocused: Bool

    var displayPost: Post {
        viewModel.selectedPost ?? post
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    HStack(alignment: .top, spacing: 12) {
                        Text("Q")
                            .font(.bold(36))
                            .foregroundColor(Color("Main"))
                            .frame(width: 50, height: 50)

                        Text(displayPost.title)
                            .font(.bold(16))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()

                        if displayPost.isAuthor != true {
                            Button(action: { viewModel.toggleLike(postId: displayPost.id) }) {
                                Image(systemName: (displayPost.isLike ?? false) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                    .font(.semibold(12))
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                                    .background((displayPost.isLike ?? false) ? Color("Main") : Color.gray)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

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

                    PostContentView(content: displayPost.content ?? "")
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    if displayPost.isAuthor == true {
                        HStack {
                            Spacer()
                            Button("수정") { showEditView = true }
                                .font(.medium(12))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)

                            Button("삭제") { showDeleteAlert = true }
                                .font(.medium(12))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }

                    Divider().padding(.vertical, 24).padding(.horizontal, 20)

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

                                    if displayPost.isAuthor == true && !comment.isAccepted {
                                        Button("채택하기") {
                                            acceptCommentId = comment.id
                                            showAcceptAlert = true
                                        }
                                        .font(.medium(12))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color("Main"))
                                        .cornerRadius(8)
                                    }

                                    if comment.isAccepted {
                                        Text("채택됨")
                                            .font(.medium(12))
                                            .foregroundColor(Color("Main"))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color("Main").opacity(0.1))
                                            .cornerRadius(8)
                                    }
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
                                    .stroke(comment.isAccepted ? Color("Main") : Color.clear, lineWidth: 2)
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }

            if displayPost.isAuthor != true {
                VStack(spacing: 0) {
                    Divider()

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
                            Button(action: {}) { Image(systemName: "link").foregroundColor(.gray) }
                            Button(action: {}) { Image(systemName: "photo").foregroundColor(.gray) }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(UIColor.systemGray6))
                    }

                    HStack(spacing: 10) {
                        TextField("따뜻한 댓글을 입력해주세요!", text: $answerText, axis: .vertical)
                            .font(.medium(14))
                            .lineLimit(1...4)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(20)
                            .focused($isAnswerFocused)

                        Button(action: { submitAnswer() }) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                            ? Color(UIColor.systemGray4) : Color.blue)
                                .clipShape(Circle())
                        }
                        .disabled(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white)
                }
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
        .alert("게시글 삭제", isPresented: $showDeleteAlert) {
            Button("삭제", role: .destructive) {
                viewModel.deletePost(id: displayPost.id)
                dismiss()
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("정말 삭제하시겠어요? 삭제 후 복구할 수 없어요.")
        }
        .alert("답변 채택", isPresented: $showAcceptAlert) {
            Button("채택하기", role: .destructive) {
                if let commentId = acceptCommentId {
                    viewModel.acceptAnswer(postId: displayPost.id, commentId: commentId)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("이 답변을 채택하시겠어요? 채택 후 변경할 수 없어요.")
        }
        .fullScreenCover(isPresented: $showEditView, onDismiss: {
            viewModel.fetchPostDetail(id: post.id)
        }) {
            WriteView(editPost: displayPost)
                .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.selectPost(post)
            viewModel.fetchPostDetail(id: post.id)
        }
    }

    private func submitAnswer() {
        let trimmed = answerText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        viewModel.createAnswer(postId: displayPost.id, content: trimmed)
        answerText = ""
        isAnswerFocused = false
    }
}

// MARK: - 본문 렌더링 (텍스트 + 이미지 분리)
struct PostContentView: View {
    let content: String

    var blocks: [ContentBlock] {
        var result: [ContentBlock] = []
        var remaining = content
        let pattern = try! NSRegularExpression(pattern: #"!\[\]\(([^)]+)\)"#)

        while !remaining.isEmpty {
            let range = NSRange(remaining.startIndex..., in: remaining)
            if let match = pattern.firstMatch(in: remaining, range: range),
               let matchRange = Range(match.range, in: remaining),
               let s3KeyRange = Range(match.range(at: 1), in: remaining) {

                let before = String(remaining[remaining.startIndex..<matchRange.lowerBound])
                if !before.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    result.append(.text(before))
                }
                let s3Key = String(remaining[s3KeyRange])
                result.append(.image(s3Key))
                remaining = String(remaining[matchRange.upperBound...])
            } else {
                result.append(.text(remaining))
                break
            }
        }
        return result
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(blocks.indices, id: \.self) { i in
                switch blocks[i] {
                case .text(let str):
                    MarkdownTextView(text: str)
                case .image(let s3Key):
                    PresignedImageView(s3Key: s3Key)
                }
            }
        }
    }
}

enum ContentBlock {
    case text(String)
    case image(String)
}

// MARK: - 마크다운 텍스트 렌더링
struct MarkdownTextView: View {
    let text: String

    var body: some View {
        parsedText
            .foregroundColor(.primary)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
    }

    var parsedText: Text {
        var result = Text("")
        for part in parseMarkdown(text) {
            var t = Text(part.text)
            if part.bold { t = t.bold() }
            if part.italic { t = t.italic() }
            if part.strikethrough { t = t.strikethrough() }
            result = result + t
        }
        return result
    }

    struct Part {
        var text: String
        var bold: Bool = false
        var italic: Bool = false
        var strikethrough: Bool = false
    }

    func parseMarkdown(_ input: String) -> [Part] {
        var parts: [Part] = []
        var remaining = input

        while !remaining.isEmpty {
            if remaining.hasPrefix("~~"), let end = remaining.dropFirst(2).range(of: "~~") {
                let inner = String(remaining.dropFirst(2)[..<end.lowerBound])
                parts.append(Part(text: inner, strikethrough: true))
                remaining = String(remaining.dropFirst(2)[end.upperBound...])
            } else if remaining.hasPrefix("**"), let end = remaining.dropFirst(2).range(of: "**") {
                let inner = String(remaining.dropFirst(2)[..<end.lowerBound])
                parts.append(Part(text: inner, bold: true))
                remaining = String(remaining.dropFirst(2)[end.upperBound...])
            } else if remaining.hasPrefix("*"), let end = remaining.dropFirst(1).range(of: "*") {
                let inner = String(remaining.dropFirst(1)[..<end.lowerBound])
                parts.append(Part(text: inner, italic: true))
                remaining = String(remaining.dropFirst(1)[end.upperBound...])
            } else {
                let markers = ["~~", "**", "*"]
                var nextIdx = remaining.endIndex
                for marker in markers {
                    if let idx = remaining.range(of: marker)?.lowerBound, idx < nextIdx {
                        nextIdx = idx
                    }
                }
                parts.append(Part(text: String(remaining[..<nextIdx])))
                remaining = String(remaining[nextIdx...])
            }
        }
        return parts
    }
}
// MARK: - Presigned URL 이미지
struct PresignedImageView: View {
    let s3Key: String
    @State private var imageURL: URL? = nil
    @State private var isLoading = true
    @State private var isFailed = false

    var body: some View {
        Group {
            if let url = imageURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    case .failure:
                        failureView
                    case .empty:
                        ProgressView().frame(height: 120)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else if isFailed {
                failureView
            } else {
                ProgressView().frame(height: 120)
            }
        }
        .onAppear {
            guard imageURL == nil, !isFailed else { return }
            Task {
                do {
                    let url = try await UploadService.shared.getPresignedURL(s3Key: s3Key)
                    await MainActor.run { imageURL = URL(string: url) }
                } catch {
                    await MainActor.run { isFailed = true; isLoading = false }
                }
            }
        }
    }

    private var failureView: some View {
        Color(UIColor.systemGray5)
            .frame(height: 120)
            .cornerRadius(8)
            .overlay(Image(systemName: "photo").foregroundColor(.gray))
    }
}

#Preview {
    NavigationView {
        PostsDetailView(post: Post(
            id: 1, title: "샘플 질문", author: "작성자",
            category: .school, like: 5, createdAt: "2026-01-18",
            isAccepted: false, preview: "샘플", commentCount: 0,
            content: "**볼드** *이탈릭* ~~취소선~~", isLike: false, isAuthor: true, comments: []
        ))
        .environmentObject(PostsViewModel.shared)
    }
}
