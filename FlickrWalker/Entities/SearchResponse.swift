//
//  SearchResponse.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

struct SearchResponse: Codable {
    let photos: Photos?
}

struct Photos: Codable {
    let photo: [Photo]?
}

struct Photo: Codable, Identifiable {
    var id: String
    let secret: String?
    let server: String?
}
