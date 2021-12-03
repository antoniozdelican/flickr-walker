//
//  ContentViewModelTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 03.12.21.
//

import XCTest
@testable import FlickrWalker

class ContentViewModelTests: XCTestCase {
    
    var sut: ContentViewModel!
    var flickrAPIManager: FlickrAPIManagerProtocol!
    var imageCache: ImageCacheProtocol!
    
    override func setUp() {
        super.setUp()
        flickrAPIManager = MockFlickrAPIManager()
        imageCache = mockImageCache
        sut = ContentViewModel(flickrAPIManager: flickrAPIManager, imageCache: imageCache)
    }
    
    override func tearDown() {
        sut = nil
        flickrAPIManager = nil
        imageCache = nil
        super.tearDown()
    }
    
    // MARK: Search
    
    // TODO: On Monday

}
