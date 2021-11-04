//
//  FirebaseListener.swift
//  LetsMeet
//
//  Created by Heang Ly on 11/4/21.
//

import Firebase

class FirebaseListener {
    static let shared = FirebaseListener()

    private init () { }

    func downloadCurrentUserFromFirebase(userId: String, email: String) {
        firebaseReference(.User).document(userId).getDocument { snapshot, error in
            guard let snapshot = snapshot else { return }

            if snapshot.exists {
            } else {
                // first login


            }
        }
    }


}
