//
//  PostsDetailView.swift
//  LinkUP-iOS
//
import SwiftUI
import PhotosUI

struct PostsDetailView: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss
    let post: Post

    @State private var answerText = ""
    @State private var showDeleteAlert = false
    @State private var showEditView = false
    @State private var showAcceptAlert = false
    @State private var acceptCommentId: Int? = nil
    @State private var isAnswerFocused: Bool = false

    // WriteView 스타일 마크다운 + 이미지 지원
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var isUploadingImage = false
    private let answerTextViewRef = TextViewRef()
    @State private var savedSelection: NSRange? = nil

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
                            .foregroundColor(.appPrimaryText)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()

                        if displayPost.isAuthor != true {
                            Button(action: { viewModel.toggleLike(postId: displayPost.id) }) {
                                Image(systemName: (displayPost.isLike ?? false) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                    .font(.semibold(12))
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                                    .background((displayPost.isLike ?? false) ? Color("Main") : Color(UIColor.systemGray3))
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
                    .foregroundColor(.appSecondaryText)
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
                                .background(Color.appButtonInactive)
                                .foregroundColor(.appPrimaryText)
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
                            .foregroundColor(.appPrimaryText)
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
                                        .foregroundColor(.appPrimaryText)
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
                                    .foregroundColor(.appSecondaryText)
                                PostContentView(content: comment.content)
                            }
                            .padding(20)
                            .background(Color.appTertiaryBackground)
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

            // ── 댓글 입력 영역 (WriteView 스타일) ─────────────────
            if displayPost.isAuthor != true {
                VStack(spacing: 0) {
                    Divider()

                    // 마크다운 툴바 (포커스 시 노출)
                    if isAnswerFocused {
                        HStack(spacing: 20) {
                            Button(action: { applyMarkdown(prefix: "**", suffix: "**") }) {
                                Text("B")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.appSecondaryText)
                                    .frame(width: 28, height: 28)
                            }
                            Button(action: { applyMarkdown(prefix: "*", suffix: "*") }) {
                                Text("I")
                                    .font(.system(size: 15).italic())
                                    .foregroundColor(.appSecondaryText)
                                    .frame(width: 28, height: 28)
                            }
                            Button(action: { applyMarkdown(prefix: "~~", suffix: "~~") }) {
                                Text("S")
                                    .font(.system(size: 15))
                                    .strikethrough()
                                    .foregroundColor(.appSecondaryText)
                                    .frame(width: 28, height: 28)
                            }
                            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                                Image(systemName: "photo")
                                    .foregroundColor(.appSecondaryText)
                                    .frame(width: 28, height: 28)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.appTertiaryBackground)
                    }

                    // 텍스트 입력 + 전송 버튼
                    HStack(spacing: 10) {
                        ZStack(alignment: .leading) {
                            if answerText.isEmpty {
                                Text("따뜻한 댓글을 입력해주세요!")
                                    .font(.medium(14))
                                    .foregroundColor(.appPlaceholder)
                                    .padding(.horizontal, 14)
                                    .allowsHitTesting(false)
                            }
                            MarkdownTextEditor(text: $answerText, onTextViewReady: { textView in
                                answerTextViewRef.textView = textView
                            }, onFocusChange: { focused in
                                isAnswerFocused = focused
                                // 포커스 해제 직전 선택 영역 저장
                                if !focused, let tv = answerTextViewRef.textView {
                                    savedSelection = tv.selectedRange
                                }
                            })
                            .frame(height: 36)
                        }
                        .padding(.horizontal, 4)
                        .background(Color.appTertiaryBackground)
                        .cornerRadius(20)

                        Button(action: { submitAnswer() }) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                            ? Color(UIColor.systemGray3) : Color("Main"))
                                .clipShape(Circle())
                        }
                        .disabled(answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.appSecondaryBackground)
                }
            }
        }
        .background(Color.appBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").foregroundColor(.appPrimaryText)
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
        .onChange(of: selectedPhoto) { _, newItem in
            guard let newItem else { return }
            Task { await uploadAnswerImage(item: newItem) }
        }
        .onAppear {
            viewModel.selectPost(post)
            viewModel.fetchPostDetail(id: post.id)
        }
    }

    // MARK: - 선택 영역에 마크다운 적용
    private func applyMarkdown(prefix: String, suffix: String) {
        guard let textView = answerTextViewRef.textView else {
            answerText += "\(prefix)텍스트\(suffix)"
            return
        }
        textView.becomeFirstResponder()

        // 버튼 탭으로 포커스가 잠깐 해제됐을 때 저장해둔 선택 영역 복원
        let activeRange: NSRange
        if textView.selectedRange.length > 0 {
            activeRange = textView.selectedRange
        } else if let saved = savedSelection, saved.length > 0 {
            textView.selectedRange = saved
            activeRange = saved
        } else {
            activeRange = textView.selectedRange
        }
        savedSelection = nil

        let nsText = textView.text as NSString
        if activeRange.length > 0 {
            let selected = nsText.substring(with: activeRange)
            let replaced = "\(prefix)\(selected)\(suffix)"
            if let range = textView.selectedTextRange {
                textView.replace(range, withText: replaced)
            }
            answerText = textView.text
            let newLocation = activeRange.location + prefix.count + activeRange.length + suffix.count
            textView.selectedRange = NSRange(location: newLocation, length: 0)
        } else {
            let placeholder = "텍스트"
            let insertion = "\(prefix)\(placeholder)\(suffix)"
            if let range = textView.selectedTextRange {
                textView.replace(range, withText: insertion)
            }
            answerText = textView.text
            let newLocation = activeRange.location + prefix.count + placeholder.count
            textView.selectedRange = NSRange(location: newLocation, length: 0)
        }
    }

    // MARK: - 이미지 업로드 (댓글용)
    private func uploadAnswerImage(item: PhotosPickerItem) async {
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        await MainActor.run { isUploadingImage = true }
        do {
            guard let uiImage = UIImage(data: data) else { return }
            var quality: CGFloat = 0.8
            var compressed = uiImage.jpegData(compressionQuality: quality) ?? data
            while compressed.count > 1_000_000 && quality > 0.1 {
                quality -= 0.1
                compressed = uiImage.jpegData(compressionQuality: quality) ?? data
            }
            let fileName = "\(UUID().uuidString).jpeg"
            let s3key = try await UploadService.shared.uploadImage(data: compressed, fileName: fileName)
            await MainActor.run {
                answerText += "![](\(s3key))"
                isUploadingImage = false
                selectedPhoto = nil
            }
        } catch {
            await MainActor.run {
                isUploadingImage = false
                selectedPhoto = nil
            }
        }
    }

    // MARK: - 댓글 전송
    private func submitAnswer() {
        let trimmed = answerText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        viewModel.createAnswer(postId: displayPost.id, content: trimmed)
        answerText = ""
        answerTextViewRef.textView?.resignFirstResponder()
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
                    MarkdownTextView(text: str, fontSize: 15)
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
    var fontSize: CGFloat = 14

    var body: some View {
        parsedText
            .foregroundColor(.appPrimaryText)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
    }

    var parsedText: Text {
        var result = Text("")
        for part in parseMarkdown(text) {
            var t = Text(part.text).font(.system(size: fontSize))
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
        Color.appButtonInactive
            .frame(height: 120)
            .cornerRadius(8)
            .overlay(Image(systemName: "photo").foregroundColor(.appSecondaryText))
    }
}



#Preview {
    NavigationView {
        PostsDetailView(post: Post(
            id: 1, title: "샘플 질문", author: "작성자",
            category: .school, like: 5, createdAt: "2026-01-18",
            isAccepted: false, preview: "샘플", commentCount: 0,
            content: "**볼드** *이탈릭* ~~취소선~~", isLike: false, isAuthor: false, comments: []
        ))
        .environmentObject(PostsViewModel.shared)
    }
}
