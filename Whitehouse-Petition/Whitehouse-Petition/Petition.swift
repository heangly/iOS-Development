//
//  Petition.swift
//  Whitehouse-Petition
//
//  Created by Heang Ly on 6/29/21.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
