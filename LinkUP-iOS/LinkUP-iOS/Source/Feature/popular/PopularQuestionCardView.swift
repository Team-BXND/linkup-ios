//
//  PopularQuestionView.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/14/26.
//

import SwiftUI

struct PopularQuestionCardView: View {
    let popular: PopularModel
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text("\(popular.id)")
                .font(.semibold(16))
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 8) {
                Text(popular.title)
                    .font(.semibold(16))
                    .foregroundColor(.black)

                HStack(spacing: 4) {
                    Text(popular.category.rawValue)
                        .font(.regular(12))
                        .foregroundColor(.gray)
                    
                    Text("\(popular.author) 님")
                        .font(.regular(12))
                        .foregroundColor(.gray)
                    
                    Text("유용해요 \(popular.like)")
                        .font(.regular(12))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.leading, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    popular.isAccepted ? Color.blue : Color.gray.opacity(0.3)
                )
        )
    }
}
