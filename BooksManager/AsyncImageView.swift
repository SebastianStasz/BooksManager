//
//  AsyncImageView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 25/03/2021.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    @State private var wasLoaded = false
    private let placeholder: Placeholder
    private let withLoading: Bool
    
    fileprivate init(
        url: String?,
        withLoading: Bool,
        @ViewBuilder placeholder: () -> Placeholder)
    {
        let cache = Environment(\.imageCache).wrappedValue
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: cache))
        self.withLoading = withLoading
        self.placeholder = placeholder()
    }
    
    var body: some View {
        content.onAppear() {
            if !wasLoaded {
                loader.loadImage()
                wasLoaded = true
            }
        }
    }
    
    private var content: some View {
        Group {
            if let image = loader.image {
                image.resizable()
            }
            else {
                if !loader.failedToLoad && withLoading { ProgressView() }
                else { placeholder }
            }
        }
    }
}

// MARK: -- Initializers

extension AsyncImage {
    /// Default placeholder without loading indicator
    init(url: String?) where Placeholder == Image {
        self.init(url: url, withLoading: false, placeholder: { Image(systemName: "photo") })
    }
    
    /// Default placeholder with loading indicator
    init(withLoadingURL url: String?) where Placeholder == Image {
        self.init(url: url, withLoading: true, placeholder: { Image(systemName: "photo") })
    }
    
    /// Custom placeholder without loading indicator
    init(url: String?, @ViewBuilder placeholder: () -> Placeholder) {
        self.init(url: url, withLoading: false, placeholder: placeholder)
    }
    
    /// Custom placeholder with loading indicator
    init(withLoadingURL url: String?, @ViewBuilder placeholder: () -> Placeholder) {
        self.init(url: url, withLoading: true, placeholder: placeholder)
    }
}

// MARK: -- Preview

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: "https://c.stocksy.com/a/BeI600/z9/1501651.jpg")
    }
}
