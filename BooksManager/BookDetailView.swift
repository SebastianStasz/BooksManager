//
//  BookDetailView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 19/03/2021.
//

import SwiftUI

struct BookDetailView: View {
    let book: BookViewModel
    
    var body: some View {
        ZStack {
//            ZStack(alignment: .bottom) {
//                Color("mainOrange")
////                Color.systemBackground
////                .cornerRadius(30).frame(height: 530)
//            }
//            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    bookCover
                        
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(book.title).font(.title2).bold()
                            Text(book.authors).font(.subheadline).opacity(0.5)
                        }
                        
                        HStack {
                            RatingStarsView(rating: book.averageRating, showRating: true)
                                
                            Spacer()
                            
                            Text("\(book.ratingCount) reviews").opacity(0.6)
                        }
                        .font(.callout)
                        
                        Divider()
                        
                        Text(book.description).opacity(0.7).lineSpacing(7)
                        
                        Text("Fiction").font(.caption)
                            .padding(.horizontal).padding(.vertical, 2)
                            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.gray))
                    }
                    .background(Color.systemBackground.ignoresSafeArea())
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                Spacer()
            }
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
        .changeSize(maxWidth: 190, maxHeight: 270)
    }
}

// MARK: -- Preview

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let book = SearchBooks.booksSample[0]!
        BookDetailView(book: book)
//            .preferredColorScheme(.dark)
            .toolbar { ToolbarItem(placement: .navigationBarLeading) {
                Text("Google Books")
            } }
            .embedInNavigationView(.inline)
    }
}


