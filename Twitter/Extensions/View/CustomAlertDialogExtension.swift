//
//  CustomAlertDialog.swift
//  Twitter
//
//  Created by lhduc on 30/08/2022.
//

import SwiftUI

struct CustomAlertDialog: ViewModifier {
    let title: String
    let text: String
    let confirmText: String
    
    @Binding var isShow: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if(isShow) {
                Color(.black)
                    .opacity(0.6)
                    .ignoresSafeArea()
                VStack (alignment: .leading, spacing: 5) {
                    HStack { Spacer() }
                    Text(title)
                        .font(.system(size: 22))
                        .foregroundColor(Color(.systemRed))
                        .padding(.leading, 5)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                    
                    Text(text)
                        .font(.system(size: 16))
                        .foregroundColor(.black).opacity(0.8)
                        .padding(.leading, 5)
                        .padding(.bottom, 20)
                    
                    HStack {
                        Spacer()
                        Button {
                            isShow.toggle()
                        } label: {
                            Text("Try again")
                                .padding(.vertical, 10)
                                .padding(.horizontal, 12)
                                .background(Color(.systemBlue))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.all, 17)
                .frame(width: UIScreen.screenWidth - 40)
                .background(.white)
                .cornerRadius(20, corners: .allCorners)
                .shadow(color: Color(.systemGray2), radius: 10, x: 0, y: 0)
            }
        }
    }
}

extension View {
    func showAlertDialog(
        title: String,
        text: String,
        confirmText: String,
        isShow: Binding<Bool>
    ) -> some View {
        modifier(
            CustomAlertDialog(
                title: title,
                text: text,
                confirmText: confirmText,
                isShow: isShow
            )
        )
    }
}


struct CustomAlertDialog_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .showAlertDialog(
                title: "Authentication fail",
                text: "Your email or password is incorrect",
                confirmText: "Try again",
                isShow: .constant(true)
            )
    }
}
