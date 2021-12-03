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
    var searchCompletion: ((Result<SearchResponse, Error>) -> Void)!
    var imageCompletion: ((Result<Data, Error>) -> Void)!
    
    func search(_ request: SearchRequest, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        isSearchedCalled = true
        searchCompletion = completion
    }
    
    func getSearchSuccess() {
        searchCompletion(.success(mockSearchResponse))
    }
    
    func getSearchError(error: Error) {
        searchCompletion(.failure(error))
    }
    
    func image(_ request: ImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        isImageCalled = true
        imageCompletion = completion
    }
    
    func getImageSuccess() {
        imageCompletion(.success(mockImageData))
    }
    
    func getImageError(error: Error) {
        imageCompletion(.failure(error))
    }
}
