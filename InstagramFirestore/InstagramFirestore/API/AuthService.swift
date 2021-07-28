//
//  AuthService.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 7/28/21.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    static func registerUser(withCredential credentials: AuthCredentials,
        completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: FAiled to register user \(error.localizedDescription)")
                    return
                }

                guard let uid = result?.user.uid else { return }
                let data = [
                    "email": credentials.email,
                    "fullname": credentials.fullname,
                    "profileImageUrl": imageUrl,
                    "uid": uid,
                    "username": credentials.username
                ]
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
