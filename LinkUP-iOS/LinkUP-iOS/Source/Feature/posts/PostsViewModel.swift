//
//  PostsViewModel.swift
//  LinkUP-iOS
//
//  Created by chanwoo on 1/12/26.
//

import Combine

class PostsViewModel: ObservableObject {
    // 메인 화면 상태
    @Published var posts: [Post] = []
    @Published var selectedTab: TabCase = .hot
    @Published var selectedCategory: Category? = nil
    
    // 상세 화면 상태
    @Published var selectedPost: Post?
    
    static let shared = PostsViewModel()
    
    init() {
        loadSampleData()
    }
    
    // 필터링된 게시글
    var filteredPosts: [Post] {
        if let category = selectedCategory {
            return posts.filter { $0.category == category }
        }
        return posts
    }
    
    // 샘플 데이터 로드
    func loadSampleData() {
        posts = [
            Post(
                id: 1,
                title: "React에서 무한 렌더링 오류",
                author: "사랑하게될거야",
                category: .code,
                like: 10,
                createdAt: "2026-01-01",
                isAccepted: true,
                preview: "안녕하세요! 현재 프론트엔드 개발자를 꿈꾸며 리액트를 공부하고 있는 고등학생입니다...",
                commentCount: 8,
                content: """
안녕하세요! 현재 프론트엔드 개발자를 꿈꾸며 리액트를 공부하고 있는 고등학생입니다.

최근 학교 동아리 프로젝트로 웹 서비스를 만들다가 도저히 이해가 안 가는 현상이 있어서 질문드립니다.

단순히 해결법만 아는 것보다, 내부에서 '왜' 이런 일이 일어나는지 정확한 라이프사이클 흐름을 이해하고 싶어서 글을 남깁니다.

1. 문제 상황 API에서 데이터를 받아와서 state에 저장하고 화면에 뿌려주는 기능을 구현하고 있었습니다.

그런데 코드를 실행하자마자 크롬 브라우저가 멈춰버리고, 콘솔에는 로그가 미친 듯이 찍히면서 결국 "Maximum update depth exceeded" 에러가 떴습니다.

2. 문제가 된 코드 대략적인 코드는 아래와 같습니다.

JavaScript
import React, { useState, useEffect } from 'react';
""",
                isLike: false,
                isAuthor: false,
                comments: [
                    Comment(
                        id: 1,
                        author: "Nickname",
                        content: """
작성자님이 3번 항목에서 시뮬레이션하신 과정이 정확히 리액트가 동작하는 방식입니다. 고등학생이신데 라이프사이클 흐름을 아주 잘 파악하고 계시네요!

이 현상을 **'Effect Chain'**이라고도 부르는데, 왜 브라우저가 뻗는지 그 범인을 콕 집어 설명해 드릴게요.

1. 범인은 바로 [count] (의존성 배열)

useEffect의 두 번째 인자인 의존성 배열(dependency array)은 "이 안에 있는 값이 변하면, useEffect를 다시 실행해!" 라는 명령입니다.
""",
                        isAccepted: true,
                        createdAt: "2026-01-01"
                    )
                ]
            ),
            Post(
                id: 2,
                title: "포트폴리오 준비는 어떻게 해야하나요?",
                author: "개발자지망생",
                category: .project,
                like: 10,
                createdAt: "2026-01-02",
                isAccepted: false,
                preview: "취업을 준비하면서 포트폴리오를 어떻게 구성해야 할지 고민입니다.",
                commentCount: 8,
                content: "취업을 준비하면서 포트폴리오를 어떻게 구성해야 할지 고민입니다.",
                isLike: false,
                isAuthor: false,
                comments: []
            ),
            Post(
                id: 3,
                title: "선배들과 친해지는 방법?",
                author: "신입생",
                category: .school,
                like: 10,
                createdAt: "2026-01-03",
                isAccepted: false,
                preview: "학교에서 선배들과 친해지고 싶은데 어떻게 해야 할까요?",
                commentCount: 8,
                content: "학교에서 선배들과 친해지고 싶은데 어떻게 해야 할까요?",
                isLike: false,
                isAuthor: false,
                comments: []
            )
        ]
    }
    
    // MARK: - API Methods
    
    // 게시글 목록 조회
    func fetchPosts(category: Category, page: Int = 1) {
        // TODO: API 호출
        // GET /posts?category={category}&page={page}
    }
    
    // 게시글 상세 조회
    func fetchPostDetail(id: Int) {
        // TODO: API 호출
        // GET /posts/{id}
    }
    
    // 게시글 작성
    func createPost(category: Category, title: String, content: String, author: String) {
        // TODO: API 호출
        // POST /posts
        let request = CreatePostRequest(
            category: category.apiValue,
            title: title,
            content: content,
            author: author
        )
    }
    
    // 게시글 수정
    func updatePost(id: Int, category: Category, title: String, content: String) {
        // TODO: API 호출
        // PATCH /posts/{id}
        let request = UpdatePostRequest(
            category: category.apiValue,
            title: title,
            content: content
        )
    }
    
    // 게시글 삭제
    func deletePost(id: Int) {
        // TODO: API 호출
        // DELETE /posts/{id}
    }
    
    // 답변 작성
    func createAnswer(postId: Int, content: String) {
        // TODO: API 호출
        // POST /posts/{id}/answer
        let request = CreateAnswerRequest(content: content)
    }
    
    // 답변 삭제
    func deleteAnswer(postId: Int, answerId: Int) {
        // TODO: API 호출
        // DELETE /posts/{id}/answer
    }
    
    // 답변 채택
    func acceptAnswer(postId: Int, answerId: Int) {
        // TODO: API 호출
        // POST /posts/{id}/accept/{ansid}
        let request = AcceptAnswerRequest(commentId: answerId)
    }
    
    // 유용해요 토글
    func toggleLike(postId: Int) {
        // TODO: API 호출
        // POST /posts/{id}/like
    }
    
    // MARK: - UI Methods
    
    // 게시글 선택
    func selectPost(_ post: Post) {
        selectedPost = post
    }
    
    // 카테고리 선택
    func selectCategory(_ category: Category?) {
        selectedCategory = category
    }
}
