//
//  ImageView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

struct ImageView: View {
    @StateObject private var imageLoaderViewModel: ImageLoaderViewModel
    
    init(id: String, server: String, secret: String) {
        let imageRequest = ImageRequest(id: id, server: server, secret: secret)
        _imageLoaderViewModel = StateObject(wrappedValue: ImageLoaderViewModel(imageRequest: imageRequest))
    }
    
    var body: some View {
        content
            .onAppear(perform: imageLoaderViewModel.loadImage)
    }
    
    private var content: some View {
        Group {
            switch imageLoaderViewModel.imageLoadState {
            case .success(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            case .empty:
                Image(systemName: "questionmark")
                    .flickrImage
                    .padding()
            case .error(let error):
                ImageErrorView(errorText: error.localizedDescription)
                    .padding()
            case .loading:
                ImagePlaceholderView()
            }
        }
    }
    
    struct ImageErrorView: View {
        var errorText: String
        var body: some View {
            VStack(spacing: 20) {
                Image(systemName: "xmark.circle")
                    .flickrImage
                Text(errorText)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    struct ImagePlaceholderView: View {
        var body: some View {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.flickrLightGray)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}
