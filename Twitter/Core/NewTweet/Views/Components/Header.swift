//
//  Header.swift
//  Twitter
//
//  Created by lhduc on 24/08/2022.
//

import SwiftUI

class _NewTweetHeader: NewTweetView {
    
    var body: some View {
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
                    
                } label: {
                    Text("Post")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .background(caption.isEmpty ? .gray.opacity(0.5) : Color(.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(20)
                .disabled(caption.isEmpty)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
        }
        .frame(height: 50)
    }
}
