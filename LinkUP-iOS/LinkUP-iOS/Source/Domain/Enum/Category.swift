//
//  Category.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//




import Foundation

enum Category: String, CaseIterable, Identifiable, Codable {
    case all = "전체"

    case school = "학교생활"
    case code = "코드"
    case project = "프로젝트"
    
    var id: String { self.rawValue }
    
    // API 요청용 값
    var apiValue: String {
        switch self {
        case .all: return "all"
        case .school: return "school"
        case .code: return "code"
        case .project: return "project"
        }
    }
}
