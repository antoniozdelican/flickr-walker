//
//  ImageLoaderViewModelTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 06.12.21.
//

import XCTest
@testable import FlickrWalker

class ImageLoaderViewModelTests: XCTestCase {
    
//    @Published var imageLoadState: ImageLoadState = .loading
//
//    private let imageRequest: ImageRequest
//    private let flickrAPIManager: FlickrAPIManagerProtocol
//    private var imageCache: ImageCacheProtocol?
//    private var isLoading = false
    
    var sut: ImageLoaderViewModel!
    var mockFlickrAPIManager: MockFlickrAPIManager!
    var mockImageCache: ImageCache!
    var mockImageRequest: ImageRequest!
    
    override func setUp() {
        super.setUp()
        mockFlickrAPIManager = MockFlickrAPIManager()
        mockImageCache = ImageCache() // empty image cache
        mockImageRequest = mockImageOneRequest
        sut = ImageLoaderViewModel(imageRequest: mockImageRequest, flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache)
    }
    
    override func tearDown() {
        sut = nil
        mockFlickrAPIManager = nil
        mockImageCache = nil
        mockImageRequest = nil
        super.tearDown()
    }
    
    func testLoadStateIsLoadingOnInit() {
        XCTAssertEqual(sut.imageLoadState, .loading)
    }
    
    func testImageRequestCalledOnLoadImage() {
        sut.loadImage()
        XCTAssertTrue(mockFlickrAPIManager.isImageCalled)
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 1)
    }
    
    func testLoadStateIsSuccessOnImageSuccess() {
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess()
        XCTAssertEqual(sut.imageLoadState, .success(uiImage: UIImage(data: mockImageOneData)!))
    }
    
    func testImageIsCachedOnImageSuccess() {
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess()
        XCTAssertEqual(mockImageCache?[mockImageRequest.path], mockImageOneData)
    }
    
    func testLoadStateIsEmptyOnWrongImageData() {
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess(imageData: Data())
        XCTAssertEqual(sut.imageLoadState, .empty)
    }
    
    func testLoadStateIsErrorOnNetworkError() {
        let error = NetworkError.noData
        sut.loadImage()
        mockFlickrAPIManager.getImageError(error: error as Error)
        XCTAssertEqual(sut.imageLoadState, .error(error: error))
    }
    
    func testImageIsNotCachedOnNetworkError() {
        let error = NetworkError.noData
        sut.loadImage()
        mockFlickrAPIManager.getImageError(error: error as Error)
        XCTAssertNil(mockImageCache?[mockImageRequest.path])
    }
    
    func testImageRequestNotCalledWhenPreviousLoadInProgress() {
        sut.loadImage()
        XCTAssertTrue(mockFlickrAPIManager.isImageCalled)
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 1)
        sut.loadImage()
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 1)
        XCTAssertEqual(sut.imageLoadState, .loading)
        XCTAssertNil(mockImageCache?[mockImageRequest.path])
    }
    
    func testImageRequestNotCalledWhenImageAlreadyCached() {
        sut = ImageLoaderViewModel(imageRequest: mockImageOneRequest, flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache)
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess()
        XCTAssertTrue(mockFlickrAPIManager.isImageCalled)
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 1)
        XCTAssertEqual(sut.imageLoadState, .success(uiImage: UIImage(data: mockImageOneData)!))
        XCTAssertEqual(mockImageCache?[mockImageRequest.path], mockImageOneData)
        sut = ImageLoaderViewModel(imageRequest: mockImageOneRequest, flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache)
        sut.loadImage()
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 1)
    }
    
    func testImageRequestCalledWhenDifferentRequest() {
        sut = ImageLoaderViewModel(imageRequest: mockImageOneRequest, flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache)
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess()
        sut = ImageLoaderViewModel(imageRequest: mockImageTwoRequest, flickrAPIManager: mockFlickrAPIManager, imageCache: mockImageCache)
        sut.loadImage()
        mockFlickrAPIManager.getImageSuccess()
        XCTAssertEqual(mockFlickrAPIManager.imageCallCount, 2)
        XCTAssertEqual(sut.imageLoadState, .success(uiImage: UIImage(data: mockImageTwoData)!))
        XCTAssertEqual(mockImageCache?[mockImageOneRequest.path], mockImageOneData)
        XCTAssertEqual(mockImageCache?[mockImageTwoRequest.path], mockImageTwoData)
    }
}
