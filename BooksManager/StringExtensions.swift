//
//  StringExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 15/03/2021.
//

import Foundation

// MARK: -- Change Space to "+" Sign

extension String {
    func spacesToPlusSign() -> String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
