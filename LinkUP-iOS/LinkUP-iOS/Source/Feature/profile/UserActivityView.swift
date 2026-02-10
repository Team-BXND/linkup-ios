//
//  additionInfoView.swift
//  LinkUP-iOS
//
//  Created by maple on 1/15/26.
//

import SwiftUI

struct UserActivityView: View {
    var activity: Activity
    @State var VM: ProfileViewModel
    var page = 0
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 330, height: 660)
                .foregroundStyle(.white)
                .shadow(radius: 3)
                .overlay {
                    VStack {
                        HStack {
                            Text(activity.rawValue)
                                .font(.bold(20))
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(VM.userActivity.data, id: \.id) { item in
                                    ProfileItem(activity: activity, category: item.category, title: item.title, commentCount: item.commentCount!, answer: item.answer!, like: item.like!)
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
                    }
                    .padding(.horizontal,16)
                    .padding(.top, 16)
                }
        }
    }
}

#Preview {
    UserActivityView(activity: .Question, VM:ProfileViewModel())
}
