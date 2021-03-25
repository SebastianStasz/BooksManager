//
//  BookViewModel.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 13/03/2021.
//

import Foundation
import SwiftUI

struct BookViewModel: Identifiable {
    let id: String
    let kind: String
    let source: String
    let title: String
    let authors: String
    let language: String
    let subtitle: String
    let publisher: String
    let pageCount: String
    let description: String
    let publishedDate: String
    let categories: [String]
    let isPdfAvailable: Bool
    let isEpubAvailable: Bool
    let pdfDownloadLink: String?
    let epubDownloadLink: String?
    let cover: String?
    let coverLinkBig: String?
    let averageRating: Double
    let ratingCount: String
    
    let isFree: Bool
    
    private let priceAmount_: Double?
    private let priceCurrencyCode_: String?
    var price: String? {
        getRetailPrice(price: priceAmount_, code: priceCurrencyCode_)
    }
    
    private func getRetailPrice(price: Double?, code: String?) -> String? {
        guard let price = price, let code = code else { return nil }
        let formatter = Formatter.currency
        formatter.currencyCode = code
        return formatter.string(for: price)! // TODO: Temporary force unwrap
    }
}

// MARK: -- Initializers

extension BookViewModel {
    init?(bookType: BookType) {
        
        // MARK: Google Book
        
        if let book = bookType as? GoogleBook {
            if book.volumeInfo.title == nil { return nil }
            let pageCount_ = book.volumeInfo.pageCount
            let ratingCount_ = book.volumeInfo.ratingsCount
            priceAmount_ = book.saleInfo.retailPrice?.amount
            priceCurrencyCode_ = book.saleInfo.retailPrice?.currencyCode

            id = book.etag
            source = "google"
            kind = book.volumeInfo.printType?.lowercased() ?? ""
            title = book.volumeInfo.title!
            language = book.volumeInfo.language
            subtitle = book.volumeInfo.subtitle ?? ""
            categories = book.volumeInfo.categories ?? []
            description =  book.volumeInfo.description ?? ""
            publisher = book.volumeInfo.publisher ?? "Unknown"
            publishedDate = book.volumeInfo.publishedDate ?? ""
            pageCount = pageCount_ != nil ? String(pageCount_!) : "Unknown"
            ratingCount = ratingCount_ != nil ? String(ratingCount_!) : "0"
            authors = book.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown"
            averageRating = book.volumeInfo.averageRating ?? 0
            coverLinkBig = book.volumeInfo.imageLinks?.thumbnail ?? nil
            cover = book.volumeInfo.imageLinks?.smallThumbnail
            
            isFree = book.saleInfo.saleability == "FREE" ? true : false

            isEpubAvailable = book.accessInfo.epub.isAvailable
            epubDownloadLink = book.accessInfo.epub.downloadLink
            isPdfAvailable = book.accessInfo.pdf.isAvailable
            pdfDownloadLink = book.accessInfo.pdf.downloadLink
        }
        
        // MARK: Apple Book
        
        else if let book = bookType as? AppleEbook {
            let ratingCount_ = book.userRatingCount
            priceCurrencyCode_ = book.currency
            priceAmount_ = book.price

            id = UUID().uuidString // String(book.trackId)
            source = "apple"
            kind = book.kind
            title = book.trackName
            subtitle = ""
            language = ""
            publisher = ""
            pageCount = ""
            categories = book.genres
            authors = book.artistName
            description =  book.description
            publishedDate = book.releaseDate
            averageRating = book.averageUserRating ?? 0
            ratingCount = ratingCount_ != nil ? String(book.userRatingCount!) : "0"
            coverLinkBig = book.artworkUrl100
            cover = book.artworkUrl60

            isFree = book.price == 0 ? true : false
            
            isEpubAvailable = true
            epubDownloadLink = book.trackViewUrl
            isPdfAvailable = false
            pdfDownloadLink = nil
        }
        else {
            let book = bookType as! AppleAudibook // TODO: Temporary force unwrap
            let ratingCount_ = 0
            priceCurrencyCode_ = book.currency
            priceAmount_ = book.collectionPrice
            
            id = UUID().uuidString // String(book.collectionId)
            source = "apple"
            kind = book.wrapperType
            title = book.collectionName
            subtitle = ""
            language = ""
            publisher = book.copyright ?? ""
            pageCount = ""
            categories = [book.primaryGenreName]
            authors = book.artistName
            description =  book.description
            publishedDate = book.releaseDate
            averageRating = 0
            ratingCount = String(ratingCount_)
            coverLinkBig = book.artworkUrl100
            cover = book.artworkUrl60
            
            isFree = book.collectionPrice == 0 ? true : false
            
            isEpubAvailable = false
            epubDownloadLink = nil
            isPdfAvailable = false
            pdfDownloadLink = nil
        }
    }
}
