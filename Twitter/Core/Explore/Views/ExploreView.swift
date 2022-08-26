//
//  ExploreView.swift
//  Twitter
//
//  Created by lhduc on 15/08/2022.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel = ExploreViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.searchableUser()) { user in
                            if (user.username != authViewModel.currentUser!.username) {
                                NavigationLink {
                                    ProfileView(user: user)
                                    
                                } label: {
                                    UserRowView(user: user)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct ExploreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreView()
//    }
//}
