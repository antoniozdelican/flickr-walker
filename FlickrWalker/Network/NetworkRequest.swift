//
//  NetworkRequest.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

enum RequestType {
    case data
    case download
}

enum ResponseType {
    case json
    case file
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias RequestHeaders = [String: String]
typealias RequestParameters = [String : Any?]

/// Protocol to which all APIRequests need to conform.
protocol NetworkRequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: RequestHeaders? { get }
    var parameters: RequestParameters? { get }
    var requestType: RequestType { get }
    var responseType: ResponseType { get }
}

extension NetworkRequestProtocol {

    func urlRequest() -> URLRequest? {
        guard let url = url(with: baseUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }

    private func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else {
            return nil
        }
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value ?? "")
            return URLQueryItem(name: key, value: valueString)
        }
    }
}
