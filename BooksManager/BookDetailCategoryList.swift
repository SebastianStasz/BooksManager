//
//  BookDetailCategoryList.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 26/03/2021.
//

import SwiftUI

struct BookDetailCategoryList: View {
    let categories: [String]
    
    private let layout = [GridItem(.adaptive(minimum: 100, maximum: .infinity))]
    
    var body: some View {
        LazyVGrid(columns: layout, alignment: .leading) {
            ForEach(categories, id: \.self) {
                Text($0)
                    .font(.footnote)
                    .embedInBorder(VPadding: 3, HPadding: 10)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: -- Preview

struct BookDetailCategoryList_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[0]!
        BookDetailCategoryList(categories: book.categories)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
