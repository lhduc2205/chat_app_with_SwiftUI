//
//  LoadingView.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    @Binding var isLoading: Bool
    @ViewBuilder var contentView: Content
    
    var body: some View {
        ZStack {
            contentView
            
            if(isLoading) {
                grayBackground
                withAnimation(.easeInOut) {
                    loadingContent
                }
            }
        }
    }
}

extension LoadingView {
    var grayBackground: some View {
        Color(.black)
            .opacity(0.6)
            .ignoresSafeArea()
    }
    
    var loadingContent: some View {
        VStack (spacing: 20) {
            Image("please_wait")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()
            Text("Please wait...")
                .font(.system(size: 22))
            
            ProgressView()
                .scaleEffect(1.2)
        }
        .frame(width: 350, height: 370)
        .background(.white)
        .cornerRadius(20, corners: .allCorners)
        .shadow(color: Color(.systemGray2), radius: 10, x: 0, y: 0)
        .padding(.horizontal)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true)) {
            LoginView()
        }
    }
}
