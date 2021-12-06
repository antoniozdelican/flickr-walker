//
//  ContentViewModelTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 03.12.21.
//

import XCTest
import CoreLocation
@testable import FlickrWalker

class ContentViewModelTests: XCTestCase {
    
    var sut: ContentViewModel!
    var mockFlickrAPIManager: MockFlickrAPIManager!
    var mockImageCache: ImageCache!
    var mockLocationManager: LocationManager!
    
    override func setUp() {
        super.setUp()
        mockFlickrAPIManager = MockFlickrAPIManager()
        mockImageCache = mockImageCacheData
        mockLocationManager = LocationManager()
        sut = ContentViewModel(flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache, locationManager: mockLocationManager)
    }
    
    override func tearDown() {
        sut = nil
        mockFlickrAPIManager = nil
        mockImageCache = nil
        mockLocationManager = nil
        super.tearDown()
    }
    
    func testSearchNotCalledOnFirstLocation() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        XCTAssertFalse(mockFlickrAPIManager.isSearchedCalled)
    }
    
    func testSearchCalledOnSecondLocation() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        XCTAssertTrue(mockFlickrAPIManager.isSearchedCalled)
        XCTAssertEqual(mockFlickrAPIManager.searchRequest.lat, mockLocationTwo.coordinate.latitude)
        XCTAssertEqual(mockFlickrAPIManager.searchRequest.lon, mockLocationTwo.coordinate.longitude)
    }
    
    func testPhotoNotAddedOnSearchError() {
        let error = NetworkError.invalidResponse
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchError(error: error)
        XCTAssertTrue(sut.photos.isEmpty)
    }
    
    func testPhotoAddedOnSearchSuccess() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess()
        XCTAssertFalse(sut.photos.isEmpty)
        XCTAssertEqual(sut.photos.count, 1)
        XCTAssertEqual(sut.photos.first?.id, mockPhotoOne.id)
    }
    
    func testPhotoNotAddedOnSearchPhotosNil() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess(searchResponse: mockSearchResponsePhotosNil)
        XCTAssertTrue(sut.photos.isEmpty)
    }
    
    func testPhotoNotAddedOnSearchPhotosEmpty() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess(searchResponse: mockSearchResponsePhotosEmpty)
        XCTAssertTrue(sut.photos.isEmpty)
    }
    
    func testDuplcicatePhotoNotAddedOnSearchSuccess() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess(searchResponse: mockSearchResponsePhotosDuplicate)
        XCTAssertEqual(sut.photos.count, 1)
    }
    
    func testPhotosAddedInOrderOnSearchSuccess() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess()
        mockFlickrAPIManager.getSearchSuccess()
        mockFlickrAPIManager.getSearchSuccess()
        XCTAssertEqual(sut.photos.count, 3)
        // Photos should be added at the beginning of the array
        XCTAssertEqual(sut.photos[0].id, mockPhotoThree.id)
        XCTAssertEqual(sut.photos[1].id, mockPhotoTwo.id)
        XCTAssertEqual(sut.photos[2].id, mockPhotoOne.id)
    }
    
    func testPhotoNotAddedOnStopUpdatingLocation() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        sut.stopUpdatingLocation()
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        XCTAssertFalse(mockFlickrAPIManager.isSearchedCalled)
    }
    
    func testPhotosAndCacheEmptyOnClearPhotos() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        mockFlickrAPIManager.getSearchSuccess()
        mockFlickrAPIManager.getSearchSuccess()
        XCTAssertEqual(sut.photos.count, 2)
        XCTAssertNotNil(mockImageCache[mockImageOneRequest.path])
        XCTAssertNotNil(mockImageCache[mockImageTwoRequest.path])
        sut.clearPhotos()
        XCTAssertEqual(sut.photos.count, 0)
        XCTAssertNil(mockImageCache[mockImageOneRequest.path])
        XCTAssertNil(mockImageCache[mockImageTwoRequest.path])
    }
    
    func testPhotoCanBeReAddedOnClearPhotos() {
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationOne])
        mockLocationManager.delegate?.locationManager?(mockLocationManager, didUpdateLocations: [mockLocationTwo])
        
        var mockPhotos = Photos(photo: [mockPhotoOne, mockPhotoTwo])
        mockFlickrAPIManager.getSearchSuccess(searchResponse: SearchResponse(photos: mockPhotos))
        mockFlickrAPIManager.getSearchSuccess(searchResponse: SearchResponse(photos: mockPhotos))
        XCTAssertEqual(sut.photos.count, 2)
        mockPhotos = Photos(photo: [mockPhotoOne])
        mockFlickrAPIManager.getSearchSuccess(searchResponse: SearchResponse(photos: mockPhotos))
        XCTAssertEqual(sut.photos.count, 2)
        sut.clearPhotos()
        mockFlickrAPIManager.getSearchSuccess(searchResponse: SearchResponse(photos: mockPhotos))
        XCTAssertEqual(sut.photos.count, 1)
    }

}
