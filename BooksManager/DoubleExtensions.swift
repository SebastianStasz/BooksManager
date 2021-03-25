//
//  DoubleExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 13/03/2021.
//

import Foundation

extension Double {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
