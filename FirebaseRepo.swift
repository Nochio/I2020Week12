//
//  FirebaseRepo.swift
//  Week 12
//
//  Created by Thomas Hinrichs on 29/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo {
    
    private static let db = Firestore.firestore()
    private static let path = "locations"
    
    static func startListener(vc: ViewController) {
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {
                return
            }
            
            if let snap = snap {
                vc.updateMarkers(snap: snap)
            }
        }
    }
    
    static func addMarkers(title: String, lat: Double, lon: Double) {
        let ref = db.collection(path).document()
        var map = [String: Any]()
        map["text"] = title
        map["coordinates"] = GeoPoint(latitude: lat, longitude: lon)
        ref.setData(map)
    }
    
}
