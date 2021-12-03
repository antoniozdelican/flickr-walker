//
//  ImageLoaderViewModel.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

enum ImageLoadState {
    case loading, empty, success(uiImage: UIImage), error(error: Error)
}

class ImageLoaderViewModel: ObservableObject {
    @Published var imageLoadState: ImageLoadState = .loading
    
    private let imageRequest: ImageRequest
    private let flickrAPIManager: FlickrAPIManagerProtocol
    private var imageCache: ImageCacheProtocol?
    private var isLoading = false

    init(
        imageRequest: ImageRequest, flickrAPIManager: FlickrAPIManagerProtocol = FlickrAPIManager(),
        imageCache: ImageCacheProtocol? = Environment(\.imageCache).wrappedValue
    ) {
        self.imageRequest = imageRequest
        self.flickrAPIManager = flickrAPIManager
        self.imageCache = imageCache
    }
    
    func loadImage() {
        guard isLoading == false else {
            return
        }
        
        // I image is cached, return from cache, else make a request
        if let imageData = imageCache?[imageRequest.path] as Data?, let uiImage = UIImage(data: imageData) {
            self.imageLoadState = .success(uiImage: uiImage)
            return
        }
        
        isLoading = true
        flickrAPIManager.image(imageRequest) { [weak self] result in
            switch result {
            case .success(let response):
                if let uiImage = UIImage(data: response) {
                    self?.imageLoadState = .success(uiImage: uiImage)
                } else {
                    self?.imageLoadState = .empty
                }
                self?.cache(imageData: response)
            case .failure(let error):
                print(error.localizedDescription)
                self?.imageLoadState = .error(error: error)
            }
            self?.isLoading = false
        }
    }
    
    private func cache(imageData: Data) {
        imageCache?[imageRequest.path] = imageData
    }
}
