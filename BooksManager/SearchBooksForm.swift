//
//  SearchBooksForm.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import Combine
import Foundation
import SwiftUI

class SearchBooksForm: ObservableObject {
    @Published var additional = Additional()
    @Published var searchTerm = ""
    
    func reset() {
        title = ""
        author = ""
        additional = Additional()
    }
    
    struct Additional: Equatable {
        var searchSource: Source = .google
        var google = GoogleBooksForm()
        var apple = AppleBooksForm()
        var title = ""
        var author = ""
    }
    
    enum Source: String, Identifiable, CaseIterable {
        case google = "Google"
        case apple = "Apple"
        
        var id: String { rawValue }
    }
}

// MARK: -- Helpers

extension SearchBooksForm {
    
    var searchSource: Source {
        get { additional.searchSource }
        set { additional.searchSource = newValue }
    }
    
    var title: String {
        get { additional.title }
        set { additional.title = newValue }
    }
    var author: String {
        get { additional.author }
        set { additional.author = newValue }
    }
    
    // Google
    
    var epubOnly: Bool {
        get { additional.google.epubOnly }
        set { additional.google.epubOnly = newValue }
    }
    var sortByNewest: Bool {
        get { additional.google.sortByNewest }
        set { additional.google.sortByNewest = newValue }
    }
    var printType: GoogleBooksForm.PrintType {
        get { additional.google.printType }
        set { additional.google.printType = newValue }
    }
    var filtering: GoogleBooksForm.Filtering {
        get { additional.google.filtering }
        set { additional.google.filtering = newValue }
    }
    
    // Apple
    
    var searchByGenre: Bool {
        get { additional.apple.searchByGenre }
        set { additional.apple.searchByGenre = newValue }
    }
    
    var mediaType: AppleBooksForm.MediaType {
        get { additional.apple.mediaType }
        set { additional.apple.mediaType = newValue }
    }
    
    var country: AppleBooksForm.Country {
        get { additional.apple.country }
        set { additional.apple.country = newValue }
    }
}
