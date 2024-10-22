//
//  BooksExplorerListViewModel.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/22/24.
//

import SwiftUI

final class BooksExplorerListViewModel: ObservableObject {
    
    @Published var books: [Item] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetial = false
    @Published var selectedBook: Item?
    @Published var searchText: String = ""
    
    func getBooks() {
        isLoading = true
        NetworkManager.shared.getBooks { result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                switch result {
                case .success(let books):
                    self.books = books
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    var filteredBooks: [Item] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { $0.volumeInfo.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var isBooksListEmpty: Bool {
            return books.isEmpty && !isLoading
        }
}
