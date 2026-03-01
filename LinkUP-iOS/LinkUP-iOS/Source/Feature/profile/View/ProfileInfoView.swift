//
//  RallyInfoView.swift
//  dodum-iOS
//
//  Created by maple on 9/27/25.
//

import SwiftUI

struct ProfileInfoView: View {
    @Binding var status: ProfileStatus
    @Binding var activity: Activity
    @EnvironmentObject var VM: ProfileViewModel
    @StateObject var loginVM = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack{
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 330, height: 370)
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                    .overlay(alignment: .topLeading){
                        VStack(alignment: .leading) {
                            Text("프로필")
                                .font(.bold(20))
                                .padding(.bottom, 24)
                            
                            InfoItem("닉네임", VM.userInfo.username)
                            
                            InfoItem("이메일", VM.userInfo.email)
                            
                            InfoItem("답변자 순위", VM.userInfo.ranking, "위")
                            
                            InfoItem("포인트", VM.userInfo.point, " P")
                                .padding(.bottom, 32)
                            
                            HStack{
                                Spacer()
                                Button{
                                    
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 110, height: 35)
                                            .foregroundStyle(.sub)
                                        Text("로그아웃")
                                            .font(.medium(16))
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                        .padding(16)
                    }
                    .padding(.bottom, 20)
                
                Button{
                    activity = .Answer
                    status = .activity
                }label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 330, height: 50)
                        .foregroundStyle(.white)
                        .shadow(radius: 3)
                        .overlay{
                            HStack {
                                Text("내 답변")
                                    .font(.bold(20))
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 15, height: 18)
                                    .foregroundStyle(.main)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 20)
                }
                
                Button{
                    activity = .Question
                    status = .activity
                }label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 330, height: 50)
                        .foregroundStyle(.white)
                        .shadow(radius: 3)
                        .overlay{
                            HStack {
                                Text("내 질문")
                                    .font(.bold(20))
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 15, height: 18)
                                    .foregroundStyle(.main)
                            }
                            .padding(.horizontal, 20)
                        }
                }
            }
            
            Spacer()
        }
        .padding(.top, 24)
        .task {
            await VM.fetchUserInfo()
        }
    }
}



@ViewBuilder
func InfoItem(_ title: String, _ value: String) -> some View{
    VStack(alignment: .leading){
        Text(title)
            .font(.medium(18))
            .foregroundStyle(.gray)
            .padding(.bottom, 0)
        
        Text(value)
            .font(.semibold(16))
        
    }
    .padding(.bottom, 8)
}

@ViewBuilder
func InfoItem(_ title: String, _ value: Int, _ trailing: String) -> some View{
    VStack(alignment: .leading){
        Text(title)
            .font(.medium(18))
            .foregroundStyle(.gray)
            .padding(.top, 0)
        
        Text("\(value)\(trailing)")
            .font(.semibold(16))
            .foregroundStyle(.main)
        
    }
    .padding(.bottom, 8)
}


