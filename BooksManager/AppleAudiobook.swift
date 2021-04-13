//
//  AppleAudiobook.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

struct AppleAudiobook: BookType {
    let wrapperType: String
    let artistId: Int
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackCount: Int
    let copyright: String?
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
    let previewUrl: String
    let description: String
}

struct AppleAudiobooksResponse: BooksResponse {
    let resultCount: Int
    let results: [AppleAudiobook]?
}
