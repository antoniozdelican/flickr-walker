//
//  MockFlickrAPIManager.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 03.12.21.
//

import Foundation
@testable import FlickrWalker

class MockFlickrAPIManager: FlickrAPIManagerProtocol {
    
    var isSearchedCalled = false
    var isImageCalled = false
    var searchRequest: SearchRequest!
    var imageRequest: ImageRequest!
    var searchCompletion: ((Result<SearchResponse, Error>) -> Void)!
    var imageCompletion: ((Result<Data, Error>) -> Void)!
    var imageCallCount = 0
    
    func search(_ request: SearchRequest, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        searchRequest = request
        isSearchedCalled = true
        searchCompletion = completion
    }
    
    func getSearchSuccess(searchResponse: SearchResponse = mockSearchResponse) {
        searchCompletion(.success(searchResponse))
    }
    
    func getSearchError(error: Error) {
        searchCompletion(.failure(error))
    }
    
    func image(_ request: ImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        imageRequest = request
        isImageCalled = true
        imageCompletion = completion
        imageCallCount += 1
    }
    
    func getImageSuccess(imageData: Data = mockImageOneData) {
        imageCompletion(.success(imageData))
    }
    
    func getImageError(error: Error) {
        imageCompletion(.failure(error))
    }
}
