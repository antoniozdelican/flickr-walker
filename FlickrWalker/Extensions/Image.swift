//
//  View.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 02.12.21.
//

import SwiftUI

extension Image {
    var flickrImage: some View {
        self
            .resizable()
            .scaledToFit()
            .frame(height: 80, alignment: .center)
            .foregroundColor(.gray)
    }
}
