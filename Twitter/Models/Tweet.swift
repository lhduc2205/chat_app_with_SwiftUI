//
//  Tweet.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Firebase

struct Tweet {
    let uid:        String
    let caption:    String
    let imageUrl:   String
    let like:       Int
    let timestamp:  Timestamp
    
    init(uid:       String,
         caption:   String,
         like:      Int = 0,
         timestamp: Timestamp = Timestamp(date: Date()),
         imageUrl:  String    = ""
    ) {
        self.uid = uid
        self.caption = caption
        self.like = like
        self.timestamp = timestamp
        self.imageUrl = imageUrl
    }
    
    static func toColection(tweet: Tweet) -> [String: Any] {
        return [
            "uid":       tweet.uid,
            "caption":   tweet.caption,
            "like":      tweet.like,
            "timestamp": tweet.timestamp,
            "imageUrl":  tweet.imageUrl
        ]
    }
}
