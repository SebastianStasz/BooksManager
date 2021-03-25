//
//  ImageExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 15/03/2021.
//

import SwiftUI

// MARK: -- Change Size of Image

extension Image {
    func changeSize(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil, contentMode: ContentMode = .fit) -> some View {
        self.resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
}
