//
//  Checklist.swift
//  Checklists
//
//  Created by Heang Ly on 7/16/21.
//

import UIKit

class Checklist: NSObject, Codable {
    var name: String
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
