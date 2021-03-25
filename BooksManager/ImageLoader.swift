//
//  ImageLoader.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 25/03/2021.
//

import Combine
import Foundation
import SwiftUI

final class ImageLoader: ObservableObject {
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    private let apiService = APIService.shared
    private var apiSubscription: AnyCancellable?
    private var cache: ImageCache?
    private var isLoading = false
    private let url: String?
    @Published private(set) var failedToLoad = false
    @Published private(set) var image: Image?
    
    init(url: String?, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    func loadImage() {
        guard !isLoading else { return }
        guard let url = url else { return }
        
        if let img = cache?[by: url] {
//            print("Image from cache: \(url)")
            self.image = Image(uiImage: img) ; return
        }
        
//        print("Downloading image from: \(url)")
        apiSubscription = apiService.fetchImage(from: url)
            .subscribe(on: ImageLoader.imageProcessingQueue)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] in
                self?.onFinish()
                if case .failure(let err) = $0 {
                    print(err)
                    self?.failedToLoad = true
                }
            }, receiveValue: { [weak self] in
                self?.failedToLoad = false
                self?.image = Image(uiImage: $0)
                self?.cache($0, by: url)
            })
    }
    
    private func cancel() {
        apiSubscription?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?, by url: String) {
        image.map { cache?[by: url] = $0 }
    }
}
