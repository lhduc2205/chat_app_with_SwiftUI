//
//  TweetRowView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var viewModel: TweetRowViewModel
    var backgroundColor: Color?
    
    init(tweet: Tweet) {
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let user = viewModel.tweet.user {
                TweetInfo(user: user, timePostAgo: viewModel.tweet.getTimePostAgo())
            }
            
            TweetCaption(caption: viewModel.tweet.caption)
            
            if viewModel.tweet.imageUrl != "" {
                ImageAttach(image: viewModel.tweet.imageUrl)
            }
            
            Divider().padding(.horizontal).padding(.top, 20)
            
            actionButton
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
                KFImage(URL(string:user.profileImageUrl))
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
    
    var actionButton: some View {
        HStack {
            CustomButton(
                title: "Favorite",
                reactions: viewModel.tweet.likes,
                imageSystem: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart",
                color: viewModel.tweet.didLike ?? false ? Color(.systemRed) : .gray,
                onPressed: {
                    viewModel.handleLikeTweet()
                }
            )
            
            Spacer()
            
            CustomButton(title: "Comment", reactions: 0, imageSystem: "bubble.left") {
            }
            
            Spacer()
            
            CustomButton(title: "Share", reactions: 0, imageSystem: "arrowshape.turn.up.right") {
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .foregroundColor(.gray)
    }
    
    
    private struct CustomButton: View {
        let title: String
        let reactions: Int
        let imageSystem: String
        var color: Color = .gray
        let onPressed: () -> Void
        
        var body: some View {
            Button {
                onPressed()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: imageSystem)
                    if reactions != 0 {
                        Text("\(reactions) \(title)").font(.caption)
                    } else {
                        Text(title).font(.caption)
                    }
                    
                }
                .foregroundColor(color)
            }
        }
    }
    
    
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
