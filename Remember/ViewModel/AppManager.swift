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
    
    @Published var books = [Book]()
//    @Published var showDetail = true
    @Published var currentBook = BookDetails.example
    @Published var cards = [Card(id: 2, name: "Dubmledore"),Card(id: 3, name: "Dubmledore"),Card(id: 4, name: "Dubmledore")]
    
    
    init() {
        currentBook.relatedBooks.append(BookDetails.example)
        currentBook.relatedBooks.append(BookDetails.example)
        currentBook.relatedBooks.append(BookDetails.example)
        currentBook.relatedBooks.append(BookDetails.example)
        currentBook.relatedBooks.append(BookDetails.example)
        currentBook.relatedBooks.append(BookDetails.example)

        searchImages(query: "9781781100516", imageUrl: "http://books.google.com/books/content?id=Sm5AKLXKxHgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api") { images in
            print(images)
        }
        
    }
    func loadData() async throws {
        let imageService = ImageService()
        try await imageService.postRequest()
//        guard let url = URL(string: "https://www.amazon.com/dp/1338216678/") else {
//                fatalError("Can not get url")
//            }
//        let imgUrl = imageService.getProductImage(url: url)
//        print(imgUrl)
        
        let bookService = BookService()
        let result: SearchResult = try await bookService.fetchData(from: .bookSearch, value: "PrisonerAzkaban")
        books = result.items
        print(result)
    }
    
    
  
    
}

