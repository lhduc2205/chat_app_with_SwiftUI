//
//  ContentView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI

struct TwitterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
                
            } else {
                MainTabView()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TwitterView()
//    }
//}
