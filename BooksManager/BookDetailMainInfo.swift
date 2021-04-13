//
//  BookDetailMainInfo.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 26/03/2021.
//

import SwiftUI

import WebKit
import SwiftUI

struct BookDetailMainInfo: View {
    let book: BookViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            bookCover

            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.title2)
                    .padding(.bottom, 1)
                    .lineLimit(3)
                
                Text(book.authors)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                if book.kind != "audiobook"{
                    RatingStarsView(rating: book.averageRating, showRating: true)
                        .font(.callout)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var bookCover: some View {
        AsyncImage(url: book.coverLinkBig) {
            AsyncImage(url: book.cover) {
                Image(systemName: "text.book.closed")
                    .resizable().padding().foregroundColor(.secondary)
            }
        }
        .cornerRadius(10)
        .changeSize(maxWidth: 95, maxHeight: 135)
    }
}

// MARK: -- Preview

struct BookDetailMainInfo_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[0]!
        BookDetailMainInfo(book: book)
            .frame(maxHeight: 110)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
