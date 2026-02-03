//
//  RankingRowView.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI

struct RankingRowView: View {
    let user: RankingInfo
    var body: some View {
        HStack(spacing: 8) {
            Text("\(user.rank)등")
                .foregroundColor(Color(.main))
                .font(.semibold(16))

            Text(user.username)
                .font(.bold(20))

            Text("\(user.point)P")
                .font(.medium(16))
        }
    }
}
