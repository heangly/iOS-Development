//
//  Person.swift
//  NamesToFaces
//
//  Created by Heang Ly on 7/12/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
