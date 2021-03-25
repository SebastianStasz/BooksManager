//
//  FormatterExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 18/03/2021.
//

import Foundation

// MARK: -- Static Property For Currency Formatter

extension Formatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
