//
//  FlickrAPIRequestTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 06.12.21.
//

import XCTest
@testable import FlickrWalker

class FlickrAPIRequestTests: XCTestCase {
    
    func test_initSearch_withSearchRequestData_shouldReturnFlickrAPISearchRequest() {
        let lat = 45.81958312506764
        let lon = 16.01557795876301
        let searchRequest = SearchRequest(lat: lat, lon: lon)
        
        let flickrAPISearchRequest = FlickrAPIRequest.search(searchRequest)
        
        XCTAssertEqual(flickrAPISearchRequest.baseUrl, "https://api.flickr.com/services/rest/")
        XCTAssertEqual(flickrAPISearchRequest.path, "")
        XCTAssertEqual(flickrAPISearchRequest.method, .get)
        XCTAssertNil(flickrAPISearchRequest.headers)
        XCTAssertEqual(flickrAPISearchRequest.parameters?["lat"] as? Double, lat)
        XCTAssertEqual(flickrAPISearchRequest.parameters?["lon"] as? Double, lon)
        XCTAssertEqual(flickrAPISearchRequest.parameters?["api_key"] as? String, "2c82bf1222ff33464507511cc73b52c2")
        XCTAssertEqual(flickrAPISearchRequest.parameters?["method"] as? String, "flickr.photos.search")
        XCTAssertEqual(flickrAPISearchRequest.parameters?["format"] as? String, "json")
        XCTAssertEqual(flickrAPISearchRequest.parameters?["nojsoncallback"] as? Int, 1)
        XCTAssertEqual(flickrAPISearchRequest.parameters?["min_upload_date"] as? String, "2000-01-01T00:00:00Z")
        XCTAssertEqual(flickrAPISearchRequest.parameters?["geo_context"] as? Int, 2)
        XCTAssertEqual(flickrAPISearchRequest.parameters?["radius"] as? Double, 0.1)
        XCTAssertEqual(flickrAPISearchRequest.requestType, .data)
        XCTAssertEqual(flickrAPISearchRequest.responseType, .json)
    }
    
    func test_initImage_withImageRequestData_shouldReturnFlickrAPIImageRequest() {
        let id = "49159180388"
        let secret = "f73c35240d"
        let server = "65535"
        let imageRequest = ImageRequest(id: id, server: server, secret: secret)
        
        let flickrAPIImageRequest = FlickrAPIRequest.image(imageRequest)
        
        XCTAssertEqual(flickrAPIImageRequest.baseUrl, "https://live.staticflickr.com/")
        XCTAssertEqual(flickrAPIImageRequest.path, "/\(server)/\(id)_\(secret)_w.jpg")
        XCTAssertEqual(flickrAPIImageRequest.method, .get)
        XCTAssertNil(flickrAPIImageRequest.headers)
        XCTAssertNil(flickrAPIImageRequest.parameters)
        XCTAssertEqual(flickrAPIImageRequest.requestType, .download)
        XCTAssertEqual(flickrAPIImageRequest.responseType, .file)
    }

}
