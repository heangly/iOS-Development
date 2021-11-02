//
//  RegisterUser.swift
//  LetsMeet
//
//  Created by Heang Ly on 11/2/21.
//

import Firebase


class RegisterUserService: Equatable {
    static func == (lhs: RegisterUserService, rhs: RegisterUserService) -> Bool {
        return lhs.objectId == rhs.objectId
    }

    let objectId: String

    init(objectId: String) {
        self.objectId = objectId
    }

    static func registerUserWith(
        email: String,
        password: String,
        userName: String,
        city: String,
        isMale: Bool,
        dateOfBirth: Date,
        completion: @escaping(_ error: Error?) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { authData, error in
            completion(error)
            
            if let authData = authData, error == nil {
                //MARK: - Send verification email to user
                authData.user.sendEmailVerification { error in
                    print("auth email verification sent", error?.localizedDescription)
                }
            }
        }
    }


}
