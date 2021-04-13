//
//  BookDetailView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 19/03/2021.
//

import SwiftUI

struct BookDetailView: View {
    let book: BookViewModel
    @State private var detailTab: BookDetailTab = .description
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                
                VStack(spacing: 20) {
                    BookDetailMainInfo(book: book)
                    BookDetailExtraInfo(book: book)
                }
                .embedInSection()
                
                BookDetailPriceSection(book: book)
                
                VStack(alignment: .leading, spacing: 20) {
                    UnderlinePicker(BookDetailTab.allCases, selection: $detailTab) {
                        Text($0.rawValue).font(.headline)
                    }
                    
                    Group {
                        if detailTab == .description {
                            BookDetailDescription(book.description)
                        } else if detailTab == .info {
                            VStack(alignment: .leading, spacing: 10) {
                                if book.publisher != "" {
                                    Text("Publisher: \(book.publisher)")
                                }
                                
                                Text("Published date: \(book.publishedDate)")
                                
                                if book.sizeBytes != "0" {
                                    Text("Size: \(book.sizeBytes) bytes")
                                }
                            }
                        }
                    }
                    .font(.subheadline)
                    .opacity(0.8)
                }
                .embedInSection()
                .padding(.bottom)
            }
        }
        .padding(10)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.systemGroupedBackground.ignoresSafeArea())
    }

    private enum BookDetailTab: String, Identifiable, CaseIterable {
        case description = "Description"
        case info = "Info"
        
        var id: String { rawValue }
    }
}

// MARK: -- Preview

struct BookDetailView2_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[0]!
        
        BookDetailView(book: book)
//            .preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Google Books")
                    }
                }
            }
        .embedInNavigationView()
    }
}


