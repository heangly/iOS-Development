//
//  UserService.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/15/21.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUserWithID(_ id: String?, completion: @escaping(User) -> Void) {
        guard let uid = id else { return }
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    

    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map { User(dictionary: $0.data()) }
            completion(users)
        }
    }
}
