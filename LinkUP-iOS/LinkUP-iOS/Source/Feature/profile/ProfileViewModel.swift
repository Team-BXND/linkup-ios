//
//  ProfileViewModel.swift
//  LinkUP-iOS
//
//  Created by maple on 2/2/26.
//

import Foundation

@Observable

class ProfileViewModel {
    
    var userInfo: UserInfo = UserInfo(username: "", email: "", point: 1, ranking: 1)
    
    var userActivity: UserActivity = UserActivity(data: [], meta: PageMeta(total: 0, page: 0, pageSize: 0, totalPages: 0, hasNext: true, hasPrevious: true))
    
    
    @MainActor
    func fetchUserInfo() async {
        do {
            let response = try await ProfileService.shared.fetchUserInfo()
            print(userInfo)
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
    
    func fetchUserActivity(type: Activity) async {
        do {
            let response = try await ProfileService.shared.fetchUserActivity(type: type, page: userActivity.meta.page + 1)
            print(response)
            userActivity.data.append(contentsOf: response.data)
            userActivity.meta = response.meta
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
}
