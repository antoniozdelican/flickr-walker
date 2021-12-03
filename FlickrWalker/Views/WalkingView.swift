//
//  WalkingView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

struct WalkingView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        Group {
            switch contentViewModel.walkingState {
            case .start:
                startView
            case .running:
                runningView
            case .stopped:
                stoppedView
            }
        }
    }
    
    // MARK: - Start
    
    var startView: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.walk")
                .flickrImage
            Text("You are all set to track your walk. Click start!")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Button(action: {
                contentViewModel.walkingState = .running
                contentViewModel.startUpdatingLocation()
            }) {
                Label("Start walking", systemImage: "play")
                    .frame(width: 200, height: 50)
            }
            .flickrButton
        }
        .padding()
    }
    
    // MARK: - Running
    
    var runningView: some View {
        Group {
            if contentViewModel.photos.isEmpty {
                runningEmptyView
            } else {
                runningImagesView
            }
        }
    }
    
    var runningEmptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.walk")
                .flickrImage
            Text("Tracking your walk...")
                .font(.headline)
            Text("Every 100m you will automatically get a photo of your trail. Enjoy the nature!")
                .foregroundColor(.gray)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    var runningImagesView: some View {
        ScrollViewReader { value in
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(contentViewModel.photos) { photo in
                        ImageView(id: photo.id, server: photo.server ?? "", secret: photo.secret ?? "")
                            .id(photo.id)
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                DispatchQueue.main.async {
                    value.scrollTo(contentViewModel.photos.first?.id, anchor: .top)
                }
            }
        }
    }
    
    // MARK: - Stopped
    
    var stoppedView: some View {
        Group {
            if contentViewModel.photos.isEmpty {
                startView
            } else {
                runningImagesView
            }
        }
    }
}

struct WalkingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingView()
    }
}
