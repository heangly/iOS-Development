//
//  UserService.swift
//  InstagramFirestoreTut
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
    
    static func fetchUserWithId(id: String?, completion: @escaping(User) -> Void) {
        guard let uid = id else { return }
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }

    static func fetchAllUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                let users = snapshot.documents.map { User(dictionary: $0.data()) }
                completion(users)
            }
        }
    }
}
