//
//  GoogleBooksAPI.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

struct GoogleBooksAPI: BooksAPI {
    typealias Response = GoogleBooksResponse
    private(set) var startComponents: URLComponents
    let keyForOffset: String
    
    init() {
        keyForOffset = "startIndex"
        startComponents = URLComponents()
        startComponents.scheme = "https"
        startComponents.host = "www.googleapis.com"
        startComponents.path = "/books/v1/volumes"
        startComponents.queryItems = []
        startComponents.queryItems?.append(contentsOf: [key, maxResults])
    }
    
    func getBasicParameters(for form: SearchBooksForm) -> [URLQueryItem] {
        var search = form.searchTerm
        if !form.title.isEmpty { search += "+intitle:\(form.title.spacesToPlusSign())" }
        if !form.author.isEmpty { search += "+inauthor:\(form.author.spacesToPlusSign())" }
        return [URLQueryItem(name: "q", value: search)]
    }
    
    func getAdditionalParameters(for form: SearchBooksForm) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        if form.printType == .books {
            queryItems.append(printTypeBooks)
        }
        else if form.printType == .magazines {
            queryItems.append(printTypeMagazines)
        }
        if form.filtering == .freeEbooks {
            queryItems.append(freeEbooks)
        }
        else if form.filtering == .paidEbooks {
            queryItems.append(paidEbooks)
        }
        if form.epubOnly {
            queryItems.append(epubAvailable)
        }
        if form.sortByNewest {
            queryItems.append(sortByNewest)
        }
        return queryItems
    }

    // MARK: Parameters
    
    let printTypeBooks = URLQueryItem(name: "printType", value: "books")
    let printTypeMagazines = URLQueryItem(name: "printType", value: "magazines")
    let freeEbooks = URLQueryItem(name: "filter", value: "free-ebooks")
    let paidEbooks = URLQueryItem(name: "filter", value: "paid-ebooks")
    let epubAvailable = URLQueryItem(name: "download", value: "epub")
    let sortByNewest = URLQueryItem(name: "sort", value: "newest")
    let maxResults = URLQueryItem(name: "maxResults", value: "20")
    let key = URLQueryItem(name: "key", value: "AIzaSyBmI0T5_eT2IQgRW7UfBZOXnMH_fKOYECU")
}
