//
//  AppleBooksForm.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation
import SwiftUI

struct AppleBooksForm: Equatable {
    var searchByGenre = false
    var country: Country = .poland
    var mediaType: MediaType = .ebook
    
    enum MediaType: LocalizedStringKey, CaseIterable {
        case audiobook = "Audiobook"
        case ebook = "Ebook"
    }
    
    enum Country: LocalizedStringKey, CaseIterable {
        case unitedStates = "United States"
        case poland = "Poland"
    }
}
