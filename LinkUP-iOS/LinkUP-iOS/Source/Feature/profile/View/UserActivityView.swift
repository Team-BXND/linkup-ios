//
//  UserActivityView.swift
//  LinkUP-iOS
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
                            .foregroundStyle(Color.appSecondaryBackground)
                            .frame(width: 40, height: 40)
                            .shadow(radius: 2)
                            .overlay {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(Color.appPrimaryText)
                            }
                    }
                    Spacer()
                }

                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 330, height: 660)
                    .foregroundStyle(Color.appSecondaryBackground)
                    .shadow(radius: 3)
                    .overlay {
                        VStack {
                            HStack {
                                Text(activity.rawValue)
                                    .font(.bold(20))
                                    .foregroundColor(.appPrimaryText)
                                    .padding(.leading, 16)
                                Spacer()
                            }
                            .padding(.bottom, 20)

                            ScrollView(showsIndicators: false) {
                                LazyVStack {
                                    ForEach(VM.userActivity.data, id: \.self) { item in
                                        ProfileItem(
                                            activity: activity,
                                            category: item.category,
                                            title: item.title,
                                            commentCount: item.commentCount ?? 0,
                                            answer: item.answer ?? "",
                                            like: item.like ?? 0,
                                            ispresent: $ispresent
                                        ) {}
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
                        .padding(.top, 16)
                    }
            }
            .task(id: activity) {
                await VM.fetchUserActivity(type: activity, isRefresh: true)
            }
            .padding(.horizontal, 16)
        }
    }
}
