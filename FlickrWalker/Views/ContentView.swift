//
//  ContentView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 26.11.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentViewModel: ContentViewModel
    
    @State private var showingAlert = false
    @State private var alertType: AlertType?
    
    init() {
        _contentViewModel = StateObject(wrappedValue: ContentViewModel())
    }
    
    var body: some View {
        NavigationView {
            Group {
                switch contentViewModel.authorizationStatus {
                case .notDetermined:
                    RequestLocationView()
                        .environmentObject(contentViewModel)
                case .restricted:
                    ErrorLocationView(errorText: "Location use is restricted.", isRestricted: true)
                case .denied:
                    ErrorLocationView(errorText: "The app does not have location permissions. Please enable them in settings.")
                        .environmentObject(contentViewModel)
                case .authorizedAlways, .authorizedWhenInUse:
                    WalkingView()
                        .environmentObject(contentViewModel)
                default:
                    Text("Unexpected status")
                }
            }
            .navigationBarTitle("FlickrWalker", displayMode: .inline)
            .toolbar {
                toolbarView
            }
            .alert(isPresented: $showingAlert) {
                alertView
            }
        }
    }
    
    var toolbarView: some View {
        Group {
            switch contentViewModel.walkingState {
            case .running:
                Button(action: {
                    alertType = .walkingStopped
                    showingAlert = true
                    contentViewModel.stopUpdatingLocation()
                }) {
                    Text("Stop")
                }
            case .stopped:
                Button(action: {
                    alertType = .walkingRestart
                    showingAlert = true
                }) {
                    Text("Start again")
                }
            default:
                EmptyView()
            }
        }
    }
    
    var alertView: Alert {
        switch alertType {
        case .walkingRestart:
            return
                Alert(
                    title: Text("Start again"),
                    message: Text("You can either continue tracking your photos or restart.\nNote: if you choose to restart, you will loose all your tracked photos."),
                    primaryButton: .default(Text("Continue"), action: {
                        contentViewModel.walkingState = .running
                        contentViewModel.startUpdatingLocation()
                    }),
                    secondaryButton: .destructive(Text("Restart"), action: {
                        contentViewModel.clearPhotos()
                        contentViewModel.walkingState = .running
                        contentViewModel.startUpdatingLocation()
                    })
                )
        case .walkingStopped,
             .none:
            return
                Alert(
                    title: Text("Walking stopped"),
                    message: Text("The app stopped tracking your walk."),
                    dismissButton: .default(Text("OK"), action: {
                        contentViewModel.walkingState = .stopped
                    })
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
