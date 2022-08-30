//
//  LoginViewModel.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var email    = ""
    @Published var password = ""
    @Published var isShowAlertDialog = false
    
    let alertTitle = "Authentication fail"
    let alertContent = "Your email or password is incorrect!"
    let alertConfirmText = "Try again"
}
