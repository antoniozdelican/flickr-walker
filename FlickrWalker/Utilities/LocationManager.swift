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
