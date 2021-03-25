//
//  AppleBooksAPI.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

struct AppleBooksAPI<T: BookType>: BooksAPI {
    typealias Response = AppleBooksResponse<T>
    
    private(set) var startComponents: URLComponents
    var keyForOffset: String
    
    init() {
        keyForOffset = "offset"
        startComponents = URLComponents()
        startComponents.scheme = "https"
        startComponents.host = "itunes.apple.com"
        startComponents.path = "/search"
        startComponents.queryItems = []
        startComponents.queryItems?.append(limit)
    }
    
    func getBasicParameters(for form: SearchBooksForm) -> [URLQueryItem] {
        var result: [URLQueryItem] = []
        result.append(URLQueryItem(name: "term", value: form.searchTerm))
        if form.mediaType == .ebook {
            result.append(contentsOf: [mediaEbook, entityEbook])
        } else if form.mediaType == .audiobook {
            result.append(contentsOf: [mediaAudiobook, entityAudibook])
        }
        
        if form.country == .poland { result.append(countryPL) }
        else if form.country == .unitedStates { result.append(countryUS) }
        
        if !form.title.isEmpty {
            result.append(URLQueryItem(name: "titleTerm", value: form.title))
        }
        if !form.author.isEmpty {
            result.append(URLQueryItem(name: "authorTerm", value: form.author))
        }
        return result
    }
    
    func getAdditionalParameters(for form: SearchBooksForm) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        if form.additional.apple.searchByGenre {
            queryItems.append(searchByGenre)
        }
        return queryItems
    }
    
    private let limit = URLQueryItem(name: "limit", value: "20")
    private let searchTerm = URLQueryItem(name: "term", value: "")
    private let countryPL = URLQueryItem(name: "country", value: "pl")
    private let countryUS = URLQueryItem(name: "country", value: "us")
    private let titleTerm = URLQueryItem(name: "titleTerm", value: "")
    private let authorTerm = URLQueryItem(name: "authorTerm", value: "")
    
    private let mediaEbook = URLQueryItem(name: "media", value: "ebook")
    private let entityEbook = URLQueryItem(name: "entity", value: "ebook")
    private let mediaAudiobook = URLQueryItem(name: "media", value: "audiobook")
    private let entityAudibook = URLQueryItem(name: "entity", value: "audiobook")
    private let searchByGenre = URLQueryItem(name: "attribute", value: "genreTerm")
}
