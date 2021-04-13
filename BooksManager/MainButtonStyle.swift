//
//  MainButtonStyle.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 01/04/2021.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: 200, maxHeight: 50)
            .background(Color.systemBlue)
            .cornerRadius(5)
            .opacity(configuration.isPressed ? 0.6 : 0.9)
    }
}
