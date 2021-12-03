//
//  ContentViewModel.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 03.12.21.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

enum WalkingSate {
    case start, running, stopped
}

enum AlertType {
    case walkingRestart, walkingStopped
}

class ContentViewModel: NSObject, ObservableObject {
    @Published var walkingState: WalkingSate = .start
    @Published var photos = [Photo]()
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private var photoIds = Set<String>()
    private let flickrAPIManager: FlickrAPIManagerProtocol
    private var imageCache: ImageCacheProtocol?
    
    private let locationManager: LocationManager
    private var walkingStarted: Bool = false
    
    init(
        flickrAPIManager: FlickrAPIManagerProtocol = FlickrAPIManager(),
        imageCache: ImageCacheProtocol? = Environment(\.imageCache).wrappedValue
    ) {
        self.flickrAPIManager = flickrAPIManager
        self.imageCache = imageCache
        
        self.locationManager = LocationManager()
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        self.locationManager.delegate = self
    }
    
    // MARK: - Functions
    
    private func search(lat: Double, lon: Double) {
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        flickrAPIManager.search(searchRequest) { [weak self] result in
            switch result {
            case .success(let response):
                self?.addPhoto(from: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addPhoto(from searchResponse: SearchResponse) {
        // Ensure responsePhotos exists and it's not empty
        guard let responsePhotos = searchResponse.photos?.photo, !responsePhotos.isEmpty else {
            return
        }
        // Ensure there's no duplicate photos if they show up in radius
        guard let photo = responsePhotos.first(where: { !photoIds.contains($0.id) }) else {
            return
        }
        photos.insert(photo, at: 0)
        photoIds.insert(photo.id)
    }
    
    func clearPhotos() {
        photos = []
        photoIds = Set<String>()
        imageCache?.clear()
    }
    
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        walkingStarted = false
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Buttons
    
    func openSettingsButtonTapped() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
}

extension ContentViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update last location every 100m as set in distanceFilter
        guard walkingStarted == true else {
            walkingStarted = true
            return
        }
        guard let newLocation = locations.first else {
            return
        }
        search(lat: newLocation.coordinate.latitude, lon: newLocation.coordinate.longitude)
    }
}
