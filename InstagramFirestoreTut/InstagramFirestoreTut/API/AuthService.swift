//
//  AuthService.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/12/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { (imagUrl) in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed to create user in firebase \(error.localizedDescription)")
                }
                guard let uid = result?.user.uid else { return }
                let data: [String: Any] = [
                    "email" : credentials.email,
                    "fullname": credentials.password,
                    "profileImageUrl": imagUrl,
                    "uid": uid,
                    "username": credentials.username
                ]
                
                Firestore.firestore().collection("user").document(uid).setData(data, completion: completion)
            }
        }
    }
}