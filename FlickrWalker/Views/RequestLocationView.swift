//
//  RequestLocationView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.wave")
                .flickrImage
            Text("Hi! We need your permission to track your walk.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Button(action: contentViewModel.requestPermission) {
                Label("Allow tracking", systemImage: "location")
                    .frame(width: 200, height: 50)
            }
            .flickrButton
        }
        .padding()
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView()
    }
}
