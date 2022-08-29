//
//  LoadingView.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import SwiftUI

struct CustomDialog: ViewModifier {
    var title: String
    
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if(isLoading) {
                Color(.black)
                    .opacity(0.6)
                    .ignoresSafeArea()
                VStack (spacing: 20) {
                    Image("please_wait")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                    Text(title)
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
    }
}

extension View {
    func showLoadingDialog(with title: String, isLoading: Binding<Bool>) -> some View {
        modifier(CustomDialog(title: title, isLoading: isLoading))
    }
}


struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .showLoadingDialog(with: "Loading...", isLoading: .constant(true))
    }
}
