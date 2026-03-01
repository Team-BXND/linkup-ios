//
//  additionInfoView.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import SwiftUI

struct UserActivityView: View {
    @Binding var activity: Activity
    @Binding var status: ProfileStatus
    @EnvironmentObject var VM: ProfileViewModel
    @State var ispresent = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        status = .info
                    } label: {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .shadow(radius: 2)
                            .overlay {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.black)
                            }
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 330, height: 660)
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                    .overlay {
                        VStack {
                            HStack {
                                Text(activity.rawValue)
                                    .font(.bold(20))
                                    .padding(.leading, 16)
                                Spacer()
                            }
                            .padding(.bottom, 20)
                            ScrollView(showsIndicators: false) {
                                LazyVStack {
                                    ForEach(VM.userActivity.data, id: \.self) { item in
                                        ProfileItem(activity: activity, category: item.category, title: item.title, commentCount: item.commentCount ?? 0, answer: item.answer ?? "", like: item.like ?? 0, ispresent: $ispresent) {
                                        }
                                        .onAppear {
                                            if item == VM.userActivity.data.last && VM.userActivity.meta.hasNext == true {
                                                Task {
                                                    await VM.fetchUserActivity(type: activity)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                
                            }
                        }.padding(.top, 16)
                    }
            }
            .task(id: activity) {
                // isRefresh: true를 넘겨서 무조건 첫 페이지(0)부터 다시 불러오도록 강제합니다.
                await VM.fetchUserActivity(type: activity, isRefresh: true)
            }
            .padding(.horizontal,16)
        }
    }
}


