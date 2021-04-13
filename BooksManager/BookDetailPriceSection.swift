//
//  BookDetailPriceSection.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 01/04/2021.
//

import SwiftUI

struct BookDetailPriceSection: View {
    let isFree: Bool
    let price: String?
    let previewLink: URL?
    
    var body: some View {
        HStack {
            if isFree {
                Text("free")
                    .embedInBorder(color: .green)
            }
            else if let price = price {
                Text(price)
                    .font(.headline)
            }
            else {
                Text("Unknown Price")
                    .embedInBorder(color: .orange)
            }
            
            Spacer()
            
            Link(destination: previewLink!, label: {
                Text("See preview")
            })
            .buttonStyle(MainButtonStyle())

        }
        .font(.subheadline)
        .frame(height: 30)
        .embedInSection()
    }
}

// MARK: -- Initializer

extension BookDetailPriceSection {
    init(book: BookViewModel) {
        isFree = book.isFree
        price = book.price
        previewLink = book.previewLink
    }
}

// MARK: -- Preview

struct BookDetailPriceSection_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[1]!
        BookDetailPriceSection(book: book)
    }
}
