//
//  ErrorLocationView.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

struct ErrorLocationView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var errorText: String
    var isRestricted: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "xmark.circle")
                .flickrImage
            Text(errorText)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Group {
                if !isRestricted {
                    Button(action: contentViewModel.openSettingsButtonTapped) {
                        Label("Open settings", systemImage: "gearshape")
                            .frame(width: 200, height: 50)
                    }
                    .flickrButton
                } else {
                    EmptyView()
                }
            }
        }
        .padding()
    }
}

struct ErrorLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorLocationView(errorText: "")
    }
}
