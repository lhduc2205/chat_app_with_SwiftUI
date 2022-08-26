//
//  AuthViewModel.swift
//  Twitter
//
//  Created by lhduc on 18/08/2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    
    private var userSessionTemp: Firebase.User?
    private let userService = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        if(self.userSession != nil) {
            fetchUser()
        }
    }
    
    func login(withEmail email: String, password: String, completion: @escaping() -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            completion()
            
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(
        withEmail email: String,
        password: String,
        fullname: String,
        username: String,
        completion: @escaping() -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSessionTemp = user
            
            let data = ["fullname": fullname,
                        "username": username.lowercased(),
                        "email": email]
            
            Firestore.firestore().collection(FirebaseConstants.USER_COLLECTION)
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data..")
                    completion()
                    self.didAuthenticateUser = true
                }
        }
        
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(image: UIImage) {
        guard let uid = userSessionTemp?.uid else { return }
        print("User id: \(uid)")
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection(FirebaseConstants.USER_COLLECTION)
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.userSessionTemp
                    self.fetchUser()
                    self.didAuthenticateUser = false
                }
        }
        
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
        
    }
}
