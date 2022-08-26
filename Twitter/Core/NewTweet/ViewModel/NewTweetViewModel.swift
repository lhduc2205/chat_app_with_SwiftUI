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
    
    var actionType:  ActionType   =  .image
    let service:     TweetService =  TweetService()
    
    enum ActionType: String { case image, tag, emoji, location, more }
    
    func uploadTweet(withCaption caption: String, imageAtach: UIImage?) {
        // Upload image
        var imageUrl  = ""
        if let imageAtach = imageAtach {
            ImageUploader.uploadImage(image: imageAtach) { _imageUrl in
                print("DEBUG: Did upload image attach..")
                imageUrl = _imageUrl
            }
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let tweet     = Tweet(uid: uid, caption: caption, imageUrl: imageUrl)
        
        service.uploadTweet(tweet)
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

