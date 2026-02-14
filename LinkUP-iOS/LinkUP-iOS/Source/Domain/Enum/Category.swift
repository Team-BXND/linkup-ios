//
//  Category.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//




import Foundation

enum Category: String, CaseIterable, Identifiable, Codable {
    case all = "all"
    case school = "school"
    case code = "code"
    case project = "project"
        
    var id: String { self.rawValue }
        
    var displayName: String {
        switch self {
        case .all: return "전체"
        case .school: return "학교생활"
        case .code: return "코드"
        case .project: return "프로젝트"
        }
    }
    
    // API 요청용 값
    var apiValue: String {
        switch self {
        case .all: return "all"
        case .school: return "school"
        case .code: return "code"
        case .project: return "project"
        }
    }
    
    var image: String {
        switch self {
        case .all: ""
        case .school: "School"
        case .code: "Code"
        case .project: "Project"
        }
    }
}
