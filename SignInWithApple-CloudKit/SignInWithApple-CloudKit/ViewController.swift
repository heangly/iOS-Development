//
//  ViewController.swift
//  SignInWithApple-CloudKit
//
//  Created by Heang Ly on 10/12/21.
//


import UIKit
import AuthenticationServices
import CloudKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signInBtnView: UIView!

    var authorizationButton: ASAuthorizationAppleIDButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        authorizationButton = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        authorizationButton.frame = CGRect(origin: .zero, size: signInBtnView.frame.size)
        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        signInBtnView.addSubview(authorizationButton)

    }

    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}


extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let privateDatabase = CKContainer(identifier: "iCloud.com.heangdev.SignInWithApple").privateCloudDatabase
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            if let name = appleIDCredential.fullName?.givenName,
                let emailAddr = appleIDCredential.email {
                //New user (Signing up).
                //Save this information to CloudKit
                let record = CKRecord(recordType: "UserInfo", recordID: CKRecord.ID(recordName: userID))
                record["name"] = name
                record["emailAddress"] = emailAddr
                privateDatabase.save(record) { (_, _) in
                    UserDefaults.standard.set(record.recordID.recordName, forKey: "userProfileID")
                }
            } else {
                //Returning user (signing in)
                //Fetch the user name/ email address
                //from private CloudKit


                privateDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
                    if let fetchedInfo = record {
                        let name = fetchedInfo["name"] as? String
                        let userEmailAddr = fetchedInfo["emailAddress"] as? String
                        //You can now use the user name and email address (like save it to local)
                        UserDefaults.standard.set(name, forKey: "userName")
                        UserDefaults.standard.set(userID, forKey: "userProfileID")
                    }
                }

            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //Failed
        print(error.localizedDescription)
    }


    func getUserLikedAnimals() {
        let privateDatabase = CKContainer(identifier: "iCloud.com.heangdev.SignInWithApple").privateCloudDatabase
        if let userCloudID = UserDefaults.standard.string(forKey: "userProfileID") {
            let recordID = CKRecord.ID(recordName: userCloudID)
            privateDatabase.fetch(withRecordID: recordID) { (fetchedRecord, error) in
                if error == nil {
                    let likedAnimals = fetchedRecord?.value(forKey: "likedAnimals") as? [String]
                    //TODO
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }

    func updateUserLikedAnimals(newAnimal: String) {
        let privateDatabase = CKContainer(identifier: "iCloud.com.heangdev.SignInWithApple").privateCloudDatabase
        if let userCloudID = UserDefaults.standard.string(forKey: "userProfileID") {
            let recordID = CKRecord.ID(recordName: userCloudID)
            privateDatabase.fetch(withRecordID: recordID) { (record, error) in
                guard let fetchedRecord = record else { return }
                if error == nil {
                    var likedAnimals = fetchedRecord.value(forKey: "likedAnimals") as? [String] ?? []
                    likedAnimals.append(newAnimal)
                    //更新記録
                    privateDatabase.save(fetchedRecord) { (modifiedRecord, error) in
                        if error != nil {
                            //失敗
                            print(error?.localizedDescription)
                        } else {
                            //成功
                        }
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
}


