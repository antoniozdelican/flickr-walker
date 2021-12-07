//
//  NetworkSessionTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class NetworkSessionTests: XCTestCase {
    
    func test_dataTask_withParameters_shouldReturnURLSessionDataTask() {
        let networkRequest = MockNetworkRequest.goodRequest
        let data = try! JSONSerialization.data(withJSONObject: mockSearchResponse.jsonObject as Any)
        let urlResponse = URLResponse(url: networkRequest.urlRequest()!.url!, mimeType: "text", expectedContentLength: 1, textEncodingName: "name")
        let completion: (Data?, URLResponse?, Error?) -> Void = { _,_,_ in }
        completion(data, urlResponse, nil)
        let networkSession = NetworkSession()
        
        let dataTask = networkSession.dataTask(with: networkRequest.urlRequest()!, completion: completion)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask?.originalRequest?.url, networkRequest.urlRequest()?.url)
        XCTAssertEqual(dataTask?.originalRequest?.url, networkRequest.urlRequest()?.url)
    }
    
    func test_downloadTask_withParameters_shouldReturnURLSessionDownloadTask() {
        let networkRequest = MockNetworkRequest.imageRequest
        let url = networkRequest.urlRequest()!.url!
        let urlResponse = URLResponse(url: networkRequest.urlRequest()!.url!, mimeType: "image", expectedContentLength: 1, textEncodingName: "name")
        let completion: (URL?, URLResponse?, Error?) -> Void = { _,_,_ in }
        completion(url, urlResponse, nil)
        let networkSession = NetworkSession()
        
        let dataTask = networkSession.downloadTask(with: networkRequest.urlRequest()!, completion: completion)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask?.originalRequest?.url, networkRequest.urlRequest()?.url)
    }
}
