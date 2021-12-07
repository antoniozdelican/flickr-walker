//
//  NetworkRequestTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class NetworkRequestTests: XCTestCase {
    
    func test_init_withGoodData_shouldReturnNetworkRequestObject() {
        let networkRequest = MockNetworkRequest.goodRequest
        let urlRequest = networkRequest.urlRequest()
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(urlRequest?.url, URL(string: "https://myserver.com/search?photoId=12345abcd"))
        XCTAssertEqual(urlRequest?.url?.query, "photoId=12345abcd")
        
        var urlComponents = URLComponents(string: networkRequest.baseUrl)!
        urlComponents.path = urlComponents.path + networkRequest.path
        urlComponents.queryItems = [URLQueryItem(name: networkRequest.parameters!.keys.first!, value: networkRequest.parameters!.values.first as? String)]
        XCTAssertEqual(urlRequest?.url, urlComponents.url)
    }
    
    func test_init_withBadData_shouldNotReturnNetworkRequestObject() {
        let networkRequest = MockNetworkRequest.badRequest
        let urlRequest = networkRequest.urlRequest()
        XCTAssertNil(urlRequest)
    }
}
