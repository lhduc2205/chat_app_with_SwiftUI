//
//  RegistrationView.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmed = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(
                    destination: ProfilePhotoSelectorView(),
                    isActive: $authViewModel.didAuthenticateUser,
                    label: { }
                )
                
                AuthHeaderView(
                    firstText: "Get started.",
                    secondText: "Create your account",
                    corners: [.bottomLeft])
                
                registrationForm
                
                signUpButton
                
                Spacer()
                
                signInNavigationLink
                
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
    
    func isAnyNullFieldExisted() -> Bool {
        return  fullname.isEmpty ||
                email.isEmpty ||
                password.isEmpty ||
                passwordConfirmed.isEmpty ||
                username.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

extension RegistrationView {
    
    
    
    var registrationForm: some View {
        VStack(spacing: 40) {
            
            HStack {
                CustomInputField(
                    placeholderText: "Full name",
                    imageName: "person",
                    text: $fullname)
                
                CustomInputField(
                    placeholderText: "Username",
                    imageName: "pencil.and.outline",
                    text: $username)
            }
            
            CustomInputField(
                placeholderText: "Email",
                imageName: "envelope",
                text: $email)
            
            CustomInputField(
                placeholderText: "Password",
                imageName: "lock",
                isSecure: true,
                text: $password)
            
            CustomInputField(
                placeholderText: "Conform Password",
                imageName: "lock",
                isSecure: true,
                text: $passwordConfirmed)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 50)
    }
    
    var signUpButton: some View {
        LargeButton(
            label: "Sign Up",
            isDisabled: isAnyNullFieldExisted(),
            onPressed: {
                
                authViewModel.register(withEmail: email,
                                       password: password,
                                       fullname: fullname,
                                       username: username)
            }
        )
        .shadow(color: .gray.opacity(0.3), radius: 10, y: 10)
        .padding(.horizontal, 20)
    }
    
    var signInNavigationLink: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Text("You're already had an account? ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Login")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(Color(.systemBlue))
            }
            .padding(.bottom, 30)
        }
    }
    
}
