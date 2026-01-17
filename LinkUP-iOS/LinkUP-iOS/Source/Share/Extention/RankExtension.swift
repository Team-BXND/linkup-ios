//
//  RankExtension.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/16/26.
//

import SwiftUI

struct RankStyle {
    let imageName: String
    let imageSize: CGFloat
    let nameFont: Font
    let pointFont: Font
}

extension RankStyle {
    static func style(for index: Int) -> RankStyle {
        switch index {
        case 0:
            return RankStyle(
                imageName: "1st",
                imageSize: 50,
                nameFont: .system(size: 28, weight: .bold),
                pointFont: .system(size: 16, weight: .medium)
            )

        case 1:
            return RankStyle(
                imageName: "2st",
                imageSize: 40,
                nameFont: .system(size: 24, weight: .bold),
                pointFont: .system(size: 12, weight: .medium)
            )

        case 2:
            return RankStyle(
                imageName: "3st",
                imageSize: 40,
                nameFont: .system(size: 24, weight: .bold),
                pointFont: .system(size: 12, weight: .medium)
            )

        default:
            return RankStyle(
                imageName: "",
                imageSize: 40,
                nameFont: .body,
                pointFont: .body
            )
        }
    }
}
