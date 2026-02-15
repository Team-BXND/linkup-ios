//
//  AuthView.swift
//  LinkUP-iOS
//
//  Created by maple on 2/12/26.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @State var step: Int = 2
    var body: some View {
        switch step{
        case 1:
            SignupView(step: $step)
        case 2:
            LoginView(step: $step)
        case 3:
            EmailView(step: $step)
        case 4:
            CodeView(step: $step)
        case 5:
            PWView(step: $step)
            
        default:
            LoginView(step: $step)
        }
    }
}


#Preview {
    AuthView()
}
