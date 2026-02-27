//
//  WriteView.swift
//  LinkUP-iOS
//
import SwiftUI

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
    @FocusState private var focusedField: Field?

    enum Field { case title, nickname, content }

    private var isEditMode: Bool { editPost != nil }

    var body: some View {
        VStack(spacing: 0) {

            // ── 헤더 ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.primary)
                }
                Spacer()
                if isEditMode {
                    Text("글 수정").font(.semibold(16))
                    Spacer()
                    Image(systemName: "xmark").foregroundColor(.clear)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 16)

            // ── 입력 필드 ──────────────────────────────────────────
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    Text("Q")
                        .font(.bold(28))
                        .foregroundColor(Color("MainColor"))
                    TextField("제목을 입력하세요.", text: $title)
                        .font(.semibold(16))
                        .focused($focusedField, equals: .title)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)

                TextField("닉네임을 입력하세요.", text: $nickname)
                    .font(.semibold(16))
                    .foregroundColor(isEditMode ? .gray.opacity(0.5) : .gray)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .focused($focusedField, equals: .nickname)
                    .disabled(isEditMode)

                Button(action: { showCategoryPicker = true }) {
                    HStack {
                        Text(selectedCategory?.displayName ?? "카테고리를 선택하세요.")
                            .font(.semibold(16))
                            .foregroundColor(selectedCategory == nil ? .gray : .primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
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
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    TextEditor(text: $content)
                        .font(.medium(16))
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                        .focused($focusedField, equals: .content)
                        .scrollContentBackground(.hidden)
                }
                .frame(maxHeight: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
            }
            .padding(.horizontal, 24)

            // ── 하단 툴바 ─────────────────────────────────────────
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 16) {
                    Button(action: {}) { Text("B").bold().foregroundColor(.gray).frame(width: 28, height: 28) }
                    Button(action: {}) { Text("I").italic().foregroundColor(.gray).frame(width: 28, height: 28) }
                    Button(action: {}) { Text("S").strikethrough().foregroundColor(.gray).frame(width: 28, height: 28) }
                    Button(action: {}) { Image(systemName: "link").foregroundColor(.gray) }
                    Button(action: {}) { Image(systemName: "photo").foregroundColor(.gray) }
                    Spacer()
                    Button(action: { isEditMode ? submitEdit() : submitPost() }) {
                        Text(isEditMode ? "수정하기" : "질문하기")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color("MainColor"))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .alert("입력 확인", isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(alertMessage)
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

    private func submitPost() {
        guard !title.isEmpty else { alertMessage = "제목을 입력해주세요."; showAlert = true; return }
        guard !nickname.isEmpty else { alertMessage = "닉네임을 입력해주세요."; showAlert = true; return }
        guard let category = selectedCategory else { alertMessage = "카테고리를 선택해주세요."; showAlert = true; return }
        guard !content.isEmpty else { alertMessage = "본문을 입력해주세요."; showAlert = true; return }
        viewModel.createPost(category: category, title: title, content: content, author: nickname)
        dismiss()
    }

    private func submitEdit() {
        guard !title.isEmpty else { alertMessage = "제목을 입력해주세요."; showAlert = true; return }
        guard let category = selectedCategory else { alertMessage = "카테고리를 선택해주세요."; showAlert = true; return }
        guard !content.isEmpty else { alertMessage = "본문을 입력해주세요."; showAlert = true; return }
        guard let post = editPost else { return }
        viewModel.updatePost(id: post.id, category: category, title: title, content: content, author: nickname)
        dismiss()
    }
}

#Preview {
    WriteView().environmentObject(PostsViewModel.shared)
}
