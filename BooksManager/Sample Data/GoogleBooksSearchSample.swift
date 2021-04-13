//
//  GoogleBooksSearchSample.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 15/03/2021.
//

import Foundation

// MARK: -- Google Books Search Sample Data

extension SearchBooks {
    static let booksSample = booksExample.map { BookViewModel(bookType: $0) }
    static let booksExample = [
        GoogleBook(id: "hnT3DwAAQBAJ",
             etag: "yuCAfqylCuQ",
             volumeInfo: GoogleBook.VolumeInfo(
                title: "George Orwell's Guide Through Hell",
                subtitle: "A Psychological Study of 1984",
                authors: ["Robert Plank"],
                publisher: "Wildside Press LLC", printType: "book",
                publishedDate: "1994",
                description: "It is difficult now to recall the enormous impact that George Orwell's classic dystopia, Nineteen Eighty-Four, had on the psyche of the western world. Written by a dying man in the grimmest of circumstances, the novel was intended as both a warning against totalitarianism and the debasement of language, and as a reaction to Orwell's personal experiences with English socialism and World War II. Clearly, \"1984\" has turned out differently than Orwell depicted. Yet the power of the novel remains undiminished: it continues to scare and enlighten future generations of readers nearly a half century after its original publication. Well-known scholar Robert Plank provides a psychological examination of the roots of Nineteen Eighty-Four, and the curious parallels between the book and its antecedents, including the film Citizen Kane, the novels of Dostoevsky and Kafka, the philosophy of Whorf, Orwell's own life and works, and many other obvious and hidden influences. Complete with chronology, notes, bibliographies, and index.",
                pageCount: 136,
                categories: ["Literary Criticism", "Psychology", "Motorization", "Something"],
                averageRating: 3,
                ratingsCount: 12,
                language: "en",
                imageLinks: GoogleBook.VolumeInfo.ImageLinks(smallThumbnail: "http://books.google.com/books/content?id=lBXf1slZBDwC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", thumbnail: ""), previewLink: "", infoLink: ""),
             accessInfo: GoogleBook.AccessInfo(viewability: "Partial", epub: GoogleBook.AccessInfo.Epub(isAvailable: true, downloadLink: "link"), pdf: GoogleBook.AccessInfo.Pdf(isAvailable: true, downloadLink: "nil")),
             saleInfo: GoogleBook.SaleInfo(retailPrice: GoogleBook.SaleInfo.RetailPrice(amount: 121, currencyCode: "PLN"), saleability: "FREE")),
    
        GoogleBook(id: "hDgEEAAAQBAJ",
             etag: "VBB2lDoTn34",
             volumeInfo: GoogleBook.VolumeInfo(
                title: "SwiftUI Cookbook",
                subtitle: "Discover solutions and best practices to tackle the most common problems while building SwiftUI apps",
                authors: [
                    "Giordano Scalzo",
                    "Edgar Nzokwe"
                  ],
                publisher: "Packt Publishing Ltd", printType: "book",
                publishedDate: "2020-10-19",
                description: "SwiftUI is an innovative new framework to build UI for all Apple platforms using Swift. This recipe-based guide covers the new features of SwiftUI 2 introduced on iOS14 and helps you migrate from UIkit with a simple learning curve through practical solutions. Learn how SwiftUI combines with Apple dev tools to build truly cross-platform Apple apps.",
                pageCount: 614,
                categories: ["Computers"],
                averageRating: 4,
                ratingsCount: 122,
                language: "en",
                imageLinks: GoogleBook.VolumeInfo.ImageLinks(smallThumbnail: "", thumbnail: ""), previewLink: "", infoLink: ""),
             accessInfo: GoogleBook.AccessInfo(viewability: "", epub: GoogleBook.AccessInfo.Epub(isAvailable: false, downloadLink: nil), pdf: GoogleBook.AccessInfo.Pdf(isAvailable: false, downloadLink: nil)),
             saleInfo: GoogleBook.SaleInfo(retailPrice: nil, saleability: "FREE"))
//
//        GoogleBook(id: "1y8NEAAAQBAJ",
//             etag: "XR7xFUs4Mqc",
//             volumeInfo: GoogleBook.VolumeInfo(
//                title: "SwiftUI Essentials - iOS 14 Edition, SwiftUI Essentials - iOS 14 Edition",
//                subtitle: "Learn to Develop iOS Apps Using SwiftUI, Swift 5 and Xcode 12",
//                authors: ["Neil Smyth"],
//                publisher: "eBookFrenzy",
//                publishedDate: "2020-12-07",
//                description: "The goal of this book is to teach the skills necessary to build iOS 14 applications using SwiftUI, Xcode 12 and the Swift 5.3 programming language. Beginning with the basics, this book provides an outline of the steps necessary to set up an iOS development environment together with an introduction to the use of Swift Playgrounds to learn and experiment with Swift. The book also includes in-depth chapters introducing the Swift 5.3 programming language including data types, control flow, functions, object-oriented programming, property wrappers and error handling. An introduction to the key concepts of SwiftUI and project architecture is followed by a guided tour of Xcode in SwiftUI development mode. The book also covers the creation of custom SwiftUI views and explains how these views are combined to create user interface layouts including the use of stacks, frames and forms. Other topics covered include data handling using state properties in addition to observable, state and environment objects, as are key user interface design concepts such as modifiers, lists, tabbed views, context menus, user interface navigation, and outline groups. The book also includes chapters covering graphics drawing, user interface animation, view transitions and gesture handling, WidgetKit, document-based apps and SiriKit integration. Chapters are also provided explaining how to integrate SwiftUI views into existing UIKit-based projects and explains the integration of UIKit code into SwiftUI. Finally, the book explains how to package up a completed app and upload it to the App Store for publication. Along the way, the topics covered in the book are put into practice through detailed tutorials, the source code for which is also available for download. The aim of this book, therefore, is to teach you the skills necessary to build your own apps for iOS 14 using SwiftUI. Assuming you are ready to download the iOS 14 SDK and Xcode 12 and have an Apple Mac system you are ready to get started.",
//                pageCount: 492,
//                categories: ["Computers"],
//                averageRating: 1,
//                ratingsCount: 2,
//                language: "en",
//             imageLinks: GoogleBook.VolumeInfo.ImageLinks(smallThumbnail: "http://books.google.com/books/content?id=jJStSQz96loC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api")),
//             accessInfo: GoogleBook.AccessInfo(epub: GoogleBook.AccessInfo.Epub(isAvailable: false, downloadLink: nil), pdf: GoogleBook.AccessInfo.Pdf(isAvailable: false, downloadLink: nil)),
//             saleInfo: GoogleBook.SaleInfo(retailPrice: GoogleBook.SaleInfo.RetailPrice(amount: 201, currencyCode: "PLN"))),
//
//        GoogleBook(id: "TvEqDAAAQBAJ",
//             etag: "pcbZcgwq8CI",
//             volumeInfo: GoogleBook.VolumeInfo(
//                title: "12 Rules for Life",
//                subtitle: "An Antidote to Chaos",
//                authors: ["Jordan B. Peterson"],
//                publisher: "Random House Canada",
//                publishedDate: "2018-01-23",
//                description: "#1 NATIONAL BESTSELLER #1 INTERNATIONAL BESTSELLER What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research. Humorous, surprising and informative, Dr. Peterson tells us why skateboarding boys and girls must be left alone, what terrible fate awaits those who criticize too easily, and why you should always pet a cat when you meet one on the street. What does the nervous system of the lowly lobster have to tell us about standing up straight (with our shoulders back) and about success in life? Why did ancient Egyptians worship the capacity to pay careful attention as the highest of gods? What dreadful paths do people tread when they become resentful, arrogant and vengeful? Dr. Peterson journeys broadly, discussing discipline, freedom, adventure and responsibility, distilling the world's wisdom into 12 practical and profound rules for life. 12 Rules for Life shatters the modern commonplaces of science, faith and human nature, while transforming and ennobling the mind and spirit of its readers.",
//                pageCount: 320,
//                categories: ["Psychology"],
//                averageRating: 3.5,
//                ratingsCount: 27,
//                language: "en",
//                imageLinks: GoogleBook.VolumeInfo.ImageLinks(smallThumbnail: "http://books.google.com/books/content?id=UDnvBQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api")),
//             accessInfo: GoogleBook.AccessInfo(epub: GoogleBook.AccessInfo.Epub(isAvailable: false, downloadLink: nil), pdf: GoogleBook.AccessInfo.Pdf(isAvailable: false, downloadLink: nil)),
//             saleInfo: GoogleBook.SaleInfo(retailPrice: GoogleBook.SaleInfo.RetailPrice(amount: 91.09, currencyCode: "PLN")))
    ]
}
