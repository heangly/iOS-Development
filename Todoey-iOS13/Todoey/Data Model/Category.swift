//
//  Category.swift
//  Todoey
//
//  Created by Heang Ly on 6/26/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let item = List<Item>()
}
