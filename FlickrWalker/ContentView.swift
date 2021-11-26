//
//  ContentView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 26.11.21.
//

import SwiftUI

enum AppState {
    case initial, locationDisabled, runningNoImages, runningWithImages, stopped
}

// MARK: - Extensions

extension Color {
    static let themeGreen = Color(.sRGB, red: 22 / 255, green: 134 / 255, blue: 79 / 255, opacity: 1.0)
}

struct ContentView: View {
    @State private var appState: AppState = .initial
    
    var body: some View {
        NavigationView {
            Group {
                switch appState {
                case .initial:
                    initalView
                case .locationDisabled:
                    locationDisabledView
                case .runningNoImages:
                    runningNoImagesView
                case .runningWithImages:
                    runningWithImagesView
                case .stopped:
                    stoppedView
                }
            }
            .navigationTitle("FlickrWalker")
        }
    }
    
    // MARK: - Views

    var initalView: some View {
        Button(action: startButtonTapped) {
            Text("Start walking")
                .frame(width: 200, height: 50)
                .background(Color.themeGreen)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    var locationDisabledView: some View {
        VStack(spacing: 10) {
            Text("Your location is disabled")
                .font(.subheadline)
                .foregroundColor(.gray)
            Button(action: settingsButtonTapped) {
                Text("Enable in settings")
                    .frame(width: 200, height: 50)
                    .background(Color.themeGreen)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }

    var runningNoImagesView: some View {
        let images = ["1", "2", "3"]
        return List(images, id: \.self) { image in
            Text(image)
        }
    }

    var runningWithImagesView: some View {
        let images = ["1", "2", "3"]
        return List(images, id: \.self) { image in
            Text(image)
        }
    }

    var stoppedView: some View {
        Text("stoppedView")
    }

    // MARK: - Buttons

    private func startButtonTapped() {
        appState = .runningNoImages
        /// start tracking
    }
    
    private func settingsButtonTapped() {
        /// go to settings
        /// track if it was enabled after returning
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
