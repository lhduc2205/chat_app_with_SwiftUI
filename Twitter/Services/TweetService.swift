//
//  TweetService.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Firebase

struct TweetService {
    private let db = Firestore.firestore()
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        db.collection(FirebaseConstants.TWEET_COLLECTION)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self)}
                completion(tweets)
            }	
    }
    
    func fetchTweets(for uid: String, completion: @escaping([Tweet]) -> Void) {
        db.collection(FirebaseConstants.TWEET_COLLECTION)
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                var tweets = documents.compactMap { try? $0.data(as: Tweet.self)}
                completion(tweets.sorted(by: {
                    $0.timestamp.dateValue() > $1.timestamp.dateValue()
                }))
            }
    }
    
    func uploadTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        let data = Tweet.toColection(tweet: tweet)
        db.collection(FirebaseConstants.TWEET_COLLECTION)
            .document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
}
