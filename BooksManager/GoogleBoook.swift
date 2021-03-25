//
//  GoogleBoook.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 11/03/2021.
//

import Foundation

struct GoogleBook: BookType {
    let id: String
    let etag: String
    let volumeInfo: VolumeInfo
    let accessInfo: AccessInfo
    let saleInfo: SaleInfo
    
    struct VolumeInfo: Decodable {
        let title: String?
        let subtitle: String?
        let authors: [String]?
        let publisher: String?
        let printType: String?
        let publishedDate: String?
        let description: String?
        let pageCount: Int?
        let categories: [String]?
        let averageRating: Double?
        let ratingsCount: Int?
        let language: String
        let imageLinks: ImageLinks?
        let previewLink: String?
        let infoLink: String?
        
        struct ImageLinks: Decodable {
            let smallThumbnail: String
            let thumbnail: String
        }
    }
    
    struct AccessInfo: Decodable {
        let viewability: String?
        let epub: Epub
        let pdf: Pdf
        
        struct Epub: Decodable {
            let isAvailable: Bool
            let downloadLink: String?
        }

        struct Pdf: Decodable {
            let isAvailable: Bool
            let downloadLink: String?
        }
    }
    
    struct SaleInfo: Decodable {
        let retailPrice: RetailPrice?
        let saleability: String?
        
        struct RetailPrice: Decodable {
            let amount: Double
            let currencyCode: String
        }
    }
}

