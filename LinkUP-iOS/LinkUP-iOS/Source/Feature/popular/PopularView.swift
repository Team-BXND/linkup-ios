//
//  ShareView.swift
//  dodum-iOS
//
//  Created by maple on 9/27/25.
//

import SwiftUI

struct PopularView: View {
    @StateObject private var viewModel = PopularViewModel()
    @State private var selectedCategory: Category?
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("💬 대소고에서 궁금한 점이 있다면?")
                        .font(.semibold(18))
                        .padding(.top, 24)
                        .padding(.leading, 32)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Spacer().frame(height: 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Button(action: {
                                PostsViewModel.shared.selectedTab = .list
                                PostsViewModel.shared.selectCategory(.school)
                                selectedCategory = .school
                            }) {
                                Image("School")
                            }
                            Button(action: {
                                PostsViewModel.shared.selectedTab = .list
                                PostsViewModel.shared.selectCategory(.code)
                                selectedCategory = .code
                            }) {
                                Image("Code")
                            }
                            Button(action: {
                                PostsViewModel.shared.selectedTab = .list
                                PostsViewModel.shared.selectCategory(.project)
                                selectedCategory = .project
                            }) {
                                Image("Project")
                            }
                        }
                        .padding(.horizontal, 32)
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer().frame(height: 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🔥 지금 뜨거운 Q&A")
                            .font(.semibold(18))
                        
                        ForEach(viewModel.hotPopulars) { popular in
                            PopularQuestionCardView(popular: popular)
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.06), radius: 1, x: 2, y: 0)
                    .shadow(color: Color.black.opacity(0.06), radius: 1, x: -2, y: 0)
                    .shadow(color: Color.black.opacity(0.06), radius: 1, x: 0, y: 4)
                    .padding(.horizontal, 32)
                    
                    Spacer(minLength: 0)
                }
            }
            .navigationDestination(item: $selectedCategory) { category in
                PostsView()
            }
            .onAppear {
                viewModel.fetchPopular()
                viewModel.fetchHotPopular()
            }
        }
    }
}

#Preview {
    PopularView()
}
