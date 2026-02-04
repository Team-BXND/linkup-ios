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
    
    private func loadPopularSampleData() {
        populars = [
            PopularDataInfo(
                id: 1,
                title: "React에서 무한 렌더링 오류",
                author: "사랑해요",
                category: .code,
                like: 8,
                preview: "useEffect를 사용하는데 렌더링이 계속 반복됩니다.",
                isAccepted: true,
                commentCount: 3,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 2,
                title: "포트폴리오 준비는 어떻게 해야 하나요?",
                author: "사랑해요",
                category: .school,
                like: 6,
                preview: "취업용 포트폴리오를 어떻게 구성해야 할지 고민입니다.",
                isAccepted: false,
                commentCount: 2,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 3,
                title: "선배들과 친해지는 방법?",
                author: "사랑해요",
                category: .school,
                like: 4,
                preview: "선배들과 자연스럽게 친해지고 싶어요.",
                isAccepted: false,
                commentCount: 1,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 4,
                title: "프로젝트 기획은 어떻게 하나요? ㅠㅠㅠㅠ",
                author: "사랑해요",
                category: .project,
                like: 2,
                preview: "아이디어부터 막막합니다.",
                isAccepted: false,
                commentCount: 0,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 5,
                title: "프로젝트 기획은 어떻게 하나요? ㅠㅠㅠㅠ",
                author: "사랑해요",
                category: .project,
                like: 1,
                preview: "아이디어부터 막막합니다.",
                isAccepted: false,
                commentCount: 0,
                createdAt: Date()
            )
        ]
    }
    
    private func loadHotPopularSampleData() {
        hotPopulars = [
            PopularDataInfo(
                id: 10,
                title: "이번 주 가장 핫한 질문!",
                author: "핫이슈",
                category: .code,
                like: 25,
                preview: "이번 주에 가장 많은 유용해요를 받은 질문입니다.",
                isAccepted: true,
                commentCount: 15,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 11,
                title: "최근 트렌드 기술은?",
                author: "테크리더",
                category: .project,
                like: 20,
                preview: "요즘 핫한 기술 스택이 궁금합니다.",
                isAccepted: true,
                commentCount: 12,
                createdAt: Date()
            ),
            PopularDataInfo(
                id: 12,
                title: "학교 생활 꿀팁 공유해요!",
                author: "선배님",
                category: .school,
                like: 18,
                preview: "신입생들을 위한 꿀팁 모음입니다.",
                isAccepted: false,
                commentCount: 8,
                createdAt: Date()
            )
        ]
    }
    
    func fetchPopular(page: Int = 1) {
        Task {
            do {
                let response = try await service.fetchPopular(type: .popular, page: page)
                self.populars = response.data
            } catch {
                print("인기 질문 페치 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchHotPopular(page: Int = 1) {
        Task {
            do {
                let response = try await service.fetchPopular(type: .popularhot, page: page)
                self.hotPopulars = response.data
            } catch {
                print("핫 질문 페치 실패: \(error.localizedDescription)")
            }
        }
    }
    
}
