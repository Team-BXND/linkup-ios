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
    @State private var selectedCategory = ""
    @State private var content = ""
    @State private var showCategoryPicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @FocusState private var focusedField: Field?
    
    let categories = ["학교생활", "코드", "프로젝트"]
    
    enum Field {
        case title, nickname, content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 헤더 (뒤로가기 버튼)
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
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
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color("MainColor"))
                    
                    TextField("제목을 입력하세요.", text: $title)
                        .font(.system(size: 16, weight: .semibold))
                        .focused($focusedField, equals: .title)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                
                // 닉네임 입력
                TextField("닉네임을 입력하세요.", text: $nickname)
                    .font(.system(size: 16, weight: .semibold))
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
                        Text(selectedCategory.isEmpty ? "카테고리를 선택하세요." : selectedCategory)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(selectedCategory.isEmpty ? .gray : .primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                }
                .actionSheet(isPresented: $showCategoryPicker) {
                    ActionSheet(
                        title: Text("카테고리 선택"),
                        buttons: categories.map { category in
                            .default(Text(category)) {
                                selectedCategory = category
                            }
                        } + [.cancel(Text("취소"))]
                    )
                }
                
                // 본문 입력
                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("본문을 입력하세요")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                    TextEditor(text: $content)
                        .font(.system(size: 16))
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
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                            .modifier(TextStyleModifier(style: label))
                    }
                }
                
                Button(action: {}) {
                    Image(systemName: "link")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "photo")
                        .font(.system(size: 18))
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
                    
                    if selectedCategory.isEmpty {
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
                        category: selectedCategory,
                        content: content
                    )
                    
                    dismiss()
                }) {
                    Text("질문하기")
                        .font(.system(size: 14, weight: .medium))
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
