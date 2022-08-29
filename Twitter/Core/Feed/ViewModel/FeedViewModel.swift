//
//  TweetViewModel.swift
//  Twitter
//
//  Created by lhduc on 27/08/2022.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    var tweetService = TweetService()
    let userService = UserService()
    
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets(completion: (() -> Void)? = nil) {
        tweetService.fetchTweets() { _tweets in
            self.tweets = _tweets
            
            for i in 0 ..< self.tweets.count {
                let uid = self.tweets[i].uid
                print("DEBUG: \(_tweets.description)")
                
                self.userService.fetchUser(withUid: uid) { _user in
                    self.tweets[i].user = _user
                    if completion != nil {
                        completion!()
                    }
                }
            }
        }
    }
    
}
