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
    private let isMyProfile: Bool
    
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @ObservedObject private var viewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    init(isMyProfile: Bool = false, user: User) {
        self.viewModel = ProfileViewModel(user: user)
        self.isMyProfile = isMyProfile
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if !viewModel.isHideInfo {
                headerView
                userInfoDetails
                
                if isMyProfile {
                    editButton
                }
            }
            
            tweetFilterBar
            
            tweets
            
            Spacer()
        }
        .onAppear() {
            self.viewModel.fetchUserTweets()
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
                KFImage(URL(string: viewModel.user.profileImageUrl))
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
                viewModel.isShowSettingBottomSheet.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .frame(width: 50, height: 50)
                    .background(Color("contrast"))
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $viewModel.isShowSettingBottomSheet) {
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
                
                Text(viewModel.user.fullname)
                    .font(.title2).bold()
                
                Text("@\(viewModel.user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    var tweets: some View {
        ScrollView {
            GeometryReader { reader -> AnyView in
                let yAxis = reader.frame(in: .global).midY

                viewModel.handleScrollToHideInfo(with: yAxis)

                return AnyView(Text("").frame(width: 0, height: 0))
            }
            
            ForEach(viewModel.tweets) { tweet in
                LazyVStack {
                    TweetRowView(tweet: tweet)
                }
            }
        }
        .offset(y: -20)
        .background(Color(.systemGray6))
    }
    
}
