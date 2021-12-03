//
//  NetworkError.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

enum NetworkError: LocalizedError {
    case noData
    case invalidResponse
    case invalidUrl(String?)
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown(String?)
}

extension NetworkError {
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data error"
        case .invalidResponse:
            return "Invalid response error"
        case .invalidUrl(let description):
            if let description = description {
                return description
            } else {
                return "Invalid url error"
            }
        case .badRequest(let description):
            if let description = description {
                return description
            } else {
                return "Client error"
            }
        case .serverError(let description):
            if let description = description {
                return description
            } else {
                return "Server error"
            }
        case .parseError(let description):
            if let description = description {
                return description
            } else {
                return "Parsing error"
            }
        case .unknown(let description):
            if let description = description {
                return description
            } else {
                return "Unknown error"
            }
        }
    }
}
