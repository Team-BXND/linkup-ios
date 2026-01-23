//
//  PostsViewModel.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/12/26.
//

struct Post: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let date: String
    let helpfulCount: Int
    let answersCount: Int
    let content: String
    let answers: [Answer]
}

struct Answer: Identifiable {
    let id: Int
    let author: String
    let date: String
    let content: String
}
