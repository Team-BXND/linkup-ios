//
//  PopularViewModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/14/26.
//

import SwiftUI
import Combine

@MainActor
class PopularViewModel: ObservableObject {
    
    @Published var populars: [PopularDataInfo] = []
    @Published var hotPopulars: [PopularDataInfo] = []
    
    private let service = DiscoveryService.shared
    
    
    
    func fetchPopular(page: Int = 0) {
        Task {
            do {
                let response = try await service.fetchPopular(type: .popular, page: page)
                    
                if !response.data.isEmpty {
                    self.populars = response.data
                }
            } catch {
            }
        }
    }

    func fetchHotPopular(page: Int = 0) {
        Task {
            do {
                let response = try await service.fetchPopular(type: .popularhot, page: page)
                    
                if !response.data.isEmpty {
                    self.hotPopulars = response.data
                }
            } catch {
            }
        }
    }

}
