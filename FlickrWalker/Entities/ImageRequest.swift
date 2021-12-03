//
//  ImageRequest.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 30.11.21.
//

import Foundation

struct ImageRequest: Codable {
    let id: String
    let server: String
    let secret: String
    let sizeSuffix: String
    
    var path: String {
        // /{server-id}/{id}_{secret}_{size-suffix}.jpg
        let pathFormat = "/%@/%@_%@_%@.jpg"
        return String(format: pathFormat, server, id, secret, sizeSuffix)
    }
    
    init(id: String, server: String, secret: String, sizeSuffix: String = FlickrConstants.imageSizeSuffix) {
        self.id = id
        self.server = server
        self.secret = secret
        self.sizeSuffix = sizeSuffix
    }
}
