//
//  CloudKitManager.swift
//  todo-cloudkit
//
//  Created by Heang Ly on 10/12/21.
//

import Foundation
import CloudKit

enum FetchError {
    case fetchingError, noRecords, none, deletingError, addingError
}


struct CloudKitManager {
    private let RECORD_TYPE = "Task"
    private let CONTAINER_IDENTIFIER = "iCloud.com.heangdev.ToDo-CloudKit"

    func fetchTasks(completion: @escaping([CKRecord]?, FetchError) -> Void) {
        let container = CKContainer(identifier: CONTAINER_IDENTIFIER).publicCloudDatabase
        let query = CKQuery(recordType: RECORD_TYPE, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        container.perform(query, inZoneWith: CKRecordZone.default().zoneID, completionHandler: {
                (records, error) -> Void in
                self.processQueryResponseWith(records: records, error: error as NSError?, completion: {
                    fetchedRecords, fetchError in
                    completion(fetchedRecords, fetchError)
                })
            })
    }

    private func processQueryResponseWith(records: [CKRecord]?, error: NSError?, completion: @escaping([CKRecord]?, FetchError) -> Void) {
        guard error == nil else {
            completion(nil, .fetchingError)
            return
        }

        guard let records = records, records.count > 0 else {
            completion(nil, .noRecords)
            return
        }

        completion(records, .none)
    }

    func deleteRecord(record: CKRecord, completionHandler: @escaping(FetchError) -> Void) {
        let publicDatabase = CKContainer(identifier: CONTAINER_IDENTIFIER).publicCloudDatabase
        publicDatabase.delete(withRecordID: record.recordID) { (recordID, error) -> Void in
            guard let _ = error else {
                completionHandler(.none)
                return
            }

            completionHandler(.deletingError)
        }
    }

    func addTask(_ task: String, completionHandler: @escaping(CKRecord?, FetchError) -> Void) {
        let publicDatabase = CKContainer(identifier: CONTAINER_IDENTIFIER).publicCloudDatabase
        let record = CKRecord(recordType: RECORD_TYPE)

        record.setObject(task as __CKRecordObjCValue, forKey: "title")
        record.setObject(Date() as __CKRecordObjCValue, forKey: "createdAt")
        record.setObject(0 as __CKRecordObjCValue, forKey: "checked")

        publicDatabase.save(record) { record, error in
            guard let _ = error else {
                completionHandler(record, .none)
                return
            }
            completionHandler(nil, .addingError)
        }
    }

    func updateTask(_ task: CKRecord, completionHandler: @escaping(CKRecord?, FetchError) -> Void) {
        let publicDatabase = CKContainer(identifier: CONTAINER_IDENTIFIER).publicCloudDatabase

        publicDatabase.save(task, completionHandler: { (record, error) in
            guard let _ = error else {
                completionHandler(record, .none)
                return
            }

            completionHandler(nil, .addingError)
        })
    }
}
