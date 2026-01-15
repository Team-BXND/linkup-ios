//
//  PopularViewModel.swift
//  LinkUP-iOS
//
//  Created by 잇쬬 on 1/14/26.
//
import SwiftUI
import Combine

@MainActor
final class PopularQuestionViewModel: ObservableObject {

    @Published var populars: [PopularModel] = []

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        populars = [
            PopularModel(
                id: 1,
                title: "React에서 무한 렌더링 오류",
                author: "사랑해요",
                category: .code,
                like: 8,
                preview: "useEffect를 사용하는데 렌더링이 계속 반복됩니다.",
                isAccepted: true,
                commentCount: 3,
                createdAt: "2025-01-01"
            ),
            PopularModel(
                id: 2,
                title: "포트폴리오 준비는 어떻게 해야 하나요?",
                author: "사랑해요",
                category: .school,
                like: 6,
                preview: "취업용 포트폴리오를 어떻게 구성해야 할지 고민입니다.",
                isAccepted: false,
                commentCount: 2,
                createdAt: "2025-01-02"
            ),
            PopularModel(
                id: 3,
                title: "선배들과 친해지는 방법?",
                author: "사랑해요",
                category: .school,
                like: 4,
                preview: "선배들과 자연스럽게 친해지고 싶어요.",
                isAccepted: false,
                commentCount: 1,
                createdAt: "2025-01-03"
            ),
            PopularModel(
                id: 4,
                title: "프로젝트 기획은 어떻게 하나요? ㅠㅠㅠㅠ",
                author: "사랑해요",
                category: .project,
                like: 2,
                preview: "아이디어부터 막막합니다.",
                isAccepted: false,
                commentCount: 0,
                createdAt: "2025-01-04"
            ),
            PopularModel(
                id: 5,
                title: "프로젝트 기획은 어떻게 하나요? ㅠㅠㅠㅠ",
                author: "사랑해요",
                category: .project,
                like: 1,
                preview: "아이디어부터 막막합니다.",
                isAccepted: false,
                commentCount: 0,
                createdAt: "2025-01-05"
            )
        ]
    }
}
