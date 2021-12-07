//
//  FlickrAPIManager.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

protocol FlickrAPIManagerProtocol {
    func search(_ request: SearchRequest, completion: @escaping (Result<SearchResponse, Error>) -> Void)
    func image(_ request: ImageRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

/// Initializes networkManager, api requests and executes all the api operations
class FlickrAPIManager: FlickrAPIManagerProtocol, ObservableObject {
    
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func search(_ request: SearchRequest, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let request = FlickrAPIRequest.search(request)
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, _):
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, withJSONObject: jsonObject)
                    completion(.success(searchResponse))
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)))
                }
            case .file:
                completion(.failure(NetworkError.invalidResponse))
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
    
    func image(_ request: ImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = FlickrAPIRequest.image(request)
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json:
                completion(.failure(NetworkError.invalidResponse))
            case .file(let fileUrl, _):
                completion(.success(fileUrl))
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
}
