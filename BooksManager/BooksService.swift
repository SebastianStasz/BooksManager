//
//  GoogleBooksService.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import Foundation
import Combine

struct BooksService<O: BooksAPI> {
    private let apiService = APIService.shared
    private var apiCallQuery: URLComponents?
    private var apiCallURL: URL?
    private let apiComponents: O
    
    init(_ service: O) {
        self.apiComponents = service
    }
    
    mutating func fetchBooks(form: SearchBooksForm, startAt index: Int) -> AnyPublisher<[BookViewModel], APIServiceError> {
        if index == 0 {
            setAPICallQuery(for: form)
        }
        let url = getAPICallURL(startAt: index)
        
        return performBooksCall(url)
            .map { $0.results ?? [] }
            .compactMap { $0.map { BookViewModel(bookType: $0) } as? [BookViewModel] }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func performBooksCall(_ apiCall: URL) -> AnyPublisher<O.Response, APIServiceError> {
        apiService.fetchFromLinkURL(apiCall)
            .eraseToAnyPublisher()
    }
    
    private mutating func setAPICallQuery(for form: SearchBooksForm) {
        var components = apiComponents.startComponents
        let search = apiComponents.getBasicParameters(for: form)
        let additional = apiComponents.getAdditionalParameters(for: form)
        components.queryItems?.append(contentsOf: search)
        components.queryItems?.append(contentsOf: additional)
        apiCallQuery = components
    }
    
    private func getAPICallURL(startAt index: Int) -> URL {
        let startIndex = apiComponents.getOffsetParameter(for: index)
        var apiCallURL = apiCallQuery
        apiCallURL?.queryItems?.append(startIndex)
        return apiCallURL!.url!
    }
}


