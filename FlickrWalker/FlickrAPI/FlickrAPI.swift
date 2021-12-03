//
//  FlickrAPI.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

enum FlickrAPI: NetworkRequestProtocol {
    case search(_ request: SearchRequest)
    case image(_ request: ImageRequest)
}

extension FlickrAPI {
    
    var baseUrl: String {
        switch self {
        case .search:
            return "https://api.flickr.com/services/rest/"
        case .image:
            return "https://live.staticflickr.com/"
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return ""
        case .image(let request):
            return request.path
        }
    }

    var method: RequestMethod {
        return .get
    }

    var headers: RequestHeaders? {
        return nil
    }

    var parameters: RequestParameters? {
        switch self {
        case .search(let request):
            return request.jsonObject
        case .image:
            return nil
        }
    }

    var requestType: RequestType {
        switch self {
        case .search:
            return .data
        case .image:
            return .download
        }
    }

    var responseType: ResponseType {
        switch self {
        case .search:
            return .json
        case .image:
            return .file
        }
    }
}
    
