//
//  UserAPI.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/21/21.
//

import Firebase

struct UserAPI {
    static let shared = UserAPI()

    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: String] else { return }
            let user = User(dictionary: dictionary, uid: uid)
            completion(user)
        }
    }
}
