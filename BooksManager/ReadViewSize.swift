//
//  ReadViewSize.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 27/03/2021.
//

import SwiftUI

// MARK: -- Reading a view size

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(geometryReader)
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    private var geometryReader: some View {
        GeometryReader { geometryProxy in
            Color.clear
                .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
        }
    }
}

// MARK: -- Child to ancestors communication

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
