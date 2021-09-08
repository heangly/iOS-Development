//
//  DriverAnnotation.swift
//  UberClone
//
//  Created by Heang Ly on 9/8/21.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D){
        self.uid = uid
        self.coordinate = coordinate
    }
    
}
