//
//  AppleAudiobook.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

struct AppleAudibook: BookType {
    let collectionId: Int
    let artistId: Int
    let country: String
    let currency: String
    let copyright: String?
    let artistName: String
    let description: String
    let releaseDate: String
    let wrapperType: String
    let artworkUrl60: String
    let artworkUrl100: String
    let artistViewUrl: String
    let collectionName: String
    let collectionPrice: Double
    let primaryGenreName: String
}

struct AppleAudiobooksResponse: BooksResponse {
    let resultCount: Int
    let results: [AppleAudibook]?
}
