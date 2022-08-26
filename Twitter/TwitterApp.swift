//
//  TwitterApp.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TwitterView()
                .environmentObject(authViewModel)
        }
    }
}
