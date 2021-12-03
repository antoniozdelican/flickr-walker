//
//  MockEntities.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 03.12.21.
//

import Foundation
import SwiftUI
@testable import FlickrWalker

var mockPhotoOne = Photo(id: "49159180388", secret: "f73c35240d", server: "65535")
var mockPhotoTwo = Photo(id: "48189047451", secret: "07e0eec527", server: "65535")
var mockPhotoThree = Photo(id: "43373691512", secret: "7d42935bd5", server: "923")
var mockPhotoFour = Photo(id: "38362150061", secret: "8387395e1c", server: "4538")
var mockPhotos = Photos(photo: [mockPhotoOne, mockPhotoTwo, mockPhotoThree, mockPhotoFour])
var mockSearchResponse = SearchResponse(photos: mockPhotos)

var mockImageOne = UIImage(systemName: "figure.walk")!
var mockImageOneData = mockImageOne.pngData()!

var mockImageTwo = UIImage(systemName: "figure.walk")!
var mockImageTwoData = mockImageTwo.pngData()!

var mockImageOneRequest = ImageRequest(id: mockPhotoOne.id, server: mockPhotoOne.server!, secret: mockPhotoOne.secret!)
var mockImageTwoRequest = ImageRequest(id: mockPhotoTwo.id, server: mockPhotoTwo.server!, secret: mockPhotoTwo.secret!)

var mockImageCache: ImageCache {
    var imageCache = ImageCache()
    imageCache[mockImageOneRequest.path] = mockImageOneData
    imageCache[mockImageTwoRequest.path] = mockImageTwoData
    return imageCache
}

