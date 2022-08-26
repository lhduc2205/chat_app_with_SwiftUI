//
//  FeedView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI

struct FeedView: View {
    @State private var isShowNewTweet = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(0...20, id: \.self) { _ in
                            TweetRowView().padding()
                        }
                    }
                }
                
                newTweetButton
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

extension FeedView {
    var newTweetButton: some View {
        Button {
            isShowNewTweet = true
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 28, height: 28)
                .padding()
        }
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
        .shadow(color: .gray.opacity(0.8), radius: 10, x: 3, y: 2)
        .fullScreenCover(isPresented: $isShowNewTweet) {
            NewTweetView()
        }
        
    }
}
