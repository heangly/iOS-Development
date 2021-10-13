//
//  ViewController.swift
//  Recipe-CloudKit
//
//  Created by Heang Ly on 10/12/21.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    let cloudKitService = CloudKitService()

    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        cloudKitService.getUserICloudStatus()
        
        cloudKitService.fetchUserRecordID { recordID in
           print("record id => ", recordID)
            
            self.cloudKitService.fetchUserActualRecordData(recordID: recordID) { record in
                print("actual record =>", record)
                
                self.cloudKitService.fetchUserFullName(recordID: recordID
                ) { fullname in
                    print("fullname => ", fullname)
                }
            }
        }
  
    }
    
    @IBAction func subscribeButtonTapped(_ sender: Any) {
        print("subsribe")
    }


}

