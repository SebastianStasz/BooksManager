//
//  BooksAPI.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

protocol BooksAPI {
    associatedtype Response: BooksResponse
    var startComponents: URLComponents { get }
    var keyForOffset: String { get }
    
    func getBasicParameters(for form: SearchBooksForm) -> [URLQueryItem]
    func getAdditionalParameters(for form: SearchBooksForm) -> [URLQueryItem]
    func getOffsetParameter(for index: Int) -> URLQueryItem
}

extension BooksAPI {
    func getOffsetParameter(for index: Int) -> URLQueryItem {
        let queryItem = URLQueryItem(name: keyForOffset, value: String(index))
        return queryItem
    }
}
