//
//  ProfileView.swift
//  LinkUP-iOS
//
//  Created by maple on 2/28/26.
//

import Foundation
import SwiftUI

enum ProfileStatus {
    case info, activity
}

struct ProfileView : View {
    @State var status: ProfileStatus = .info
    @State var activity: Activity = .Question
    @StateObject var VM = ProfileViewModel()

    var body: some View {
        Group {
            switch status {
            case .info:
                ProfileInfoView(status: $status, activity: $activity)
            case .activity:
                UserActivityView(activity: $activity, status: $status)
            }
        }
        .environmentObject(VM)
    }
}

