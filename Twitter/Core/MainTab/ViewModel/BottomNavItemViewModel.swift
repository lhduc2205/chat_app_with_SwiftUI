//
//  BottomNavItemViewModel.swift
//  Twitter
//
//  Created by lhduc on 16/08/2022.
//

import SwiftUI


enum ButtomNavItemViewModel: Int, CaseIterable {
    case home
    case explore
    case notification
    case message
    case profile
    
    var title: String {
        switch self {
            case .home:         return "Home"
            case .explore:      return "Explore"
            case .notification: return "Notification"
            case .message:      return "Message"
            case .profile:      return "Profile"
        }
    }
    
    var imageName: String {
        switch self {
            case .home:         return "house"
            case .explore:      return "magnifyingglass"
            case .notification: return "bell"
            case .message:      return "envelope"
            case .profile:      return "person"
        }
    }
    
    func getView(user: User) -> AnyView {
        
        switch self {
            case .home:         return AnyView(FeedView())
            case .explore:      return AnyView(ExploreView())
            case .notification: return AnyView(NotificationView())
            case .message:      return AnyView(MessageView())
            case .profile:      return AnyView(ProfileView(isMyProfile: true, user: user))
        }
    }
}
