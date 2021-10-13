//
//  CloudKitService.swift
//  Recipe-CloudKit
//
//  Created by Heang Ly on 10/12/21.
//

import CloudKit

extension CKRecord {
    subscript(key: CloudKitService.RecordKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
}

extension CloudKitService {
    enum RecordKey: String {
        case title
        case subtitle
        case ingredients
        case instructions
        case image
    }
}


struct CloudKitService {
    static let CONTAINER_ID = "iCloud.com.heangdev.Recipe-CloudKit"
    let container = CKContainer(identifier: CONTAINER_ID)
    let record = CKRecord(recordType: "Recipe")

    init() {
        configureRecordData()
    }

    private func configureRecordData() {
        record[.title] = "Spaghetti Carbonara"
        record[.ingredients] = ["Spaghetti", "Guanciale", "Eggs"]
    }

    public func getUserICloudStatus() {
        container.accountStatus { status, error in
            if let error = error {
                // some error occurred (probably a failed connection, try again)
                print("status =>  error")
                print(error.localizedDescription)
            } else {
                switch status {
                case .available:
                    // the user is logged in
                    print("status =>  available")
                case .noAccount:
                    // the user is NOT logged in
                    print("status =>  noAccount")
                case .couldNotDetermine:
                    // for some reason, the status could not be determined (try again)
                    print("status =>  cannot determine")
                case .restricted:
                    // iCloud settings are restricted by parental controls or a configuration profile
                    print("status =>  restricted")
                default:
                    print("status =>  uknown default")
                }
            }
        }
    }

    public func fetchUserRecordID(completion: @escaping(CKRecord.ID) -> Void) {
        container.fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print("Error fetching user record")
                return
            }
            completion(recordID)
        }
    }

    public func fetchUserActualRecordData(recordID: CKRecord.ID, completion: @escaping(CKRecord) -> Void) {
        container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                // show off your error handling skills
                return
            }
            completion(record)
            print("The user record is: \(record)")
        }
    }

    public func fetchUserFullName(recordID: CKRecord.ID, completion: @escaping(String) -> Void) {
        
        container.requestApplicationPermission(.userDiscoverability) { status, error in
            guard status == .granted, error == nil else {
                // error handling voodoo
                print("not allow")
                return
            }

            CKContainer.default().discoverUserIdentity(withUserRecordID: recordID) { identity, error in
                guard let components = identity?.nameComponents, error == nil else {
                    // more error handling magic
                    return
                }

                DispatchQueue.main.async {
                    let fullName = PersonNameComponentsFormatter().string(from: components)
                    completion(fullName)
                    print("The user's full name is \(fullName)")
                }
            }
        }
    }


}

