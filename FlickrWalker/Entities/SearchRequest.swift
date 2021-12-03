//
//  SearchRequest.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

struct FlickrConstants {
    static let apiKey = "2c82bf1222ff33464507511cc73b52c2"
    static let method = "flickr.photos.search"
    /// json format
    static let format = "json"
    static let noJsonCallback = 1
    /// Photos from 2000 onwards
    static let minUploadDate = "2000-01-01T00:00:00Z"
    /// Only outdoor photos
    static let geoContext = 2
    /// Photos in radius of 100m (1 is 1000m)
    static let radius = 0.1
    /// Photos are small and upto 400px
    static let imageSizeSuffix = "w"
}

struct SearchRequest: Codable {
    let method: String
    let apiKey: String
    let format: String
    let noJsonCallback: Int
    let minUploadDate: String
    let geoContext: Int
    let lat: Double
    let lon: Double
    let radius: Double
    
    init(method: String = FlickrConstants.method,
         apiKey: String = FlickrConstants.apiKey,
         format: String = FlickrConstants.format,
         noJsonCallback: Int = FlickrConstants.noJsonCallback,
         minUploadDate: String = FlickrConstants.minUploadDate,
         geoContext: Int = FlickrConstants.geoContext,
         radius: Double = FlickrConstants.radius,
         lat: Double,
         lon: Double) {
        self.method = method
        self.apiKey = apiKey
        self.format = format
        self.noJsonCallback = noJsonCallback
        self.minUploadDate = minUploadDate
        self.geoContext = geoContext
        self.radius = radius
        self.lat = lat
        self.lon = lon
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case noJsonCallback = "nojsoncallback"
        case minUploadDate = "min_upload_date"
        case geoContext = "geo_context"
        case method, format, radius, lat, lon
    }
}
