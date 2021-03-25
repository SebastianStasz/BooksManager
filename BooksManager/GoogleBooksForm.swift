//
//  GoogleBooksForm.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation
import SwiftUI

struct GoogleBooksForm: Equatable {
    var epubOnly = false
    var sortByNewest = false
    var printType: PrintType = .books
    var filtering: Filtering = .none
    
    enum PrintType: LocalizedStringKey, CaseIterable {
        case all = "All"
        case books = "Books"
        case magazines = "Magazines"
    }

    enum Filtering: LocalizedStringKey, CaseIterable {
        case freeEbooks = "Free ebooks"
        case paidEbooks = "Paid ebooks"
        case none = "None"
    }
}
