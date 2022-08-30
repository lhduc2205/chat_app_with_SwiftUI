//
//  TweetService.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Firebase
import SwiftUI

struct TweetService {
    private let currentUser = Auth.auth().currentUser
    private let tweetRef =  Firestore.firestore().collection(FirebaseConstants.TWEET_COLLECTION)
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        tweetRef
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self)}
                completion(tweets)
            }
    }
    
    func fetchTweets(for uid: String, completion: @escaping([Tweet]) -> Void) {
        tweetRef
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
        let data = Tweet.toDictionary(tweet: tweet)
        tweetRef
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
    
    func likeTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let tweetDoc = tweetRef.document(tweetId)
        let usersLikeRef = tweetDoc.collection(FirebaseConstants.USERS_LIKE_COLECTION)
        
        tweetDoc.updateData(["likes": tweet.likes + 1]) { _ in
            usersLikeRef.document(uid).setData(["didLike": true]) { _ in
                print("DEBUG: Did like tweet and now we should update UI")
                completion(true)
            }
        }
    }
    
    func unLikeTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let tweetDoc = tweetRef.document(tweetId)
        let usersLikeRef = tweetDoc.collection(FirebaseConstants.USERS_LIKE_COLECTION)
        
        tweetDoc.updateData(["likes": tweet.likes - 1]) { _ in
            usersLikeRef.document(uid).setData(["didLike": false]) { _ in
                print("DEBUG: Did unlike tweet and now we should update UI")
                completion(true)
            }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        tweetRef.document(tweetId).collection(FirebaseConstants.USERS_LIKE_COLECTION)
            .getDocuments { snapshot, _ in
                if tweet.likes == 0 {
                    completion(false)
                    return
                }
                guard let snapshot = snapshot else { return }
                
                var didLike = snapshot.documents.contains { $0.documentID == uid }
                
                if !didLike {
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
}
