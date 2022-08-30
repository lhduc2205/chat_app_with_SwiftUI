//
//  MainTabView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        print("DEBUG: Init Main tab view")
    }
    
    var body: some View {
        if let user = authViewModel.currentUser {
            TabView(selection: $selectedIndex) {
                ForEach(ButtomNavItemViewModel.allCases, id: \.rawValue) { item in
                    item.getView(user: user).onTapGesture {
                        self.selectedIndex = item.rawValue
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: item.imageName)
                                .padding(.top)
                            Text(item.title)
                            ZStack {
                                Divider()
                                    .frame(height: 2)
                                    .overlay(Color(.systemBlue))
                            }
                        }
                    }
                    .tag(item.rawValue)
                    
                }
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
