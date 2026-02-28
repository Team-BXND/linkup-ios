//
//  TabManager.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 2/28/26.
//

import SwiftUI
import Combine

enum TabPage: Int {
    case popular
    case posts
    case ranking
    case profile
}

class TabManager: ObservableObject {
    @Published var selectedTab: TabPage = .popular
}
