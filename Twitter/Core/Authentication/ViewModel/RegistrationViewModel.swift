//
//  RegistrationViewModel.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmed = ""
    
    @Published var isLoading = false
    
    func isAnyNullFieldExisted() -> Bool {
        return (
            fullname.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            passwordConfirmed.isEmpty ||
            username.isEmpty
        )
    }
}
