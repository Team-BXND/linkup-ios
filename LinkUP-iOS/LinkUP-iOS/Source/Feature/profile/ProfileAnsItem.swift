//
//  ProfileAnsItem.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import SwiftUI

struct ProfileAnsItem: View {
    var category: Category = .code
    var title : String = "제목"
    var answer: Int = 10
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
                                Text(category.rawValue)
                                    .font(.regular(14))
                                    .foregroundStyle(.sub)
                            }
                        Text(title)
                            .font(.semibold(16))
                        
                    }
                    .padding(0)
                    
                    HStack {
                        Image("like")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text("유용해요 \(answer)")
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
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
    }
}
#Preview {
    ProfileAnsItem()
}
