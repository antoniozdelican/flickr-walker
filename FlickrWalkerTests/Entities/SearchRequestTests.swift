//
//  SearchRequestTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class SearchRequestTests: XCTestCase {
    
    func test_init_withDefaultData_shouldReturnObject() {
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        
        XCTAssertEqual(searchRequest.lat, lat)
        XCTAssertEqual(searchRequest.lon, lon)
        XCTAssertEqual(searchRequest.apiKey, "2c82bf1222ff33464507511cc73b52c2")
        XCTAssertEqual(searchRequest.method, "flickr.photos.search")
        XCTAssertEqual(searchRequest.format, "json")
        XCTAssertEqual(searchRequest.noJsonCallback, 1)
        XCTAssertEqual(searchRequest.minUploadDate, "2000-01-01T00:00:00Z")
        XCTAssertEqual(searchRequest.geoContext, 2)
        XCTAssertEqual(searchRequest.radius, 0.1)
    }
    
    func test_init_withCustomData_shouldReturnObject() {
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let apiKey = "abcd12345"
        let method = "flickr.photos.lookup"
        let format = "xml"
        let noJsonCallback = 0
        let minUploadDate = "2012-01-01T00:00:00Z"
        let geoContext = 1
        let radius = 10.0
        let searchRequest = SearchRequest(method: method, apiKey: apiKey, format: format, noJsonCallback: noJsonCallback, minUploadDate: minUploadDate, geoContext: geoContext, radius: radius, lat: lat, lon: lon)
        
        XCTAssertEqual(searchRequest.lat, lat)
        XCTAssertEqual(searchRequest.lon, lon)
        XCTAssertEqual(searchRequest.apiKey, "abcd12345")
        XCTAssertEqual(searchRequest.method, "flickr.photos.lookup")
        XCTAssertEqual(searchRequest.format, "xml")
        XCTAssertEqual(searchRequest.noJsonCallback, 0)
        XCTAssertEqual(searchRequest.minUploadDate, "2012-01-01T00:00:00Z")
        XCTAssertEqual(searchRequest.geoContext, 1)
        XCTAssertEqual(searchRequest.radius, 10.0)
    }
    
    func test_init_withDefaultData_shouldHaveCorrectJsonObject() {
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        
        let jsonObject = searchRequest.jsonObject
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["lat"] as? Double, lat)
        XCTAssertEqual(jsonObject?["lon"] as? Double, lon)
        XCTAssertEqual(jsonObject?["api_key"] as? String, "2c82bf1222ff33464507511cc73b52c2")
        XCTAssertEqual(jsonObject?["method"] as? String, "flickr.photos.search")
        XCTAssertEqual(jsonObject?["format"] as? String, "json")
        XCTAssertEqual(jsonObject?["nojsoncallback"] as? Int, 1)
        XCTAssertEqual(jsonObject?["min_upload_date"] as? String, "2000-01-01T00:00:00Z")
        XCTAssertEqual(jsonObject?["geo_context"] as? Int, 2)
        XCTAssertEqual(jsonObject?["radius"] as? Double, 0.1)
    }
}
