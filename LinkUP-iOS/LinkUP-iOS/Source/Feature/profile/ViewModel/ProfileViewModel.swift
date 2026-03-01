import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var userInfo: UserInfo = UserInfo(username: "", email: "", point: 1, ranking: 1)
    @Published var userActivity: UserActivity = UserActivity(data: [], meta: PageMeta(total: 0, page: 0, pageSize: 0, totalPages: 0, hasNext: true, hasPrevious: true))
    
    var authmanager: AuthManager?
    
    
    // ✅ 중복 API 호출 방지용 플래그
    @Published var isLoading = false
    
    @MainActor
    func fetchUserInfo() async {
        do {
            let response = try await ProfileService.shared.fetchUserInfo()
            userInfo = response.data
            print(userInfo)
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
    
    // ✅ UI 업데이트를 위해 @MainActor 추가
    @MainActor
    func fetchUserActivity(type: Activity, isRefresh: Bool = false) async {
        // 1. 이미 로딩 중이면 중복 요청 안 함
        guard !isLoading else { return }
        
        // 2. 새로고침이 아니고, 다음 페이지가 없으면 요청 안 함 (로그를 보니 hasNext가 false면 끝입니다)
        if !isRefresh && !userActivity.meta.hasNext { return }
        
        isLoading = true
        
        do {
            // 3. 페이지 번호 계산 (API가 0부터 시작하므로 새로고침은 0, 추가 로드는 현재 페이지 + 1)
            let nextPage = isRefresh ? 0 : userActivity.meta.page + 1
            
            let response = try await ProfileService.shared.fetchUserActivity(type: type, page: nextPage)
            print("불러온 페이지: \(nextPage)번째, 데이터 개수: \(response.data.count)")
            
            // 4. 데이터 갱신
            if isRefresh {
                userActivity.data = response.data // 처음부터 다시 불러올 때
            } else {
                userActivity.data.append(contentsOf: response.data) // 기존 데이터에 이어 붙일 때
            }
            userActivity.meta = response.meta
            
        } catch {
            print("에러: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func logout() {
            AuthManager.shared.logout()
        }
}
