//
//  ViewExtensions.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import SwiftUI

// MARK: -- Embed in Navigation View

extension View {
    func embedInNavigationView(_ style: NavigationBarItem.TitleDisplayMode = .automatic) -> some View {
        NavigationView {
            self.navigationBarTitleDisplayMode(style)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: -- Change Size

extension View {
    func changeSize(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil, contentMode: ContentMode = .fit) -> some View {
        self
            .aspectRatio(contentMode: contentMode)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
}

// MARK: -- Dismiss Keyboard

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
