//
//  WriteView.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/12/26.
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
    
    enum Field {
        case title, nickname, content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 헤더 (뒤로가기 버튼)
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
            
            // 입력 필드 그룹
            VStack(spacing: 12) {
                // 제목 입력
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
                
                // 닉네임 입력
                TextField("닉네임을 입력하세요.", text: $nickname)
                    .font(.semibold(16))
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .focused($focusedField, equals: .nickname)
                
                // 카테고리 선택
                Button(action: {
                    showCategoryPicker = true
                }) {
                    HStack {
                        Text(selectedCategory?.rawValue ?? "카테고리를 선택하세요.")
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
                .actionSheet(isPresented: $showCategoryPicker) {
                    ActionSheet(
                        title: Text("카테고리 선택"),
                        buttons: Category.allCases.map { category in
                            .default(Text(category.displayName)) {
                                selectedCategory = category
                            }
                        } + [.cancel(Text("취소"))]
                    )
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
            
            // 하단 툴바 및 버튼
            HStack(spacing: 12) {
                ForEach(["B", "I", "U", "S"], id: \.self) { label in
                    Button(action: {}) {
                        Text(label)
                            .font(.bold(18))
                            .foregroundColor(.gray)
                            .modifier(TextStyleModifier(style: label))
                    }
                }
                
                Button(action: {}) {
                    Image(systemName: "link")
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // 질문하기 버튼
                Button(action: {
                    // 빈 필드 검증
                    if title.isEmpty {
                        alertMessage = "제목을 입력해주세요."
                        showAlert = true
                        return
                    }
                    
                    if nickname.isEmpty {
                        alertMessage = "닉네임을 입력해주세요."
                        showAlert = true
                        return
                    }
                    
                    guard let category = selectedCategory else {
                        alertMessage = "카테고리를 선택해주세요."
                        showAlert = true
                        return
                    }
                    
                    if content.isEmpty {
                        alertMessage = "본문을 입력해주세요."
                        showAlert = true
                        return
                    }
                    
                    // 새 게시글 추가
                    viewModel.addPost(
                        title: title,
                        author: nickname,
                        category: category,
                        content: content
                    )
                    
                    dismiss()
                }) {
                    Text("질문하기")
                        .font(.medium(14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(Color("MainColor"))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(Color.white)
        }
        .background(Color.white)
        .alert("입력 확인", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}

// 텍스트 스타일 수정자
struct TextStyleModifier: ViewModifier {
    let style: String
    
    func body(content: Content) -> some View {
        switch style {
        case "I":
            content.italic()
        case "U":
            content.underline()
        case "S":
            content.strikethrough()
        default:
            content
        }
    }
}

#Preview {
    WriteView()
        .environmentObject(PostsViewModel())
}
// MARK: - Temporary shim to satisfy WriteView call site
// Remove or replace this when your real implementation exists in PostsViewModel.
extension PostsViewModel {
    @MainActor
    func addPost(title: String, author: String, category: Category, content: String) {
        // If your PostsViewModel already has an API to add posts, replace this body
        // to forward to it. This shim prevents dynamicMember/binding errors.
        NotificationCenter.default.post(
            name: Notification.Name("PostsViewModel.addPost"),
            object: nil,
            userInfo: [
                "title": title,
                "author": author,
                "category": category.rawValue,
                "content": content
            ]
        )
    }
}

