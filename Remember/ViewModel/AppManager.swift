//
//  AppManager.swift
//  Remember
//
//  Created by Mason Dierkes on 12/2/22.
//

import Foundation
import SwiftUI

@MainActor class AppManager: ObservableObject {
    
    @Published var books = [BookDetails]()
    @Published var selection = 0
    @Published var currentBook = BookDetails.example
    @Published var searchBooks = [Book]()
    
    let bookService = BookService()

    init() {
        books.append(BookDetails.example)
        books.append(BookDetails.example2)
    }
    
    func loadData(with searchTerm: String) async throws {
        let result: SearchResult = try await bookService.fetchData(from: .bookSearch, value: searchTerm)
        searchBooks = result.items
        print(result)
    }
    
    func hapticFeedback() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    }
    
}

