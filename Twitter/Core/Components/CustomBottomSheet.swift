//
//  CustomBottomSheet.swift
//  Twitter
//
//  Created by lhduc on 19/08/2022.
//

import SwiftUI

struct CustomBottomSheet<Content: View>: View {
    var height: CGFloat
    var offset: CGFloat
    @ViewBuilder var contentView: Content
    
    var body: some View {
        VStack {
            Divider()
                .frame(width: 100, height: 5)
                .background(.gray).opacity(0.5)
                .cornerRadius(100)
                .padding(.top, 15)
            
            contentView
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: height)
        .background(.white)
        .offset(y: offset)
        .clipShape(RoundedShape(corners: [.topLeft, .topRight], radius: 30))
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: -1)
    }
}

struct CustomBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomSheet(height: 200, offset: 0) {
            Text("123456")
        }
    }
}
