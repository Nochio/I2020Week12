//
//  ViewController.swift
//  Week 12
//
//  Created by Thomas Hinrichs on 24/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var placeText: UITextField!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        FirebaseRepo.startListener(vc: self)
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        
        gestureRecognizer.minimumPressDuration = 3
        map.addGestureRecognizer(gestureRecognizer)
        
       }
    
    func updateMarkers(snap: QuerySnapshot) {
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.map)
            let touchedCoordinates = self.map.convert(touchedPoint, toCoordinateFrom: self.map)
            
            FirebaseRepo.addMarkers(title: placeText.text ?? "", lat: touchedCoordinates.latitude, lon: touchedCoordinates.longitude)
            
          /*  let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = placeText.text
            self.map.addAnnotation(annotation)*/
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }
    
}

