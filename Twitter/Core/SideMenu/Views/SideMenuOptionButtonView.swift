//
//  SideMenuRowView.swift
//  Twitter
//
//  Created by lhduc on 16/08/2022.
//

import SwiftUI

struct SideMenuOptionButtonView: View {
    var menuOption: SideMenuViewModel
    
    var body: some View {
        Button {
        } label: {
            Label{
                Text(menuOption.description)
                    .foregroundColor(.black)
                    .frame(
                        minWidth: 100,
                        maxWidth: .infinity,
                        minHeight: 30,
                        alignment: .leading)
                    
            } icon: {
                Image(systemName: menuOption.imageName)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            
        }
        .padding()
        .background(.clear)
        .cornerRadius(15)
    }
}

struct SideMenuOptionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionButtonView(menuOption: .profile)
    }
}
