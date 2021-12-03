//
//  Button.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

extension Button {
    var flickrButton: some View {
        self
            .foregroundColor(.white)
            .background(Color.flickrGreen)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
