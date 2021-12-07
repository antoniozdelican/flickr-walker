//
//  ImageRequestTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class ImageRequestTests: XCTestCase {
    
    func test_init_withData_shouldReturnObject() {
        let id = "49159180388"
        let secret = "f73c35240d"
        let server = "65535"
        let imageRequest = ImageRequest(id: id, server: server, secret: secret)
        
        XCTAssertEqual(imageRequest.id, id)
        XCTAssertEqual(imageRequest.secret, secret)
        XCTAssertEqual(imageRequest.server, server)
        XCTAssertEqual(imageRequest.sizeSuffix, "w")
        XCTAssertEqual(imageRequest.path, "/\(server)/\(id)_\(secret)_w.jpg")
    }
    
    func test_init_withData_shouldHaveCorrectJsonObject() {
        let id = "49159180388"
        let secret = "f73c35240d"
        let server = "65535"
        let imageRequest = ImageRequest(id: id, server: server, secret: secret)

        let jsonObject = imageRequest.jsonObject
        XCTAssertNotNil(imageRequest)
        XCTAssertEqual(jsonObject?["id"] as? String, id)
        XCTAssertEqual(jsonObject?["secret"] as? String, secret)
        XCTAssertEqual(jsonObject?["server"] as? String, server)
        XCTAssertEqual(jsonObject?["sizeSuffix"] as? String, "w")
    }
}
