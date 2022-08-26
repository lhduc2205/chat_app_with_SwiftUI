//
//  TweetService.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Firebase

struct TweetService {
    private let db = Firestore.firestore()
    
    func uploadTweet(_ tweet: Tweet) {
        
        let data = Tweet.toColection(tweet: tweet)
        
        db.collection(FirebaseConstants.TWEET_COLLECTION)
            .document()
            .setData(data) { _ in
                print("DEBUG: Did upload tweets..")
            }
    }
    
}
