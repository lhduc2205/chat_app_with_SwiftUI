//
//  TweetRowView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    var tweet: Tweet
    var backgroundColor: Color?
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let user = tweet.user {
                TweetInfo(user: user, timePostAgo: tweet.getTimePostAgo())
            }
            
            TweetCaption(caption: tweet.caption)
            
            if tweet.imageUrl != "" {
                ImageAttach(image: tweet.imageUrl)
            }
            
            
            Divider().padding(.horizontal).padding(.top, 20)
            
            ActionButton()
        }
        .padding(.vertical)
        .background(backgroundColor ?? .white)
    }
    
    
}

extension TweetRowView {
    
    private struct TweetInfo: View {
        let user: User
        let timePostAgo: String
        
        var body: some View {
            HStack {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 45, height: 45)
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullname)
                        .font(.subheadline.bold())
                    Text(timePostAgo)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
    
    private struct TweetCaption: View {
        let caption: String
        
        var body: some View {
            Text(caption)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
    }
    
    private struct ImageAttach: View {
        let image: String
        
        var body: some View {
            KFImage(URL(string: image))
                .resizable()
                .scaledToFill()
        }
    }
    
    private struct ActionButton: View {
        var body: some View {
            HStack {
                CustomButton(title: "Favorite", imageSystem: "heart") {
                    
                }
                
                Spacer()
                
                CustomButton(title: "Comment", imageSystem: "bubble.left") {
                    
                }
                
                Spacer()
                
                CustomButton(title: "Share", imageSystem: "arrowshape.turn.up.right") {
                    
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .foregroundColor(.gray)
        }
    }
    
    
    private struct CustomButton: View {
        let title: String
        let imageSystem: String
        let onPressed: () -> Void
        
        var body: some View {
            Button {
                onPressed()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: imageSystem)
                    Text(title).font(.caption)
                    
                }
            }
        }
    }
    
    
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
