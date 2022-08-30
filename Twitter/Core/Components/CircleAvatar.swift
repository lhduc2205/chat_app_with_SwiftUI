//
//  CircleAvatar.swift
//  Twitter
//
//  Created by lhduc on 30/08/2022.
//

import SwiftUI
import Kingfisher

struct CircleAvatar: View {
    let avatarUrl: String
    var radius: Double?
    
    var body: some View {
        KFImage(URL(string: avatarUrl))
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: radius ?? 40, height: radius ?? 40)
    }
}

struct CircleAvatar_Previews: PreviewProvider {
    static var previews: some View {
        CircleAvatar(avatarUrl:  "")
    }
}
