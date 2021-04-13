//
//  BookDetailSection.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 01/04/2021.
//

import SwiftUI

struct BookDetailSection: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.secondarySystemGroupedBackground)
            .cornerRadius(5)
    }
}

extension View {
    func embedInSection() -> some View {
        modifier(BookDetailSection())
    }
}
