//
//  APIServiceError.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 19/03/2021.
//

import Foundation
import SwiftUI

enum APIServiceError: Error {
    case invalidURL(message: String, error: Error)
    case networkError(message: String, error: Error)
    case decodingError(message: String, error: Error)
    case otherError(message: String, error: Error)
    
    var message: String {
        switch self {
        case .invalidURL(message: let message, error: _):
            return message
        case .networkError(message: let message, error: _):
            return message
        case .decodingError(message: let message, error: _):
            return message
        case .otherError(message: let message, error: _):
            return message
        }
    }

    var icon: Image {
        switch self {
        case .invalidURL(message: _, error: _):
            return SFSymbol.someError.image
        case .networkError(message: _, error: _):
            return SFSymbol.noInternet.image
        case .decodingError(message: _, error: _):
            return SFSymbol.someError.image
        case .otherError(message: _, error: _):
            return SFSymbol.someError.image
        }
    }
    
    var getError: Error {
        switch self {
        case .invalidURL(message: _, error: let error):
            return error
        case .networkError(message: _, error: let error):
            return error
        case .decodingError(message: _, error: let error):
            return error
        case .otherError(message: _, error: let error):
            return error
        }
    }
}
