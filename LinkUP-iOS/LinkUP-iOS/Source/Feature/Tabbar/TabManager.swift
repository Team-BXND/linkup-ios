//
//  TabManager.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 2/28/26.
//

import SwiftUI
import Combine

enum TabPage: Int {
    case popular = 0
    case posts = 1
    case ranking = 2
    case profile = 3
}

class TabManager: ObservableObject {
    @Published var selectedTab: TabPage = .popular
}
