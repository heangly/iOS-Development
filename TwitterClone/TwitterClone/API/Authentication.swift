//
//  Authentication.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/20/21.
//

import Firebase

struct AuthenticationAPI {
    static func registerUser(with inputValues: [String: String], profileImage: UIImage) {
        guard let email = inputValues["email"] else { return }
        guard let password = inputValues["password"] else { return }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error is -> \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }
            
            let ref = Database.database().reference().child("users").child(uid)
            
            ref.updateChildValues(inputValues) { error, ref in
                print("DEBUG: Successfully update user info")
            }
        }
    }
}
