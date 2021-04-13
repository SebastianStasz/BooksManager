//
//  BookRowView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 13/03/2021.
//

import SwiftUI

struct BookRowView: View {
    private let book: BookViewModel

    var body: some View {
        HStack {
            AsyncImage(url: book.cover) {
                Image(systemName: "text.book.closed")
                    .resizable().padding(10).foregroundColor(.secondary)
            }
            .cornerRadius(5)
            .changeSize(maxWidth: 70, maxHeight: 100)

            VStack(alignment: .leading) {
                if book.source == "apple" && book.kind == "audiobook" {
                    Text(book.title).font(.callout).lineLimit(3)

                } else {
                    Text(book.title).font(.headline).lineLimit(1)
                    Spacer()
                    HStack {
                        RatingStarsView(rating: book.averageRating)
                        Text(book.ratingCount).fontWeight(.light)
                    }.font(.caption2)
                }
                
                Spacer()
                
                Group {
                    if book.source == "google" {
                        Text(book.subtitle)
                    } else {
                        Text(book.categories.joined(separator: ", "))
                    }
                }
                .lineLimit(2).font(.footnote).opacity(0.6)
                
                Spacer()
                
                HStack(spacing: 15) {
                    if book.isFree {
                        mark(text: "free", color: .green)
                    }
                    else if let price = book.price {
                        Text(price).bold().font(.footnote)
                    }
                    
                    HStack {
                        if book.isPdfAvailable {
                            mark(text: "pdf", color: .blue)
                        }
                        if book.isEpubAvailable {
                            mark(text: "epub", color: .orange)
                        }
                    }
                    Text(book.authors)
                        .fontWeight(.light).font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(3)
        }
        .padding(10)
        .frame(height: 120)
        .background(Color.secondarySystemGroupedBackground)
        .cornerRadius(5)
    }
    
    private func mark(text: String, color: Color) -> some View {
        Text(text).font(.caption2).embedInBorder(color: color)
    }
    
    // MARK: -- Initializer
    
    init(book: BookViewModel) {
        self.book = book
    }
}

// MARK: -- Preview

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[1]!
        BookRowView(book: book)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
