//
//  AuthButton.swift
//  LinkUP-iOS
//
//  Created by maple on 2/13/26.
//

import Foundation
import SwiftUI


struct AuthButton: View {
    let shape: shape
    let title: String
    var function: () -> Void
    var body: some View {
        Button {
            function()
        } label: {
            switch shape {
            case .fill:
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 330, height: 40)
                    .foregroundStyle(.sub)
                    .overlay {
                        Text(title)
                            .foregroundStyle(.white)
                            .font(.medium(20))
                    }
            case .empty:
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .frame(width: 330, height: 40)
                    .overlay {
                        Text(title)
                            .font(.medium(20))
                            .foregroundStyle(.sub)
                    }
            }
            
        }
    }
}

enum shape {
    case fill, empty
}

