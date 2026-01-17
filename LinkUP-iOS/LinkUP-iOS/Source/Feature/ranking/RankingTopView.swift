//
//  RankingTopView.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI

struct RankingTopView: View {
    let user: RankingModel
    let rankIndex: Int

    private var style: RankStyle {
        RankStyle.style(for: rankIndex)
    }

    private var isFirst: Bool {
        rankIndex == 0
    }

    private var highlightColor: Color {
        isFirst ? .blue : .primary
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(style.imageName)
                .resizable()
                .frame(width: style.imageSize, height: style.imageSize)

            HStack(spacing: 8) {
                Text(style.imageName)
                    .font(.semibold(16))
                    .foregroundColor(highlightColor)
                
                Text(user.username)
                    .font(style.nameFont)
                    .foregroundColor(highlightColor)

                Text("\(user.point)P")
                    .font(style.pointFont)
            }
        }
    }
}
