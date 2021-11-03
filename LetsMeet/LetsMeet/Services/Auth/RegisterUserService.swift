//
//  RegisterUser.swift
//  LetsMeet
//
//  Created by Heang Ly on 11/2/21.
//

import Firebase
import Foundation
import UIKit


class RegisterUserService: Equatable {
    static func == (lhs: RegisterUserService, rhs: RegisterUserService) -> Bool {
        return lhs.objectId == rhs.objectId
    }

    let objectId: String
    var email: String
    var username: String
    var dateOfBirth: Date
    var isMale: Bool
    var avatar: UIImage?
    var avatarLink: String
    var profession: String
    var jobTitle: String
    var about: String
    var city: String
    var country: String
    var height: Double
    var lookingFor: String
    var likedIdArray: [String]?
    var imageLinks: [String]?
    let registeredDate = Date()
    var pushId: String?

    var userDictionary: NSDictionary {
        return NSDictionary(
            objects: [
                self.objectId,
                self.email,
                self.username,
                self.dateOfBirth,
                self.isMale,
                self.profession,
                self.jobTitle,
                self.about,
                self.city,
                self.country,
                self.height,
                self.lookingFor,
                self.avatarLink,
                self.likedIdArray ?? [],
                self.imageLinks ?? [],
                self.registeredDate,
                self.pushId ?? ""],

            forKeys: [
                kOBJECTID as NSCopying,
                kEMAIL as NSCopying,
                kUSERNAME as NSCopying,
                kDATEOFBIRTH as NSCopying,
                kISMALE as NSCopying,
                kPROFESSION as NSCopying,
                kJOBTITLE as NSCopying,
                kABOUT as NSCopying,
                kCITY as NSCopying,
                kCOUNTRY as NSCopying,
                kHEIGHT as NSCopying,
                kLOOKINGFOR as NSCopying,
                kAVATARLINK as NSCopying,
                kLIKEDIDARRAY as NSCopying,
                kIMAGELINKS as NSCopying,
                kREGISTERDATE as NSCopying,
                kPUSHID as NSCopying,
            ])
    }

    //MARK: - Init
    init(objectId: String,
        email: String,
        username: String,
        dateOfBirth: Date,
        isMale: Bool,
        avatarLink: String = "",
        city: String) {

        self.objectId = objectId
        self.email = email
        self.username = username
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        self.profession = ""
        self.jobTitle = ""
        self.about = ""
        self.city = city
        self.country = ""
        self.height = 0.0
        self.lookingFor = ""
        self.avatarLink = avatarLink
        self.likedIdArray = []
        self.imageLinks = []
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

                let user = RegisterUserService(objectId: authData.user.uid, email: email, username: userName, dateOfBirth: dateOfBirth, isMale: isMale, city: city)

                user.saveUserLocally()
            }
        }
    }


    func saveUserLocally() {
        userDefaults.setValue(self.userDictionary as! [String: Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
}
