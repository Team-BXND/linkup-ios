//
//  WriteView.swift
//  LinkUP-iOS
//
import SwiftUI

struct WriteView: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var nickname = ""
    @State private var selectedCategory: Category? = nil
    @State private var content = ""
    @State private var showCategoryPicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @FocusState private var focusedField: Field?

    enum Field { case title, nickname, content }

    var body: some View {
        VStack(spacing: 0) {
            // ── 헤더 ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.bold(20))
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            .padding(.bottom, 12)

            // ── 입력 필드 ──────────────────────────────────────────
            VStack(spacing: 12) {
                // 제목
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

                // 닉네임
                TextField("닉네임을 입력하세요.", text: $nickname)
                    .font(.semibold(16))
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .focused($focusedField, equals: .nickname)

                // 카테고리 선택
                Button(action: { showCategoryPicker = true }) {
                    HStack {
                        Text(selectedCategory?.displayName ?? "카테고리를 선택하세요.")
                            .font(.semibold(16))
                            .foregroundColor(selectedCategory == nil ? .gray : .primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.semibold(14))
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

                // 본문 입력
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
            .padding(.horizontal, 32)

            Spacer()

            // ── 하단 툴바 ─────────────────────────────────────────
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Text("B").bold().foregroundColor(.gray).frame(width: 28, height: 28)
                    }
                    Button(action: {}) {
                        Text("I").italic().foregroundColor(.gray).frame(width: 28, height: 28)
                    }
                    Button(action: {}) {
                        Text("U").underline().foregroundColor(.gray).frame(width: 28, height: 28)
                    }
                    Button(action: {}) {
                        Text("S").strikethrough().foregroundColor(.gray).frame(width: 28, height: 28)
                    }
                    Button(action: {}) {
                        Image(systemName: "link").foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Image(systemName: "photo").foregroundColor(.gray)
                    }

                    Spacer()

                    // ✅ .system 폰트로 변경 → 텍스트 확실히 표시
                    Button(action: { submitPost() }) {
                        Text("질문하기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color("MainColor"))
                            .cornerRadius(10)
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
    }

    // MARK: - Submit
    private func submitPost() {
        guard !title.isEmpty else { alertMessage = "제목을 입력해주세요."; showAlert = true; return }
        guard !nickname.isEmpty else { alertMessage = "닉네임을 입력해주세요."; showAlert = true; return }
        guard let category = selectedCategory else { alertMessage = "카테고리를 선택해주세요."; showAlert = true; return }
        guard !content.isEmpty else { alertMessage = "본문을 입력해주세요."; showAlert = true; return }

        viewModel.createPost(category: category, title: title, content: content, author: nickname)
        dismiss()
    }
}

#Preview {
    WriteView().environmentObject(PostsViewModel.shared)
}
