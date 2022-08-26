//
//  ProfilePhotoSelectorView.swift
//  Twitter
//
//  Created by lhduc on 19/08/2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var isImagePickerShowed = false
    @State private var avatarImage = UIImage(named: "user-avatar-default")
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthHeaderView(
                firstText: "Setup account.",
                secondText: "Add a profile photo",
                corners: [.bottomLeft])
            
            Image(uiImage: avatarImage!)
                .resizable()
                .renderingMode(.original)
                .frame(width: 100, height: 100)
                .background(Color("contrast"))
                .clipShape(Circle())
            
            Button {
                isImagePickerShowed.toggle()
            } label: {
                Label("Select from gallery", systemImage: "photo")
            }
            .padding(.top, 10)
            
            LargeButton(
                label: "Continue",
                trailingSystemImage: "arrow.right",
                spacing: 10,
                onPressed: {
                    authViewModel.uploadProfileImage(image: avatarImage!)
                }
            )
            .sheet(isPresented: $isImagePickerShowed) {
                ImagePicker(selectedImage: $avatarImage)
            }
            .padding()
            .padding(.top, 30)
            

            
            Spacer()
        }
        .ignoresSafeArea()
        
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
