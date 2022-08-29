//
//  ITweet.swift
//  Twitter
//
//  Created by lhduc on 29/08/2022.
//

import Foundation

protocol ITweet {
    var tweets: [Tweet] { get set }
    var tweetService: TweetService { get set }
    func fetchTweets(completion: @escaping([Tweet]) -> Void)
}
