//
//  SFSymbolsHelper.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 19/03/2021.
//

import Foundation
import SwiftUI

enum SFSymbol: String {
    case noInternet = "wifi.slash"
    case someError = "exclamationmark.shield"
    
    var image: Image {
        Image(systemName: rawValue)
    }
}
