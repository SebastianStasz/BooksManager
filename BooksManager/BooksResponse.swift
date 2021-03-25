//
//  BooksResponse.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

protocol BooksResponse: Decodable {
    associatedtype book: BookType
    
    var results: [book]? { get }
}

protocol BookType: Decodable {}

// MARK: -- Google Books

struct GoogleBooksResponse: BooksResponse {
    let kind: String
    let totalItems: Int
    let results: [GoogleBook]?
    
    enum CodingKeys: String, CodingKey {
        case kind, totalItems
        case results = "items"
    }
}

// MARK: -- Apple Books

struct AppleBooksResponse<T: BookType>: BooksResponse {
    let resultCount: Int
    let results: [T]?
}
