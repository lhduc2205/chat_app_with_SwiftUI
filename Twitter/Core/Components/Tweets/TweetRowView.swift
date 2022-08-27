//
//  TweetRowView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.blue)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Le Huynh Duc")
                            .font(.subheadline.bold())
                        Text("@lhduc")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("online")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text("Hellooooo")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "bubble.left")
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                }
            }
            .padding()
            .foregroundColor(.gray)
            
            Divider()
        }
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView()
    }
}
