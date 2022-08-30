//
//  TweetRowViewModel.swift
//  Twitter
//
//  Created by lhduc on 30/08/2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    private let tweetService = TweetService()
    
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.checkIfUserLikedTweet()
    }
    
    func handleLikeTweet() {
        if tweet.didLike ?? false {
            unLikeTweet()
        } else {
            likeTweet()
        }
    }
    
    private func likeTweet() {
        self.tweet.likes += 1
        self.tweet.didLike = true
        tweetService.likeTweet(tweet) { _ in
        }
    }
    
    private func unLikeTweet() {
        self.tweet.likes -= 1
        self.tweet.didLike = false
        tweetService.unLikeTweet(tweet) { _ in
        }
    }
    
    private func checkIfUserLikedTweet() {
        tweetService.checkIfUserLikedTweet(tweet) { success in
            if success {
                self.tweet.didLike = true
            }
        }
    }
    
}
