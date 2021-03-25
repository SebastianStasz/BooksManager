//
//  BookListView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 11/03/2021.
//

import SwiftUI
import Combine

struct BookListView: View {
    @StateObject private var keyboard = KeyboardManager()
    @StateObject private var searchBooks = SearchBooks()
    @State private var scrollProxy: ScrollViewProxy?
    @State private var isFormShown = false
    
    var body: some View {
        ZStack {
            Color.secondarySystemBackground.edgesIgnoringSafeArea(.bottom)
            
            VStack(spacing: 0) {
                if isListEmpty { emptyList } else { listOfBooks }

                Spacer()
                
                bottomSearchArea
            }
            .padding(.horizontal, mainPadding)
        }
        .navigationTitle(title).embedInNavigationView(.inline)
        .sheet(isPresented: $isFormShown) {
            BookSearchFormView(form: searchBooks.form, isPresented: $isFormShown)
                .ignoresSafeArea(edges: .bottom)
        }
        .onChange(of: isFormShown) {
            if $0 == false { searchBooks.notifyAboutClosingForm() }
        }
    }
    
    let mainPadding: CGFloat = 10
    
    // MARK: -- View Components
    
    private var emptyList: some View {
        Group {
            if searchBooks.isLoading { ProgressView() }
            else {
                VStack(spacing: mainPadding) {
                    emptyListIcon.changeSize(maxHeight: 50)
                    
                    Text(emptyListText).font(.title2)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                }
                .opacity(0.6)
            }
        }.frame(maxHeight: .infinity)
    }
    
    private var listOfBooks: some View {
        ScrollView { ScrollViewReader { proxy in
            LazyVStack(spacing: mainPadding) {
                ForEach(searchBooks.books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRowView(book: book).id(book.id)
                    }
                    .onAppear() { searchBooks.getMoreResults(if: book.id) }
                }
                .buttonStyle(PlainButtonStyle())
                
                if searchBooks.nextSearchWhenId == nil { noMoreResults }
            }
            .padding(.top, mainPadding)
            .onAppear() { scrollProxy = proxy }
        }}
    }
    
    private var bottomSearchArea: some View {
        HStack {
            if !isListEmpty { scrollToTopButton }
            
            TextField("Search", text: $searchBooks.form.searchTerm)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .overlay(resetButton, alignment: .trailing)
            
            if keyboard.isShown { hideKeyboardButton }
            else { toggleSearchFormButton }
        }
        .padding(.bottom, mainPadding)
    }
    
    private var noMoreResults: some View {
        HStack {
            Text("That's everything we found")
            Image(systemName: "text.magnifyingglass").font(.title3)
        }.padding().opacity(0.6)
    }
    
    // MARK: -- Buttons
    
    private var hideKeyboardButton: some View {
        Button { hideKeyboard() } label: {
            Image(systemName: "keyboard.chevron.compact.down").font(.title)
        }
    }
    
    private var toggleSearchFormButton: some View {
        Button { showForm() } label: {
            Image(systemName: "slider.horizontal.3").font(.title)
                .padding(.horizontal, 5).contentShape(Rectangle())
        }
    }
    
    private var scrollToTopButton: some View {
        Button { scrollToTop() } label: {
            Image(systemName: "arrow.up.circle")
                .padding(.horizontal, 5).contentShape(Rectangle())
        }.buttonStyle(PlainButtonStyle()).opacity(0.3)
    }
    
    private var resetButton: some View {
        Button { resetSearch() } label: { Image(systemName: "xmark.circle")
            .padding(.horizontal, 10).contentShape(Rectangle())
            .opacity(isResetButtonPresented ? 0.3 : 0)
        }.buttonStyle(PlainButtonStyle())
    }
    
    // MARK: -- Helpers
    
    private var title: String {
        if isSourceGoogleBook { return "Google Books" }
        else { return isSourceAppleEbook ? "Apple Ebooks" : "Apple Audiobook" }
    }
    
    private var emptyListText: String {
        if let error = searchBooks.error { return error.message }
        else {
            return isResponseEmpty ? "Nothing was found" : "Let's search for some books"
        }
    }
    
    private var emptyListIcon: Image {
        if let error = searchBooks.error { return error.icon }
        else {
            return Image(systemName: isResponseEmpty ? "bookmark.slash" : "books.vertical")
        }
    }
    
    private var isListEmpty: Bool {
        searchBooks.books.isEmpty
    }
    
    private var isResponseEmpty: Bool {
        searchBooks.responseIsEmpty
    }
    
    private var isSourceGoogleBook: Bool {
        searchBooks.form.searchSource == .google
    }
    
    private var isSourceAppleEbook: Bool {
        searchBooks.form.additional.apple.mediaType == .ebook
    }
    
    private var isResetButtonPresented: Bool {
        !searchBooks.form.searchTerm.isEmpty && !searchBooks.books.isEmpty
    }
    
    // MARK: -- Interactions
    
    private func resetSearch() {
        searchBooks.resetSearch()
    }
    
    private func showForm() {
        withAnimation { isFormShown.toggle() }
    }
    
    private func scrollToTop() {
        withAnimation {
            scrollProxy?.scrollTo(searchBooks.books.first?.id ?? "")
        }
    }
}

// MARK: -- Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack { BookListView() }
            
//            VStack { BookListView() }
//                .previewDevice("iPhone SE (2nd generation)")
        }
        .environment(\.locale, .init(identifier: "en"))
//        .preferredColorScheme(.dark)
    }
}
