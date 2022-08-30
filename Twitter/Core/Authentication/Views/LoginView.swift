//
//  SignInView.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                AuthHeaderView(firstText: "Hello.",
                               secondText: "Welcome back",
                               corners: [.bottomRight])
                
                emailAndPasswordTextField
                forgotPasswordLink
                signInButton
                
                Spacer()
                
                signUpNavigationLink
                
            }
            .showWaitingDialog(
                with: "Authenticating...", isLoading: $viewModel.isLoading
            )
            .showAlertDialog(
                title: viewModel.alertTitle,
                text: viewModel.alertContent,
                confirmText: viewModel.alertConfirmText,
                isShow: $viewModel.isShowAlertDialog
            )
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LoginView {
    
    var emailAndPasswordTextField: some View {
        VStack(spacing: 40) {
            
            CustomInputField(
                placeholderText: "Email",
                imageName: "envelope",
                text: $viewModel.email)
            
            CustomInputField(
                placeholderText: "Password",
                imageName: "lock",
                isSecure: true,
                text: $viewModel.password)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
    }
    
    var forgotPasswordLink: some View {
        HStack {
            Spacer()
            NavigationLink {
                Text("Reset password view...")
            } label: {
                Text("Forgot password?")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
    
    var signInButton: some View {
        LargeButton(label: "Sign in", isDisabled: viewModel.email.isEmpty || viewModel.password.isEmpty) {
            viewModel.isLoading.toggle()
            authViewModel.login(withEmail: viewModel.email, password: viewModel.password) { success in
                viewModel.isLoading.toggle()
                if !success {
                    viewModel.isShowAlertDialog.toggle()
                }
            }
        }
        .shadow(color: .gray.opacity(0.3), radius: 10, y: 10)
        .padding(.horizontal, 20)
    }
    
    var signUpNavigationLink: some View {
        NavigationLink {
            RegistrationView().navigationBarHidden(true)
        } label: {
            HStack {
                Text("Don't have an account? ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Sign Up")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(Color(.systemBlue))
            }
            .padding(.bottom, 30)
        }
    }
    
}
