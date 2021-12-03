//
//  NetworkSession.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

protocol NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
    func downloadTask(with request: URLRequest, completion: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask?
}

/// Handles the creation of URLSession task.
class NetworkSession {

    private var session: URLSession!
    
    init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        if #available(iOS 11, *) {
            sessionConfiguration.waitsForConnectivity = true
        }
        self.session = URLSession(configuration: sessionConfiguration)
    }

    deinit {
        session.invalidateAndCancel()
        session = nil
    }
}

extension NetworkSession: NetworkSessionProtocol {
    
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        return dataTask
    }
    
    func downloadTask(with request: URLRequest, completion: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask? {
        let downloadTask = session.downloadTask(with: request) { (url, response, error) in
            completion(url, response, error)
        }
        return downloadTask
    }
}
