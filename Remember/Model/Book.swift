//
//  Book.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import Foundation
import SwiftUI
import UIKit


struct BookDetails: Identifiable {
    
    static let example = BookDetails(title: "Harry Potter AND THE PRISONER OF AZKABAN",
     description: """
    For twelve long years, the dread fortress of Azkaban held an infamous prisoner named Sirius Black. Convicted of killing thirteen people with a single curse, he was said to be the heir apparent to the Dark Lord, Voldemort.
    Now he has escaped, leaving only two clues as to where he might be headed: Harry Potter’s defeat of You-Know-Who was Black’s downfall as well. And the Azkaban guards heard Black muttering in his sleep, “He’s at Hogwarts… he’s at Hogwarts.”
    Harry Potter isn’t safe, not even within the walls of his magical school, surrounded by his friends. Because on top of it all, there may be a traitor in their midst.
    """,
     imageURL: "https://www.pottermorepublishing.com/wp-content/covers/web/9781781100516.jpg",
     author: "J.K. Rowling",
     releaseDate: "1999")
    
    static let example2 = BookDetails(title: "Atomic Habits",
     description: """
    The #1 New York Times bestseller. Over 4 million copies sold! - No matter your goals, Atomic Habits offers a proven framework for improving--every day. James Clear, one of the world's leading experts on habit formation, reveals practical strategies that will teach you exactly how to form good habits, break bad ones, and master the tiny behaviors that lead to remarkable results. - If you're having trouble changing your habits, the problem isn't you. The problem is your system. Bad habits repeat themselves again and again not because you don't want to change, but because you have the wrong system for change. ou do not rise to the level of your goals. You fall to the level of your systems. Here, you'll get a proven system that can take you to new heights. - Clear is known for his ability to distill complex topics into simple behaviors that can be easily applied to daily life and work. Here, he draws on the most proven ideas from biology, psychology, and neuroscience to create an easy-to-understand guide for making good habits inevitable and bad habits impossible. Along the way, readers will be inspired and entertained with true stories from Olympic gold medalists, award-winning artists, business leaders, life-saving physicians, and star comedians who have used the science of small habits to master their craft and vault to the top of their field.
    """,
     imageURL: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRHssyxg4DlFMZNDTEBwRAdLlvyM_NxC7ZJy01avfoeurd2QMIsYbkVTM5D4YVpgTbnqOygM1Tbvr5Pcu_buHWPUgMZSBZiNdeXvhtudsU&usqp=CAE",
     author: "James Clear",
     releaseDate: "2018")
    
    
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
    let author: String
    let releaseDate: String
    
    var foreground: Color = .black
    var colorScheme: ColorScheme = .light
    var image: UIImage

    var rating = 4
    var quotes = [Quote]()
    var relatedBooks = [BookDetails]()
    
    init(title: String, description: String, imageURL: String, author: String, releaseDate: String, rating: Int = 4, quotes: [Quote] = [Quote](), relatedBooks: [BookDetails] = [BookDetails]()) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.author = author
        self.releaseDate = releaseDate
        self.rating = rating
        self.quotes = quotes
        self.relatedBooks = relatedBooks
    
        
        let imageData = try? Data(contentsOf: URL(string: imageURL)!)
            // Create a UIImage from the data
            if let imageData {
                self.image = UIImage(data: imageData)!
                let average = AverageColor.get(from: image)
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0

                average.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                let luminosity = 0.2126 * red + 0.7152 * green + 0.0722 * blue
                print("Luminosity", luminosity)
                if luminosity > 0.5 {
                    foreground = .black
                    colorScheme = .light
                } else {
                    foreground = .white
                    colorScheme = .dark
                }
            } else {
                self.image = UIImage()
            }
    }
    
}



struct Quote {
    var value: String
    var speaker: String
    var pageNumber: String
}
