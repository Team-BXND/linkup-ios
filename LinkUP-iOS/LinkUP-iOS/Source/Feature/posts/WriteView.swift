//
//  WriteView.swift
//  LinkUP-iOS
//
import SwiftUI
import PhotosUI
import UIKit

// MARK: - UITextView 래퍼 (선택 영역 접근 + 포커스 콜백)
struct MarkdownTextEditor: UIViewRepresentable {
    @Binding var text: String
    var onTextViewReady: (UITextView) -> Void
    var onFocusChange: ((Bool) -> Void)? = nil

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.textColor = UIColor.label
        onTextViewReady(textView)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            let selected = uiView.selectedRange
            uiView.text = text
            uiView.selectedRange = selected
        }
        uiView.textColor = UIColor.label
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onFocusChange: onFocusChange)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        var onFocusChange: ((Bool) -> Void)?

        init(text: Binding<String>, onFocusChange: ((Bool) -> Void)?) {
            _text = text
            self.onFocusChange = onFocusChange
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            onFocusChange?(true)
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            onFocusChange?(false)
        }
    }
}

// MARK: - WriteView
struct WriteView: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss

    var editPost: Post? = nil

    @State private var title = ""
    @State private var nickname = ""
    @State private var selectedCategory: Category? = nil
    @State private var content = ""
    @State private var showCategoryPicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var isUploadingImage = false
    @FocusState private var focusedField: Field?

    private let textViewRef = TextViewRef()

    enum Field { case title, nickname, content }

    private var isEditMode: Bool { editPost != nil }

    var body: some View {
        VStack(spacing: 0) {

            // ── 헤더
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.appPrimaryText)
                }
                Spacer()
                if isEditMode {
                    Text("글 수정").font(.semibold(16)).foregroundColor(.appPrimaryText)
                    Spacer()
                    Image(systemName: "xmark").foregroundColor(.clear)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 16)

            // ── 입력 필드
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    Text("Q")
                        .font(.bold(28))
                        .foregroundColor(Color("Main"))
                    TextField("제목을 입력하세요.", text: $title)
                        .font(.semibold(16))
                        .foregroundColor(.appPrimaryText)
                        .focused($focusedField, equals: .title)
                }
                .padding()
                .background(Color.appInputBackground)
                .cornerRadius(12)

                TextField("닉네임을 입력하세요.", text: $nickname)
                    .font(.semibold(16))
                    .foregroundColor(isEditMode ? .appSecondaryText : .appPrimaryText)
                    .padding()
                    .background(Color.appInputBackground)
                    .cornerRadius(12)
                    .focused($focusedField, equals: .nickname)
                    .disabled(isEditMode)

                Button(action: { showCategoryPicker = true }) {
                    HStack {
                        Text(selectedCategory?.displayName ?? "카테고리를 선택하세요.")
                            .font(.semibold(16))
                            .foregroundColor(selectedCategory == nil ? .appSecondaryText : .appPrimaryText)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.appSecondaryText)
                    }
                    .padding()
                    .background(Color.appInputBackground)
                    .cornerRadius(12)
                }
                .confirmationDialog("카테고리 선택", isPresented: $showCategoryPicker) {
                    ForEach(Category.allCases) { category in
                        Button(category.displayName) { selectedCategory = category }
                    }
                    Button("취소", role: .cancel) {}
                }

                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("본문을 입력하세요")
                            .font(.medium(16))
                            .foregroundColor(.appPlaceholder)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .allowsHitTesting(false)
                    }
                    MarkdownTextEditor(text: $content) { textView in
                        textViewRef.textView = textView
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.appInputBackground)
                .cornerRadius(12)
                .overlay(
                    Group {
                        if isUploadingImage {
                            ZStack {
                                Color.black.opacity(0.3).cornerRadius(12)
                                VStack(spacing: 8) {
                                    ProgressView().tint(.white)
                                    Text("이미지 업로드 중...")
                                        .font(.medium(14))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                )
            }
            .padding(.horizontal, 24)

            // ── 하단 툴바
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 16) {
                    Button(action: { applyMarkdown(prefix: "**", suffix: "**") }) {
                        Text("B").bold().foregroundColor(.appSecondaryText).frame(width: 28, height: 28)
                    }
                    Button(action: { applyMarkdown(prefix: "*", suffix: "*") }) {
                        Text("I").italic().foregroundColor(.appSecondaryText).frame(width: 28, height: 28)
                    }
                    Button(action: { applyMarkdown(prefix: "~~", suffix: "~~") }) {
                        Text("S").strikethrough().foregroundColor(.appSecondaryText).frame(width: 28, height: 28)
                    }
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Image(systemName: "photo").foregroundColor(.appSecondaryText)
                    }
                    Spacer()
                    Button(action: { isEditMode ? submitEdit() : submitPost() }) {
                        Text(isEditMode ? "수정하기" : "질문하기")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color("Main"))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Color.appSecondaryBackground)
            }
        }
        .background(Color.appBackground)
        .alert("입력 확인", isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .onChange(of: selectedPhoto) { _, newItem in
            guard let newItem else { return }
            Task { await uploadImage(item: newItem) }
        }
        .onAppear {
            if let post = editPost {
                title = post.title
                nickname = post.author
                selectedCategory = post.category
                content = post.content ?? ""
            }
        }
    }

    // MARK: - 마크다운 적용
    private func applyMarkdown(prefix: String, suffix: String) {
        guard let textView = textViewRef.textView else {
            content += "\(prefix)텍스트\(suffix)"
            return
        }
        let selectedRange = textView.selectedRange
        let nsText = textView.text as NSString

        if selectedRange.length > 0 {
            let selected = nsText.substring(with: selectedRange)
            let replaced = "\(prefix)\(selected)\(suffix)"
            textView.replace(textView.selectedTextRange!, withText: replaced)
            content = textView.text
            let newLocation = selectedRange.location + prefix.count + selectedRange.length + suffix.count
            textView.selectedRange = NSRange(location: newLocation, length: 0)
        } else {
            let placeholder = "텍스트"
            let insertion = "\(prefix)\(placeholder)\(suffix)"
            textView.replace(textView.selectedTextRange!, withText: insertion)
            content = textView.text
            let newLocation = selectedRange.location + prefix.count + placeholder.count
            textView.selectedRange = NSRange(location: newLocation, length: 0)
        }
    }

    // MARK: - 이미지 업로드
    private func uploadImage(item: PhotosPickerItem) async {
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
                content += "![](\(s3key))"
                isUploadingImage = false
                selectedPhoto = nil
            }
        } catch {
            await MainActor.run {
                alertMessage = "이미지 업로드에 실패했어요."
                showAlert = true
                isUploadingImage = false
                selectedPhoto = nil
            }
        }
    }

    // MARK: - 새 글 작성
    private func submitPost() {
        guard !title.isEmpty else { alertMessage = "제목을 입력해주세요."; showAlert = true; return }
        guard !nickname.isEmpty else { alertMessage = "닉네임을 입력해주세요."; showAlert = true; return }
        guard let category = selectedCategory else { alertMessage = "카테고리를 선택해주세요."; showAlert = true; return }
        guard !content.isEmpty else { alertMessage = "본문을 입력해주세요."; showAlert = true; return }
        viewModel.createPost(category: category, title: title, content: content, author: nickname)
        dismiss()
    }

    // MARK: - 글 수정
    private func submitEdit() {
        guard !title.isEmpty else { alertMessage = "제목을 입력해주세요."; showAlert = true; return }
        guard let category = selectedCategory else { alertMessage = "카테고리를 선택해주세요."; showAlert = true; return }
        guard !content.isEmpty else { alertMessage = "본문을 입력해주세요."; showAlert = true; return }
        guard let post = editPost else { return }
        viewModel.updatePost(id: post.id, category: category, title: title, content: content, author: nickname)
        dismiss()
    }
}

// MARK: - UITextView 참조 홀더
final class TextViewRef {
    weak var textView: UITextView?
}

#Preview {
    WriteView().environmentObject(PostsViewModel.shared)
}
