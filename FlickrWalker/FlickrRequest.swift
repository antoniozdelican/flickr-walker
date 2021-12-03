//
//  FlickrRequest.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

// every 100m request with some parameters
struct FlickRequest: Codable {
    var number: String?
    var cvv: String?
    var expirationMonth: String?
    var expirationYear: String?
    var cardholderName: String?
}
