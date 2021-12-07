//
//  NetworkErrorTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class NetworkErrorTests: XCTestCase {
    
    func test_init_withNoData_shouldReturnNetworkErrorObject() {
        let networkError = NetworkError.noData
        XCTAssertEqual(networkError.localizedDescription, "No data error")
    }
    
    func test_init_withInvalidResponse_shouldReturnNetworkErrorObject() {
        let networkError = NetworkError.invalidResponse
        XCTAssertEqual(networkError.localizedDescription, "Invalid response error")
    }
    
    func test_init_withInvalidUrl_shouldReturnNetworkErrorObject() {
        let networkErrorOne = NetworkError.invalidUrl(nil)
        XCTAssertEqual(networkErrorOne.localizedDescription, "Invalid url error")
        let networkErrorTwo = NetworkError.invalidUrl("Some invalid url")
        XCTAssertEqual(networkErrorTwo.localizedDescription, "Some invalid url")
    }
    
    func test_init_withBadRequest_shouldReturnNetworkErrorObject() {
        let networkErrorOne = NetworkError.badRequest(nil)
        XCTAssertEqual(networkErrorOne.localizedDescription, "Client error")
        let networkErrorTwo = NetworkError.badRequest("Some bad request")
        XCTAssertEqual(networkErrorTwo.localizedDescription, "Some bad request")
    }
    
    func test_init_withServerError_shouldReturnNetworkErrorObject() {
        let networkErrorOne = NetworkError.serverError(nil)
        XCTAssertEqual(networkErrorOne.localizedDescription, "Server error")
        let networkErrorTwo = NetworkError.serverError("Some server error")
        XCTAssertEqual(networkErrorTwo.localizedDescription, "Some server error")
    }
    
    func test_init_withParseError_shouldReturnNetworkErrorObject() {
        let networkErrorOne = NetworkError.parseError(nil)
        XCTAssertEqual(networkErrorOne.localizedDescription, "Parsing error")
        let networkErrorTwo = NetworkError.parseError("Some parsing error")
        XCTAssertEqual(networkErrorTwo.localizedDescription, "Some parsing error")
    }
    
    func test_init_withUnknownError_shouldReturnNetworkErrorObject() {
        let networkErrorOne = NetworkError.unknown(nil)
        XCTAssertEqual(networkErrorOne.localizedDescription, "Unknown error")
        let networkErrorTwo = NetworkError.unknown("Some unknown error")
        XCTAssertEqual(networkErrorTwo.localizedDescription, "Some unknown error")
    }
    
}
