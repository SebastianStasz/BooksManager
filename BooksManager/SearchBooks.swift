//
//  SearchBooks.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 12/03/2021.
//

import Foundation
import Combine

class SearchBooks: ObservableObject {
    private var appleAudiobooksService = BooksService(AppleBooksAPI<AppleAudiobook>())
    private var appleEbooksService = BooksService(AppleBooksAPI<AppleEbook>())
    private var googleBooksService = BooksService(GoogleBooksAPI())
    private let formHasBennClosed = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    @Published private var currentIndex = 0
    
    @Published private(set) var error: APIServiceError?
    @Published private(set) var books: [BookViewModel] = []
    @Published private(set) var nextSearchWhenId: String?
    @Published private(set) var responseIsEmpty = false
    @Published private(set) var isLoading = false
    @Published var form = SearchBooksForm()
    
    // MARK: -- View Interactions
    
    func getMoreResults(if current: String) {
        if nextSearchWhenId == current {
            if form.searchSource == .apple && currentIndex == 0 {
                currentIndex += 21
            } else {
                currentIndex += 20
            }
        }
    }
    
    func notifyAboutClosingForm() {
        formHasBennClosed.send()
    }
    
    func resetSearch() {
        form.searchTerm = ""
        books = []
        responseIsEmpty = false
    }
    
    // MARK: -- Search Functionality
    
    private func searchFieldHasBeenChanged() -> AnyPublisher<String, Never> {
        form.$searchTerm
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count > 2 }
            .eraseToAnyPublisher()
    }

    private func googleFormHasBeenChanged() -> AnyPublisher<SearchBooksForm.Additional, Never> {
        form.$additional
            .map { [unowned self] form in
                formHasBennClosed.map { form }
            }
            .switchToLatest()
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private func performNewSearch() -> AnyPublisher<Void, Never> {
        Publishers.CombineLatest(searchFieldHasBeenChanged(), googleFormHasBeenChanged())
            .filter { [unowned self] _ in form.searchTerm != "" }
            .map { _ in }.eraseToAnyPublisher()
    }
    
    private func makeAPICall() -> AnyPublisher<[BookViewModel], APIServiceError> {
        $currentIndex.dropFirst()
            .map { [unowned self] index -> AnyPublisher<[BookViewModel], APIServiceError> in
                isLoading = true
                if form.searchSource == .google {
                    return googleBooksService.fetchBooks(form: form, startAt: index)
                } else {
                    if form.mediaType == .audiobook {
                        return  appleAudiobooksService.fetchBooks(form: form, startAt: index)
                    } else {
                        return  appleEbooksService.fetchBooks(form: form, startAt: index)
                    }
                }
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    init() {
        performNewSearch()
            .sink { [unowned self] _ in
                books = []
                currentIndex = 0
            }
            .store(in: &subscriptions)
        
        
        makeAPICall()
            .sink(receiveCompletion: { [unowned self] in
                if case .failure(let error) = $0 {
                    isLoading = false
                    self.error = error
                    print(error.getError)
                }
            }, receiveValue: { [unowned self] items in
                books += items
                isLoading = false
                responseIsEmpty = items.isEmpty ? true : false
                let next = items.count - 5
                let isNextIndex = items.indices.contains(next)
                nextSearchWhenId = isNextIndex ? items[next].id : nil
            })
            .store(in: &subscriptions)
            
        formHasBennClosed.send()
    }
}

