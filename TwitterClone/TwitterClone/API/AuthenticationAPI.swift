//
//  Authentication.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/20/21.
//

import Firebase

struct AuthenticationAPI {
    static let shared = AuthenticationAPI()

    func registerUser(with inputValues: [String: String], profileImage: Data, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let email = inputValues["email"] else { return }
        guard let password = inputValues["password"] else { return }

        let filename = UUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)

        storageRef.putData(profileImage, metadata: nil) { meta, error in

            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error is -> \(error.localizedDescription)")
                        return
                    }

                    guard let uid = result?.user.uid else { return }
                    var newInputValues = inputValues
                    newInputValues["profileImageUrl"] = profileImageUrl
                    newInputValues["password"] = nil

                    REF_USERS.child(uid).updateChildValues(newInputValues, withCompletionBlock: completion)
                }

            }
        }

    }

    func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
