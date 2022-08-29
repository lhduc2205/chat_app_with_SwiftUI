//
//  User.swift
//  Twitter
//
//  Created by lhduc on 22/08/2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id:  String?
    let username:        String
    let fullname:        String
    let email:           String
    let profileImageUrl: String
    
}
