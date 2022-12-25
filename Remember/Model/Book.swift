//
//  Book.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import Foundation


struct BookDetails: Identifiable {
    
    static let example = BookDetails(title: "Harry Potter AND THE PRISONER OF AZKABAN",
     description: "For twelve long years, the dread fortress of Azkaban held an infamous prisoner named Sirius Black. Convicted of killing thirteen people with a single curse, he was said to be the heir apparent",
     imageURL: "https://images.ctfassets.net/usf1vwtuqyxm/24YWmI4UcyoMwj7wdKrEcL/374de1941927db12bd844fb197eab11f/English_Harry_Potter_3_Epub_9781781100233.jpg",
     author: "J.K. Rowling",
     releaseDate: "1999")
    
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
    let author: String
    let releaseDate: String
    
    var rating = 4
    var quotes = [Quote]()
    var relatedBooks = [BookDetails]()
}

struct Quote {
    var value: String
    var speaker: String
    var pageNumber: String
}
