//
//  AuthManager.swift
//  LinkUP-iOS
//
//  Created by maple on 2/25/26.
//

import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isLogin = false
    
    static let shared = AuthManager()
    
    private init(){
        restoresession()
    }
    
    func logout() {
            // 토큰 제거
            UserDefaults.standard.removeObject(forKey: "access")
            UserDefaults.standard.removeObject(forKey: "refresh")
            self.isLogin = false
        }
    
    func restoresession() {
        let access = UserDefaults.standard.value(forKey: "access")
        isLogin = access != nil
    }
}
