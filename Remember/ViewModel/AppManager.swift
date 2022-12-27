//
//  AppManager.swift
//  Remember
//
//  Created by Mason Dierkes on 12/2/22.
//

import Foundation
import UIKit
import SwiftUI

@MainActor class AppManager: ObservableObject {
    
    @Published var books = [BookDetails]()
    @Published var selection = 0

    @Published var currentBook = BookDetails.example
    
    @Published var searchBooks = [Book]()
    
    let bookService = BookService()

    init() {
//        currentBook.relatedBooks.append(BookDetails.example)
//        currentBook.relatedBooks.append(BookDetails.example)
//        currentBook.relatedBooks.append(BookDetails.example)
//        currentBook.relatedBooks.append(BookDetails.example)
//        currentBook.relatedBooks.append(BookDetails.example)
//        currentBook.relatedBooks.append(BookDetails.example)

        books.append(BookDetails.example)
        books.append(BookDetails.example2)

//        searchImages(query: "9780062416179", imageUrl: "http://books.google.com/books/content?id=Sm5AKLXKxHgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api") { images in
//            print(images)
//        }
        
    }
    

    func loadData(with searchTerm: String) async throws {
        let result: SearchResult = try await bookService.fetchData(from: .bookSearch, value: searchTerm)
        searchBooks = result.items
        print(result)
    }
    
}

