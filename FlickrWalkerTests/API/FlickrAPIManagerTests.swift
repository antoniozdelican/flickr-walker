//
//  FlickrAPIManagerTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 06.12.21.
//

import XCTest
@testable import FlickrWalker

class FlickrAPIManagerTests: XCTestCase {
    
    var sut: FlickrAPIManager!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = FlickrAPIManager(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func test_search_withData_shouldReturnSuccess() {
        var searchResponse: SearchResponse?
        var errorMessage: String?
        let expectation = XCTestExpectation(description: "Request succeeded")
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        
        sut.search(searchRequest) { response in
            switch response {
            case .success(let successResponse):
                searchResponse = successResponse
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
            expectation.fulfill()
        }
        
        mockNetworkManager.getExecuteJsonSuccess()
        
        XCTAssertNotNil(searchResponse)
        XCTAssertEqual(searchResponse?.photos?.photo?.first?.id, "49159180388")
        XCTAssertNil(errorMessage)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_search_withImageData_shouldReturnSuccess() {
        var imageData: Data?
        var errorMessage: String?
        let expectation = XCTestExpectation(description: "Request succeeded")
        let imageRequest = mockImageOneRequest
        
        sut.image(imageRequest) { response in
            switch response {
            case .success(let data):
                imageData = data
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
            expectation.fulfill()
        }
        
        mockNetworkManager.getExecuteFileSuccess()
        
        XCTAssertNotNil(imageData)
        XCTAssertEqual(imageData, mockImageOneData)
        XCTAssertNil(errorMessage)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_search_withError_shouldReturnError() {
        var searchResponse: SearchResponse?
        var errorMessage: String?
        let expectation = XCTestExpectation(description: "Request errored")
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        
        sut.search(searchRequest) { response in
            switch response {
            case .success(let successResponse):
                searchResponse = successResponse
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
            expectation.fulfill()
        }
        
        mockNetworkManager.getExecuteError(operationResult: OperationResult.error(NetworkError.invalidResponse, nil))
        
        XCTAssertNil(searchResponse)
        XCTAssertNotNil(errorMessage)
        XCTAssertEqual(errorMessage, "Invalid response error")
        
        wait(for: [expectation], timeout: 10.0)
    }

}
