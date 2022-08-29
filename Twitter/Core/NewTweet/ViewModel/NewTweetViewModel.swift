//
//  NewTweetViewModel.swift
//  Twitter
//
//  Created by lhduc on 24/08/2022.
//

import SwiftUI
import Firebase

class NewTweetviewModel: ObservableObject {
    @Published var caption             = ""
    @Published var isBottomSheetShowed = false
    @Published var isTweetUploading    = false
    
//    @Binding var feedViewModel: FeedViewModel
    
    var actionType:  ActionType   =  .image
    let service:     TweetService =  TweetService()
    
    enum ActionType: String { case image, tag, emoji, location, more }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        service.fetchTweets { _tweet in
            completion(_tweet)
        }
    }
    
    func postTweet(withCaption caption: String, imageAtach: UIImage?, completion: @escaping() -> Void) {
        self.isTweetUploading.toggle()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        if let imageAtach = imageAtach {
            uploadTweetWithImage(imageAtach, uid: uid) {
                self.isTweetUploading.toggle()
                completion()
            }
            return
        }
        
        uploadTweet(with: Tweet(uid: uid, caption: self.caption)) {
            self.isTweetUploading.toggle()
            completion()
        }
        
    }
    
    func uploadTweet(with tweet: Tweet, completion: @escaping() -> Void) {
        service.uploadTweet(tweet) { success in
            print("DEBUG: Did upload tweet...")
            if success {
                self.isTweetUploading.toggle()
                completion()
            } else {
                
            }
        }
    }
    
    func uploadTweetWithImage(_ imageAtach: UIImage, uid: String, completion: @escaping() -> Void) {
        ImageUploader.uploadImage(image: imageAtach) { _imageUrl in
            print("DEBUG: Did upload image attach...")
            self.uploadTweet(with: Tweet(uid: uid, caption: self.caption, imageUrl: _imageUrl)) {
                completion()
            }
        }
    }
    
}


extension NewTweetviewModel {
    var imageItems: [ImageItem] {
        return [
            ImageItem(imageName: "photo", color: .blue) {
                self.isBottomSheetShowed.toggle()
                self.actionType = .image
            },
            ImageItem(imageName: "tag.fill", color: Color(0xFFF65A83)) {
                self.isBottomSheetShowed.toggle()
                self.actionType = .tag
            },
            ImageItem(imageName: "face.smiling.fill", color: Color(0xFFE8AA42)) {
                self.isBottomSheetShowed.toggle()
                self.actionType = .emoji
            },
            ImageItem(imageName: "location.circle.fill", color: Color(0xFF125B50)) {
                self.isBottomSheetShowed.toggle()
                self.actionType = .location
            },
            ImageItem(imageName: "ellipsis.circle.fill", color: Color(.gray)) {
                self.isBottomSheetShowed.toggle()
                self.actionType = .more
            },
        ]
    }
}

