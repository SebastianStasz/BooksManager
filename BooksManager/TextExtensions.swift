//
//  TextExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 15/03/2021.
//

import SwiftUI

// MARK: -- Embed Text in Border

extension Text {
    func embedInBorder(verticalPadding: CGFloat = 1, horizontalPadding: CGFloat = 6, borderWidth: CGFloat = 1, radius: CGFloat = 30, color: Color = .blue) -> some View {
        self
            .foregroundColor(color)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .overlay(RoundedRectangle(cornerRadius: radius)
                        .stroke(color, lineWidth: borderWidth))
    }
}
