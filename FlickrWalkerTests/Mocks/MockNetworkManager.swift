//
//  MockNetworkManager.swift
//  FlickrWalkerTests
//
//  Created by Antonio Zdelican on 07.12.21.
//

import Foundation
@testable import FlickrWalker

class MockNetworkManager: NetworkManagerProtocol {
    
    var isExecuteCalled = false
    var networkRequest: NetworkRequestProtocol!
    var networkCompletion: ((OperationResult) -> Void)!
    
    func execute(request: NetworkRequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask? {
        networkRequest = request
        isExecuteCalled = true
        networkCompletion = completion
        return nil
    }
    
    func getExecuteJsonSuccess(operationResult: OperationResult = OperationResult.json(mockSearchResponse.jsonObject as Any, nil)) {
        networkCompletion(operationResult)
    }
    
    func getExecuteFileSuccess(operationResult: OperationResult = OperationResult.file(mockImageOneData, nil)) {
        networkCompletion(operationResult)
    }
    
    func getExecuteError(operationResult: OperationResult = OperationResult.error(NetworkError.invalidResponse, nil)) {
        networkCompletion(operationResult)
    }
}
