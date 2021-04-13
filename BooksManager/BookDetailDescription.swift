//
//  BookDetailDescription.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 27/03/2021.
//

import SwiftUI

struct BookDetailDescription: View {
    private let text: String
    @State private var isTruncated = false
    @State private var forceFullText = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            TruncableText(text, lineLimit: lineLimit ) {
                isTruncated = $0
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineSpacing(7)
            
            if isTruncated || forceFullText {
                Button(buttonText, action: showFullDescription)
            }
        }
    }
    
    private var lineLimit: Int? {
        forceFullText ? .none : 5
    }
    
    private var buttonText: String {
        forceFullText ? "Show less" : "Show more"
    }
    
    private func showFullDescription() {
        withAnimation { forceFullText.toggle() }
    }
    
    init(_ text: String) {
        self.text = text
    }
}

// MARK: -- Preview

struct BookDetailDescription_Previews: PreviewProvider {
    static var previews: some View {
        let text = "In purus ligula, bibendum non justo in, porta porta arcu. Maecenas et vestibulum nisl. Mauris nec ullamcorper ex. Sed ullamcorper semper sapien, eget scelerisque nisi lacinia eget. Etiam et erat eu eros efficitur sagittis. Mauris sem neque, commodo in orci tempor, tempus convallis lorem. Proin fringilla orci et molestie ultricies. Aliquam a tincidunt ante, non pellentesque nisl. Proin mi nisi, faucibus sit amet quam quis, consectetur elementum lacus. Pellentesque elit ipsum, vestibulum in mollis sit amet, sollicitudin quis massa. Nunc feugiat arcu non lobortis porta. Nulla efficitur lorem in ipsum aliquam, id lobortis nunc pharetra. Suspendisse molestie nibh quis nunc mollis posuere. Sed lobortis ullamcorper tellus id malesuada. Ut venenatis iaculis arcu, eu porta nisi vestibulum id. Aliquam auctor lobortis elementum."
        
        BookDetailDescription(text)
            .padding()
    }
}
