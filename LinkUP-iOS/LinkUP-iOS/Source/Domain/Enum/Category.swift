//
//  Category.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import Foundation

enum Category: String, CaseIterable, Identifiable, Codable {
    case school  = "school"    // ✅ rawValue를 서버 API값(영어)으로 변경
    case code    = "code"
    case project = "project"

    var id: String { self.rawValue }

    // 화면 표시용 한국어
    var displayName: String {
        switch self {
        case .school:  return "학교생활"
        case .code:    return "코드"
        case .project: return "프로젝트"
        }
    }

    // API 전송용 (rawValue와 동일)
    var apiValue: String { self.rawValue }

    var image: String {
        switch self {
        case .school:  return "School"
        case .code:    return "Code"
        case .project: return "Project"
        }
    }
}
