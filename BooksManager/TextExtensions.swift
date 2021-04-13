//
//  TextExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 15/03/2021.
//

import SwiftUI

// MARK: -- Embed Text in Border

extension Text {
    func embedInBorder(VPadding: CGFloat = 1, HPadding: CGFloat = 6, borderWidth: CGFloat = 1, radius: CGFloat = 30, color: Color = .blue) -> some View {
        self
            .foregroundColor(color)
            .padding(.vertical, VPadding)
            .padding(.horizontal, HPadding)
            .overlay(RoundedRectangle(cornerRadius: radius)
                        .stroke(color, lineWidth: borderWidth))
    }
}
