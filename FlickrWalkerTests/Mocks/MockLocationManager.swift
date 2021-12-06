//
//  MockLocationManager.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 06.12.21.
//

import Foundation
import CoreLocation
@testable import FlickrWalker

class MockLocationManager: LocationManager {
    
    var mockLocation: CLLocation?
    
    // callback to provide mock locations
    var handleRequestLocation: (() -> CLLocation)?
    
    override var location: CLLocation? {
        return mockLocation
    }
    
}
