//
//  AuthHeaderView.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct AuthHeaderView: View {
    let firstText: String
    let secondText: String
    let corners: UIRectCorner
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack { Spacer() }
            Text(firstText)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(secondText)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.horizontal, 30)
        .foregroundColor(.white)
        .background(Color(.systemBlue))
        .clipShape(RoundedShape(corners: corners, radius: 80))
        .padding(.bottom, 50)
    }
}
