//
//  LabeledMenuPicker.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import SwiftUI

struct LabeledMenuPicker<T: Hashable>: ViewModifier {
    let selection: Binding<T>
    let selectedItem: LocalizedStringKey
    let label: LocalizedStringKey
    
    func body(content: Content) -> some View {
        HStack {
            Text(label) ; Spacer()
            Picker(selectedItem, selection: selection) { content }
                .pickerStyle(MenuPickerStyle())
        }
    }
}

extension View {
    func embedInLabeledMenuPicker<T: Hashable>(selection: Binding<T>, selectedItem: LocalizedStringKey, label: LocalizedStringKey) -> some View {
        modifier(LabeledMenuPicker(selection: selection, selectedItem: selectedItem, label: label))
    }
}
