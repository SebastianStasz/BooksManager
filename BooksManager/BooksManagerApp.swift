//
//  BooksManagerApp.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 11/03/2021.
//

import SwiftUI

@main
struct BooksManagerApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            BookListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
