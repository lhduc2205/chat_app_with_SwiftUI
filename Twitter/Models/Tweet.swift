//
//  Tweet.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let caption: String
    let imageUrl: String
    let likes: Int
    let timestamp: Timestamp
    
    var user: User?
    
    init(
        uid: String,
        caption: String,
        like: Int = 0,
        timestamp: Timestamp = Timestamp(date: Date()),
        imageUrl: String    = ""
    ) {
        self.uid = uid
        self.caption = caption
        self.likes = like
        self.timestamp = timestamp
        self.imageUrl = imageUrl
    }
    
    func getTimePostAgo() -> String {
        return self.timestamp.dateValue().timeAgoDisplay()
    }
    
    static func toColection(tweet: Tweet) -> [String: Any] {
        return [
            "uid": tweet.uid,
            "caption": tweet.caption,
            "likes": tweet.likes,
            "timestamp": tweet.timestamp,
            "imageUrl": tweet.imageUrl
        ]
    }

}
