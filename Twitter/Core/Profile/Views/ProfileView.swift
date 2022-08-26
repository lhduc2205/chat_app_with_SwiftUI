//
//  ProfileView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI
import Firebase
import Kingfisher

struct ProfileView: View {
    @State private var isShowSettingBottomSheet = false
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    private let isMyProfile: Bool
    private let userInfo: User
    
    init(isMyProfile: Bool = false, user: User) {
        self.isMyProfile = isMyProfile
        self.userInfo = user
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            userInfoDetails
            
            if(isMyProfile) {
                editButton
            }
            
            tweetFilterBar
            ScrollView {
                
                ForEach(0...9, id: \.self) { _ in
                    LazyVStack {
                        TweetRowView().padding()
                    }
                }
            }
            
            Spacer()
        }
        
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(isMyProfile: true, user: User())
//    }
//}

extension ProfileView {
    
    var headerView: some View {
        ZStack {
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack {
                if (!isMyProfile) {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 20)
                                .padding(.leading, 20)
                            
                        }
                        
                        Spacer()
                    }
                }
            }
            
            
            HStack {
                Spacer()
                KFImage(URL(string: userInfo.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .offset(y: 100 / 2)
                Spacer()
            }
        }
        .frame(height: 100)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    var editButton: some View {
        HStack(spacing: 15) {
            VStack {
                Button {
                } label: {
                    Label("Edit profile", systemImage: "pencil")
                        .foregroundColor(.white)
                        .font(.system(.title3))
                    
                }
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50)
                .background(Color(.systemBlue))
                .cornerRadius(10)
            }
            Button {
                isShowSettingBottomSheet.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .frame(width: 50, height: 50)
                    .background(Color("contrast"))
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowSettingBottomSheet) {
                Button {
                    authViewModel.signOut()
                } label: {
                    Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                        .padding()
                        .foregroundColor(.red)
                }
                
            }
        }
        .padding(.horizontal)
    }
    
    var userInfoDetails: some View {
        HStack {
            Spacer()
            VStack(spacing: 5) {
                
                Text(userInfo.fullname)
                    .font(.title2).bold()
                
                Text("@\(userInfo.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("\"My favorite sport is basketball\"")
                    .padding(.bottom, 10)
                
                HStack(spacing: 20) {
                    HStack {
                        Text("200") .font(.headline)
                        Text("Following")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("20M").font(.headline)
                        Text("Followers")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            Spacer()
        }
        .padding(.bottom)
        .padding(.top, 50)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .bold : .semibold)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .padding(.vertical)
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
}
