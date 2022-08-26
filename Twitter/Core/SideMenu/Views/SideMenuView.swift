//
//  SideMenuView.swift
//  Twitter
//
//  Created by lhduc on 16/08/2022.
//

import SwiftUI

struct SideMenuView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            userInfo
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                
                SideMenuOptionButtonView(menuOption: option)
                
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

extension SideMenuView {
    var userInfo: some View {
        VStack(alignment: .leading) {
            Circle()
                .frame(width: 50, height: 50)
            Text("Le Huynh Duc")
                .font(.headline)
            Text("@lhduc")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            HStack(spacing: 20) {
                HStack {
                    Text("200") .font(.headline)
                    Text("Following")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("20M").font(.headline)
                    Text("Followers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 40)
    }
}
