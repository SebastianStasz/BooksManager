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
    
    private func getURLFromString(_ urlString: String) -> Result<URL, URLError> {
        guard let url = URL(string: urlString) else {
            let error = URLError(.badURL, userInfo: [NSURLErrorKey: urlString])
            return Result.failure(error)
        }
        return Result.success(url)
    }
    
    func fetchFromLink<T: Decodable>(_ stringURL: String) -> AnyPublisher<T, APIServiceError> {
        guard let url = URL(string: stringURL) else {
            let badURL = URLError(.badURL, userInfo: [NSURLErrorKey: stringURL])
            let error = APIServiceError.invalidURL(message: "Invalid URL", error: badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return fetchAPI(url: url)
    }
    
    func fetchFromLinkURL<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIServiceError> {
        return fetchAPI(url: url)
    }
    
    func fetchFromFile<T: Decodable>(_ name: String, withExtension fileExtension: String) -> AnyPublisher<T, APIServiceError> {
        guard let fileURL = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            let badURL = URLError(.badURL, userInfo: [NSURLErrorKey: name + "." + fileExtension])
            let error = APIServiceError.invalidURL(message: "File not found", error: badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return fetchAPI(url: fileURL)
    }

    
    private func fetchAPI<T: Decodable>(url: URL) -> AnyPublisher<T, APIServiceError> {
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { data, response in
//                let response = response as? HTTPURLResponse
//                let statusCode = response?.statusCode
//                guard statusCode == 200 else {
//                    throw APIServiceError.networkError(message: "Invalid response \(statusCode ?? 0)")
//                }
//                return data
//            }
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

// MARK: -- Fetching Image

enum ImageLoaderError: Error {
    case invalidData
    case other(error: Error)
    case urlError(error: URLError)
}

extension APIService {
    
    func fetchImage(from urlString: String) -> AnyPublisher<UIImage, ImageLoaderError> {
        let url = getURLFromString(urlString)
        switch url {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { [unowned self] in try transformToUIImage($0.data) }
                .mapError { err in
                    if let err = err as? URLError {
                        return ImageLoaderError.urlError(error: err)
                    } else if let _ = err as? ImageLoaderError {
                        return ImageLoaderError.invalidData
                    } else {
                        return ImageLoaderError.other(error: err)
                    }
                }.eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: ImageLoaderError.urlError(error: error)).eraseToAnyPublisher()
        }
    }
    
    private func transformToUIImage(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ImageLoaderError.invalidData
        }
        return image
    }
}
