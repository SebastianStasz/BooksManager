//
//  APIService.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 11/03/2021.
//

import Combine
import Foundation
import SwiftUI

class APIService {
    static let shared = APIService()
    private init(){}
    
    private let decoder = JSONDecoder()
    private var cancellableSet = Set<AnyCancellable>()
   
    func fetchFromLinkURL<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIServiceError> {
        return fetchAPI(url: url)
    }
    
    private func fetchAPI<T: Decodable>(url: URL) -> AnyPublisher<T, APIServiceError> {
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return APIServiceError.decodingError(message: "Something went wrong.", error: error)
                default:
                    return APIServiceError.otherError(message: error.localizedDescription, error: error)
                }
            }
            .eraseToAnyPublisher()
    }
}
