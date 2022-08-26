//
//  NewTweetView.swift
//  Twitter
//
//  Created by lhduc on 16/08/2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State var imageAttach: UIImage?
    
    @ObservedObject private var viewModel = NewTweetviewModel()
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            header
            tweetInfo
            tweet
            tweetAttacher
        }
    }
}

extension NewTweetView {
    
    var header: some View {
        ZStack(alignment: .center) {
            Color("contrast").ignoresSafeArea()
            Text("Create new post")
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                Spacer()
                Button {
                    viewModel.uploadTweet(withCaption: viewModel.caption,
                                          imageAtach: imageAttach)
                } label: {
                    Text("Post")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .background(viewModel.caption.isEmpty ? .gray.opacity(0.5) : Color(.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(20)
                .disabled(viewModel.caption.isEmpty)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
        }
        .frame(height: 50)
    }
    
    var tweetInfo: some View {
        HStack(alignment: .top, spacing: 15) {
            if let user = authViewModel.currentUser {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.fullname)
                    Button {
                        
                    } label: {
                        Label("Friends", systemImage: "person.2")
                            .padding(5)
                            .font(.caption)
                            .foregroundColor(.black).opacity(0.7)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 0.75)
                            )
                    }
                    
                }
            }
            
            Spacer()
        }
        .padding(.top, 25)
        .padding(.horizontal)
    }
    
    var tweetAttacher: some View {
        VStack {
            Spacer()
            HStack() {
                ForEach(viewModel.imageItems) { item in
                    Spacer()
                    Button {
                        item.onPressed()
                    } label: {
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(item.color)
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                }
            }
            .frame(height: 60)
            .padding()
            .padding(.bottom, 20)
            .background(Color("contrast"))
            .clipShape(RoundedShape(corners: [.topLeft, .topRight], radius: 30))
            
        }
        .sheet(isPresented: $viewModel.isBottomSheetShowed) {
            getContent
        }
        .ignoresSafeArea()
    }
    
    var tweet: some View {
        VStack {
            TextField("What do you think about?", text: $viewModel.caption)
                .lineLimit(5)
                .padding(.vertical)
            
            if let imageAttach = imageAttach {
                ZStack(alignment: .topLeading) {
                    GeometryReader { proxy in
                        Image(uiImage: imageAttach)
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.width)
                    }
                    Button {
                        self.imageAttach = UIImage()
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var getContent: AnyView {
        switch viewModel.actionType {
        case .image:
            return AnyView(ImagePicker(selectedImage: $imageAttach))
            
        case .tag:
            return AnyView(Text("Tag"))
            
        case .emoji:
            return AnyView(Text("Emoji"))
            
        case .location:
            return AnyView(Text("Location"))
            
        case .more:
            return AnyView(Text("More"))
        }
    }
}



struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
