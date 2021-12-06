//
//  MockEntities.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 03.12.21.
//

import Foundation
import SwiftUI
import CoreLocation
@testable import FlickrWalker

var mockPhotoOne = Photo(id: "49159180388", secret: "f73c35240d", server: "65535")
var mockPhotoTwo = Photo(id: "48189047451", secret: "07e0eec527", server: "65535")
var mockPhotoThree = Photo(id: "43373691512", secret: "7d42935bd5", server: "923")
var mockPhotoFour = Photo(id: "38362150061", secret: "8387395e1c", server: "4538")
var mockPhotos = Photos(photo: [mockPhotoOne, mockPhotoTwo, mockPhotoThree, mockPhotoFour])
var mockSearchResponse = SearchResponse(photos: mockPhotos)

var mockSearchResponsePhotosNil = SearchResponse(photos: nil)
var mockEmptyPhotos = Photos(photo: [])
var mockSearchResponsePhotosEmpty = SearchResponse(photos: mockEmptyPhotos)
var mockPhotosDuplicate = Photos(photo: [mockPhotoOne, mockPhotoOne])
var mockSearchResponsePhotosDuplicate = SearchResponse(photos: mockPhotosDuplicate)

var mockImageOne = UIImage(systemName: "figure.walk")!
var mockImageOneData = mockImageOne.pngData()!

var mockImageTwo = UIImage(systemName: "figure.walk")!
var mockImageTwoData = mockImageTwo.pngData()!

var mockImageOneRequest = ImageRequest(id: mockPhotoOne.id, server: mockPhotoOne.server!, secret: mockPhotoOne.secret!)
var mockImageTwoRequest = ImageRequest(id: mockPhotoTwo.id, server: mockPhotoTwo.server!, secret: mockPhotoTwo.secret!)

var mockImageCacheData: ImageCache {
    var imageCache = ImageCache()
    imageCache[mockImageOneRequest.path] = mockImageOneData
    imageCache[mockImageTwoRequest.path] = mockImageTwoData
    return imageCache
}

var mockLocationOne = CLLocation(latitude: 45.81958312506764, longitude: 16.01557795876301)
var mockLocationTwo = CLLocation(latitude: 45.820652345927165, longitude: 16.016768859565623)
var mockLocationThree = CLLocation(latitude: 45.82130284087963, longitude: 16.01757352227009)

