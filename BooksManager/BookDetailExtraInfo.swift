//
//  BookDetailExtraInfo.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 26/03/2021.
//

import SwiftUI

struct BookDetailExtraInfo: View {
    let book: BookViewModel
    
    var body: some View {
        HStack {
            if book.kind == "audiobook" {
                infoCell(title: "Track count", info: book.pageCount)
                Spacer()
                infoCell(title: "Country", info: book.language)
            } else {
                infoCell(title: "Reviews", info: book.ratingCount)
                Spacer()
                infoCell(title: "Pages", info: book.pageCount)
                Spacer()
                infoCell(title: "Language", info: book.language)
            }
            
            Spacer()
            
            infoCell(title: "Type", info: book.kind)
        }
    }
    
    private func infoCell(title: String, info: String) -> some View {
        VStack(spacing: 5) {
            Text(title).foregroundColor(.gray)
            Text(info)
        }
        .font(.callout)
    }
}

// MARK: -- Preview

struct BookDetailExtraInfo_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[0]!
        BookDetailExtraInfo(book: book)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
