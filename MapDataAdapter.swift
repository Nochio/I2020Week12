//
//  MapDataAdapter.swift
//  Week 12
//
//  Created by Thomas Hinrichs on 29/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter {
    
    static func getMKAnnotationsFromData(snap: QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]()
        for doc in snap.documents {
            print("received data: ")
            let map = doc.data()
            let text = map["text"] as! String
            let geoPoint = map["coordinates"] as! GeoPoint
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
        return markers
    }
    
}
