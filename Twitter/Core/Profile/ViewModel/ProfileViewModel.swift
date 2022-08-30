//
//  ProfileViewModel.swift
//  Twitter
//
//  Created by lhduc on 29/08/2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    let user: User
    private let tweetService = TweetService()
    private let Y_MIN_TO_HIDE_INFO: CGFloat = 100
    
    @Published var isHideInfo = false
    @Published var tweets = [Tweet]()
    @Published var isShowSettingBottomSheet = false
    
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else { return }
        self.tweetService.fetchTweets(for: uid) { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    func handleScrollToHideInfo(with yAxis: CGFloat) {
        if yAxis < Y_MIN_TO_HIDE_INFO && !self.isHideInfo {
            DispatchQueue.main.async {
                withAnimation { self.isHideInfo.toggle() }
            }
        }
        if yAxis > Y_MIN_TO_HIDE_INFO && self.isHideInfo {
            DispatchQueue.main.async {
                withAnimation { self.isHideInfo.toggle() }
            }
        }
    }
}
