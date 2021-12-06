//
//  LocationManager.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 03.12.21.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager {
    
    override init() {
        super.init()
        self.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.allowsBackgroundLocationUpdates = true
        self.distanceFilter = 100
    }
}

//extension CLLocationManager: LocationManagerProtocol {
//    
//}
//
//protocol LocationManagerDelegate {
//    func locationManager(_ manager: LocationManagerProtocol, didUpdateLocations locations: [CLLocation])
//    func locationManager(_ manager: LocationManagerProtocol, didChangeAuthorization status: CLAuthorizationStatus)
//}
