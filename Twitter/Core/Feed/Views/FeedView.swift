//
//  FeedView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @State private var isShowNewTweet = false
    
    @StateObject var viewModel = FeedViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.tweets.isEmpty {
                VStack {
                    newTweetButton
                    noTweetNotification
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    newTweetButton
                    Divider().frame(height: 8).overlay(Color(.systemGray6))
                    tweets
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

extension FeedView {
    
    var tweets: some View {
        ZStack {
            Color(.systemGray6)
            LazyVStack {
                ForEach(viewModel.tweets) { tweet in
                    TweetRowView(tweet: tweet)
                }
            }
        }
    }
    
    var noTweetNotification: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack { Spacer() }
            Spacer()
            Image("setting")
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
            Text("No tweet yet")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .background(Color(.systemGray6))
    }
    
    var newTweetButton: some View {
        Button {
            isShowNewTweet = true
        } label: {
            HStack(spacing: 10) {
                if let avatar = authViewModel.currentUser?.profileImageUrl {
                    CircleAvatar(avatarUrl: avatar, radius: 30)
                }
                Text("What do you think about?")
                    .foregroundColor(Color(.systemGray))
                
                Spacer()
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .background(Color(.clear))
        .padding(.bottom)
        .fullScreenCover(isPresented: $isShowNewTweet) {
            NewTweetView(feedViewModel: viewModel)
        }
        
    }
}
