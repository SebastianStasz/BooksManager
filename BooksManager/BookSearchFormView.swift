//
//  BookSearchFormView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import SwiftUI

struct BookSearchFormView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject private var form: SearchBooksForm
    @Binding private var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("Search source", selection: $form.searchSource) {
                ForEach(SearchBooksForm.Source.allCases) {
                    Text($0.rawValue).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            
            Form {
                Section(header: Text("Precise Search")) {
                    TextField("Title", text: $form.title)
                    TextField("Author", text: $form.author)
                }
                
                if form.searchSource == .google {
                    ForEach(GoogleBooksForm.Filtering.allCases, id: \.self) { Text($0.rawValue) }
                        .embedInLabeledMenuPicker(selection: $form.filtering, selectedItem: form.filtering.rawValue, label: filteringLabel)
                    
                    ForEach(GoogleBooksForm.PrintType.allCases, id: \.self) { Text($0.rawValue) }
                        .embedInLabeledMenuPicker(selection: $form.printType, selectedItem: form.printType.rawValue, label: printTypeLabel)
                    
                    Section {
                        Toggle("Show only epub available", isOn: $form.epubOnly)
                        Toggle("Sort by newest", isOn: $form.sortByNewest)
                    }
                }
                
                if form.searchSource == .apple {
                    Toggle("Search by genre", isOn: $form.searchByGenre)
                    
                    ForEach(AppleBooksForm.MediaType.allCases, id: \.self) { Text($0.rawValue) }
                        .embedInLabeledMenuPicker(selection: $form.mediaType, selectedItem: form.mediaType.rawValue, label: mediaTypeLabel)
                    
                    ForEach(AppleBooksForm.Country.allCases, id: \.self) { Text($0.rawValue) }
                        .embedInLabeledMenuPicker(selection: $form.country, selectedItem: form.country.rawValue, label: countryLabel)
                }
            }
            
            resetAndDoneButtons
        }
        .padding(.vertical)
        .background(Color.systemGroupedBackground)
    }
    
    private var resetAndDoneButtons: some View {
        HStack {
            Button("Reset", action: resetForm).foregroundColor(.red)
            Spacer()
            Button("Done", action: closeSheet)
        }
        .padding(.horizontal)
        .padding(.vertical, 13)
        .background(resetAndDoneButtonsBackground)
        .cornerRadius(9)
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
    }
    
    private var resetAndDoneButtonsBackground: Color {
        colorScheme == .dark ? Color.secondarySystemBackground : Color.systemBackground
    }
    
    private var filteringLabel: LocalizedStringKey {
        "Additional filtering"
    }
    
    private var printTypeLabel: LocalizedStringKey {
        "Print type"
    }
    
    private var mediaTypeLabel: LocalizedStringKey {
        "Media type"
    }
    
    private var countryLabel: LocalizedStringKey {
        "Country"
    }
    
    // MARK: -- Interactions
    
    private func closeSheet() {
        isPresented = false
    }
    
    private func resetForm() {
        form.reset()
        closeSheet()
    }
    
    // MARK: -- Initializer
    
    init(form: SearchBooksForm, isPresented: Binding<Bool>) {
        self.form = form
        self._isPresented = isPresented
    }
}

// MARK: -- Preview

struct BookSearchFormView_Previews: PreviewProvider {
    static var previews: some View {
        let form = SearchBooksForm()
        BookSearchFormView(form: form, isPresented: .constant(true))
//            .border(Color.black, width: 1)
//            .preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier: "en"))
    }
}
