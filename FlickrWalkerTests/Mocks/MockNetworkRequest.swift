//
//  MockNetworkRequest.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import Foundation
@testable import FlickrWalker

enum MockNetworkRequest: NetworkRequestProtocol {
    case goodRequest, badRequest, imageRequest
}

extension MockNetworkRequest {
    
    var baseUrl: String {
        switch self {
        case .goodRequest:
            return "https://myserver.com/"
        case .badRequest:
            return "https:\\myserver.com/"
        case .imageRequest:
            return "https://myimageserver.com/"
        }
    }
    
    var path: String {
        switch self {
        case .goodRequest:
            return "search"
        case .badRequest:
            return ""
        case .imageRequest:
            return "fetch"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var headers: RequestHeaders? {
        switch self {
        case .goodRequest,
             .badRequest:
            var header: [String: String] = [:]
            header["Accept"] = "application/json"
            return header
        case .imageRequest:
            return nil
        }
    }

    var parameters: RequestParameters? {
        var parameters: [String: Any?] = [:]
        parameters["photoId"] = "12345abcd"
        return parameters
    }

    var requestType: RequestType {
        switch self {
        case .goodRequest,
             .badRequest:
            return .data
        case .imageRequest:
            return .download
        }
    }

    var responseType: ResponseType {
        switch self {
        case .goodRequest,
             .badRequest:
            return .json
        case .imageRequest:
            return .file
        }
    }
}
