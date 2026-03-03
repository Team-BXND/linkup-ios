//
//  RankingView.swift
//  LinkUP-iOS
//
import SwiftUI

struct RankingView: View {
    @StateObject private var viewModel = RankingViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 24) {
                    Text("🏆 답변자 랭킹")
                        .font(.bold(20))
                        .foregroundColor(.appPrimaryText)
                        .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.topRankings.indices, id: \.self) { index in
                            RankingTopView(user: viewModel.topRankings[index], rankIndex: index)
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 13)
                }
                .frame(maxWidth: .infinity)
                .background(Color.appSecondaryBackground)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: 2, y: 0)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: -2, y: 0)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 24) {
                    ForEach(0..<viewModel.rowRankings.count, id: \.self) { index in
                        let user = viewModel.rowRankings[index]
                        RankingRowView(user: user, rankIndex: index + 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(Color.appSecondaryBackground)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: 2, y: 0)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: -2, y: 0)
                .shadow(color: Color.black.opacity(0.06), radius: 1, x: 0, y: 4)
            }
            .padding(.horizontal, 32)
            .padding(.top, 24)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            viewModel.fetchRanking()
        }
    }
}

#Preview {
    RankingView()
}
