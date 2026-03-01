//
//  ProfileAnsItem.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import SwiftUI

struct ProfileItem: View {
    var activity: Activity = .Answer
    var category: Category = .code
    var title : String = "질문 제목"
    var commentCount: Int = 10
    var answer: String = "답변 내용"
    var like: Int = 7
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            .foregroundStyle(.white)
            
            .frame(width: 300, height: 60)
            
            .overlay(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 60, height: 24)
                            .foregroundStyle(.sub.opacity(0.1))
                            .overlay {
                                Text(category.displayName)
                                    .font(.regular(14))
                                    .foregroundStyle(.sub)
                            }
                        switch activity {
                        case .Answer:
                            Text(answer)
                                .font(.semibold(16))
                        case .Question:
                            Text(title)
                                .font(.semibold(16))
                        }
                        
                        
                    }
                    .padding(0)
                    switch activity {
                    case .Answer:
                        HStack {
                            Image("대충 이미지")
                            Text(title)
                                .font(.regular(14))
                                .foregroundStyle(.gray)
                                .padding(.trailing,16)
                        }
                    case .Question:
                        HStack {
                            Image("like")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("유용해요 \(commentCount)")
                                .font(.regular(12))
                                .foregroundStyle(.gray)
                                .padding(.trailing,16)

                            
                            Image("answer")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("답변 수 \(like)")
                                .font(.regular(12))
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
    }
}

#Preview {
    ProfileItem()
}
