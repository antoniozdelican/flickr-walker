//
//  SearchResponseTests.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import XCTest
@testable import FlickrWalker

class SearchResponseTests: XCTestCase {
    
    func test_init_withPhotosArray_shouldReturnObject() {
        let photoOne = Photo(id: "49159180388", secret: "f73c35240d", server: "65535")
        let photoTwo = Photo(id: "48189047451", secret: "07e0eec527", server: "65535")
        let photoThree = Photo(id: "43373691512", secret: "7d42935bd5", server: "923")
        let photos = Photos(photo: [photoOne, photoTwo, photoThree])
        let searchResponse = SearchResponse(photos: photos)
        
        XCTAssertNotNil(searchResponse.photos)
        XCTAssertNotNil(searchResponse.photos?.photo)
        XCTAssertEqual(searchResponse.photos?.photo?.count, 3)
        XCTAssertEqual(searchResponse.photos?.photo?[0].id, photoOne.id)
        XCTAssertEqual(searchResponse.photos?.photo?[1].id, photoTwo.id)
        XCTAssertEqual(searchResponse.photos?.photo?[2].id, photoThree.id)
    }
    
    func test_init_withEmptyPhotosArray_shouldReturnEmptyPhotosArrayObject() {
        let photos = Photos(photo: [])
        let searchResponse = SearchResponse(photos: photos)
        
        XCTAssertNotNil(searchResponse.photos)
        XCTAssertNotNil(searchResponse.photos?.photo)
        XCTAssertEqual(searchResponse.photos?.photo?.count, 0)
    }
    
    func test_init_withoutPhotosArray_shouldReturnEmptyPhotosObject() {
        let photos = Photos(photo: nil)
        let searchResponse = SearchResponse(photos: photos)
        
        XCTAssertNotNil(searchResponse.photos)
        XCTAssertNil(searchResponse.photos?.photo)
    }
    
    func test_init_withoutPhotosObject_shouldReturnEmptyPhotoObject() {
        let searchResponse = SearchResponse(photos: nil)
        
        XCTAssertNil(searchResponse.photos)
    }
    
    func test_init_withPhotosArray_shouldHaveCorrectJsonObject() {
        let photoOne = Photo(id: "49159180388", secret: "f73c35240d", server: "65535")
        let photoTwo = Photo(id: "48189047451", secret: "07e0eec527", server: "65535")
        let photoThree = Photo(id: "43373691512", secret: "7d42935bd5", server: "923")
        let photos = Photos(photo: [photoOne, photoTwo, photoThree])
        let searchResponse = SearchResponse(photos: photos)
        
        let jsonObject = searchResponse.jsonObject
        XCTAssertNotNil(jsonObject)
        let jsonPhotos = jsonObject?["photos"] as? [String: Any]
        XCTAssertNotNil(jsonPhotos)
        let jsonPhoto = jsonPhotos?["photo"]
        XCTAssertNotNil(jsonPhoto)
        let jsonPhotoArray = jsonPhoto as? Array<Any>
        XCTAssertNotNil(jsonPhotoArray)
        let jsonFirstPhoto = jsonPhotoArray?[0] as? [String: Any]
        XCTAssertNotNil(jsonFirstPhoto)
        XCTAssertEqual(jsonFirstPhoto?["id"] as? String, photoOne.id)
        XCTAssertEqual(jsonFirstPhoto?["secret"] as? String, photoOne.secret)
        XCTAssertEqual(jsonFirstPhoto?["server"] as? String, photoOne.server)
    }
}
