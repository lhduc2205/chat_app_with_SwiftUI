//
//  UserService.swift
//  Twitter
//
//  Created by lhduc on 22/08/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection(FirebaseConstants.USER_COLLECTION)
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
//                print("FETCH user: \(user.username)")
                
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        
        Firestore.firestore().collection(FirebaseConstants.USER_COLLECTION)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap { try? $0.data(as: User.self) }
                completion(users)
                
            }
    }
}
