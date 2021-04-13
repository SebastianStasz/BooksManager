//
//  UnderlinePicker.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 27/03/2021.
//

import SwiftUI

/// A custom control for selecting from a set of mutually exclusive values.
struct UnderlinePicker<Data, ID, Content, Selection>: View where
    Data: RandomAccessCollection,
    ID: Hashable,
    Content: View,
    Selection: Hashable,
    Selection == Data.Element
{
    private let data: Data
    private let forEachBuilder: (Data.Element) -> Content
    private let identityKeyPath: KeyPath<Data.Element, ID>
    private let accentColor: Color
    @Binding private var selection: Selection
    
    /// Creates an underline picker  based on the provided key path to the underlying data's identifier.
    init(_ data: Data,
         id: KeyPath<Data.Element, ID>,
         selection: Binding<Selection>,
         accentColor: Color = .blue,
         @ViewBuilder content: @escaping (Data.Element) -> Content)
    {
        self.data = data
        identityKeyPath = id
        _selection = selection
        self.accentColor = accentColor
        forEachBuilder = content
    }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(data, id: identityKeyPath) { element in
                Button { selection = element } label: { forEachBuilder(element) }
                    .buttonStyle(ContentPickerButtonStyle(isSelected: element == selection, lineColor: accentColor))
            }
        }
    }
}

// MARK: -- Initializers

extension UnderlinePicker where
    ID == Data.Element.ID,
    Data.Element: Identifiable,
    Selection: Hashable,
    Selection == Data.Element
{
    
    /// Creates an underline picker  based on the identity of the underlying data.
    init(_ data: Data,
         selection: Binding<Selection>,
         accentColor: Color = .blue,
         @ViewBuilder content: @escaping (Data.Element) -> Content)
    {
        self.init(data, id: \.id, selection: selection, accentColor: accentColor, content: content)
    }
}

// MARK: -- Preview

struct UnderLinePicker_Previews: PreviewProvider {
    static var previews: some View {
        UnderLinePickerPreview()
    }
}

struct UnderLinePickerPreview: View {
    @State private var selector: TestEnum = .first
    
    var body: some View {
        UnderlinePicker(TestEnum.allCases, selection: $selector, accentColor: .red) {
            Text($0.rawValue)
        }
    }
    
    private enum TestEnum: String, Identifiable, CaseIterable {
        case first, second, third, fourth
        var id: String { rawValue }
    }
}

// MARK: -- Button Style

fileprivate struct ContentPickerButtonStyle: ButtonStyle {
    let isSelected: Bool
    let font: Font
    let lineColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .padding(.bottom, 5)
            .foregroundColor(isSelected ? .primary : .gray)
            .overlay(bottomLine, alignment: .bottom)
    }
    
    private var bottomLine: some View {
        Rectangle()
            .frame(height: isSelected ? 2 : 0)
            .foregroundColor(lineColor)
    }
    
    init(isSelected: Bool, font: Font = .subheadline, lineColor: Color = .blue) {
        self.isSelected = isSelected
        self.font = font
        self.lineColor = lineColor
    }
}

