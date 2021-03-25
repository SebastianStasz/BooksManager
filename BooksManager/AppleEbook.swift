//
//  AppleEbook.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

struct AppleEbook: BookType {
    let trackId: Int
    let artworkUrl60: String
    let artworkUrl100: String
    let trackName: String
    let description: String
    let artistName: String
    let kind: String
    let genres: [String]
    let averageUserRating: Double?
    let userRatingCount: Int?
    let currency: String
    let price: Double?
    let releaseDate: String
    let trackViewUrl: String
    let fileSizeBytes: Int?
    let artistIds: [Int]
    let genreIds: [String]
}
