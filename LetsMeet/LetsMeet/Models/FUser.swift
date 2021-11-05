//
//  RegisterUser.swift
//  LetsMeet
//
//  Created by Heang Ly on 11/2/21.
//

import Firebase
import Foundation
import UIKit
import AVFoundation


class FUser: Equatable {
    static func == (lhs: FUser, rhs: FUser) -> Bool {
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
                self.pushId ?? ""
            ],

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
    init(dictionary: NSDictionary) {
        self.objectId = dictionary[kOBJECTID] as? String ?? ""
        self.email = dictionary[kEMAIL] as? String ?? ""
        self.username = dictionary[kOBJECTID] as? String ?? ""
        self.isMale = dictionary[kISMALE] as? Bool ?? true
        self.profession = dictionary[kPROFESSION] as? String ?? ""
        self.jobTitle = dictionary[kJOBTITLE] as? String ?? ""
        self.about = dictionary[kABOUT] as? String ?? ""
        self.city = dictionary[kCITY] as? String ?? ""
        self.country = dictionary[kCOUNTRY] as? String ?? ""
        self.height = dictionary[kHEIGHT] as? Double ?? 0.0
        self.lookingFor = dictionary[kLOOKINGFOR] as? String ?? ""
        self.avatarLink = dictionary[kAVATARLINK] as? String ?? ""
        self.likedIdArray = dictionary[kLIKEDIDARRAY] as? [String]
        self.imageLinks = dictionary[kIMAGELINKS] as? [String]
        self.pushId = dictionary[kPUSHID] as? String ?? ""


        if let date = dictionary[kDATEOFBIRTH] as? Timestamp {
            self.dateOfBirth = date.dateValue()
        } else {
            self.dateOfBirth = Date()
        }

    }



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

                let user = FUser(objectId: authData.user.uid, email: email, username: userName, dateOfBirth: dateOfBirth, isMale: isMale, city: city)

                user.saveUserLocally()
            }
        }
    }

    //MARK: - Resend Links
    static func resetPasswordFor(email: String, completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
            })
        })
    }


    //MARK: - Save Users
    func saveUserLocally() {
        userDefaults.setValue(self.userDictionary as! [String: Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }

    func saveUserToFireStore() {
        firebaseReference(.User).document(self.objectId).setData(self.userDictionary as! [String: Any]) { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }


    //MARK: - Login
    static func loginUserWith(email: String, password: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let authDataResult = authDataResult, error == nil {
                //MARK: - check if email is verified
                if authDataResult.user.isEmailVerified {
                    FirebaseListener.shared.downloadCurrentUserFromFirebase(userId: authDataResult.user.uid, email: email)
                    completion(nil, true)
                } else {
                    completion(nil, false)
                }
            } else {
                completion(error, false)
            }
        }

    }
}
