//
//  ExploreViewModel.swift
//  Twitter
//
//  Created by lhduc on 23/08/2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    let userService = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        userService.fetchUsers { users in
            self.users = users
            
            print("DEBUG: users \(users)")
        }
    }
    
    func searchableUser() -> [User] {
        if searchText.isEmpty {
            return users
        }
        
        let lowercaseQuery = searchText.lowercased()

        return users.filter({
            $0.username.contains(lowercaseQuery) ||
            $0.fullname.lowercased().contains(lowercaseQuery)
        })
    }
}
