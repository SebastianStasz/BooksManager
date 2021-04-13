//
//  TruncableText.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 27/03/2021.
//

import SwiftUI

struct TruncableText: View {
    private let text: String
    private let lineLimit: Int?
    
    private let isTruncatedUpdate: (_ isTruncated: Bool) -> Void
    @State private var intrinsicSize: CGSize = .zero
    @State private var actualSize: CGSize = .zero
    
    var body: some View {
        Text(text)
            .lineLimit(lineLimit)
            .readSize { actualSize = $0 ; updateIsTruncated() }
            .background(intrinsicSizeChecker)
    }
    
    private var intrinsicSizeChecker: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .hidden()
            .readSize { intrinsicSize = $0 ; updateIsTruncated() }
    }
    
    private func updateIsTruncated() {
        isTruncatedUpdate(actualSize != intrinsicSize)
    }
}

extension TruncableText {
    ///
    init(_ text: String, lineLimit: Int? = nil, isTruncatedUpdate: @escaping (_ isTruncated: Bool) -> Void) {
        self.text = text
        self.lineLimit = lineLimit
        self.isTruncatedUpdate = isTruncatedUpdate
    }
}
