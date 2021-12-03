//
//  NetworkManager.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

protocol NetworkManagerProtocol {
    func execute(request: NetworkRequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask?
}

/// Handles the dispatch of requests with a given configuration.
class NetworkManager: NetworkManagerProtocol {

    private let networkSession: NetworkSessionProtocol

    init(networkSession: NetworkSessionProtocol = NetworkSession()) {
        self.networkSession = networkSession
    }

    func execute(request: NetworkRequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask? {
        guard let urlRequest = request.urlRequest() else {
            DispatchQueue.main.async {
                completion(.error(NetworkError.invalidUrl("\(request)"), nil))
            }
            return nil
        }
        var task: URLSessionTask?
        switch request.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest, completion: { [weak self] (data, urlResponse, error) in
                self?.handleJsonTaskResponse(with: urlRequest, data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
        case .download:
            task = networkSession.downloadTask(with: urlRequest, completion: { [weak self] (fileUrl, urlResponse, error) in
                self?.handleFileTaskResponse(with: fileUrl, urlResponse: urlResponse, error: error, completion: completion)
            })
        }
        task?.resume()

        return task
    }

    private func handleJsonTaskResponse(with request: URLRequest, data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (OperationResult) -> Void) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(OperationResult.error(NetworkError.invalidResponse, nil))
            }
            return
        }
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let json):
                DispatchQueue.main.async {
                    completion(OperationResult.json(json, urlResponse))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(OperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(OperationResult.error(error, urlResponse))
            }
        }
    }
    
    private func handleFileTaskResponse(with fileUrl: URL?, urlResponse: URLResponse?, error: Error?, completion: @escaping (OperationResult) -> Void) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(OperationResult.error(NetworkError.invalidResponse, nil))
            }
            return
        }

        let result = verify(data: fileUrl, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let url):
            let parseResult = parseFile(url: url as? URL)
            switch parseResult {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(OperationResult.file(data, urlResponse))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(OperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(OperationResult.error(error, urlResponse))
            }
        }
    }

    private func parse(data: Data?) -> Result<Any, Error> {
        guard let data = data else {
            return .failure(NetworkError.invalidResponse)
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return .success(json)
        } catch (let error) {
            return .failure(NetworkError.parseError(error.localizedDescription))
        }
    }
    
    private func parseFile(url: URL?) -> Result<Data, Error> {
        guard let url = url else {
            return .failure(NetworkError.invalidResponse)
        }
        do {
            let data = try Data(contentsOf: url)
            return .success(data)
        } catch (let error) {
            return .failure(NetworkError.parseError(error.localizedDescription))
        }
    }

    private func verify(data: Any?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Any, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(NetworkError.noData)
            }
        case 400...499:
            return .failure(NetworkError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(NetworkError.serverError(error?.localizedDescription))
        default:
            return .failure(NetworkError.unknown(error?.localizedDescription))
        }
    }
}

