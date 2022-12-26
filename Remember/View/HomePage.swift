//
//  HomePage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI
import UIKit

struct HomePage: View {
    @State private var selection = 0
    @State private var mode: ColorScheme = .dark
    @StateObject var manager = AppManager()
    @State private var textColor: Color = .purple

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if manager.showDetail {
                    
                    Text("REMEMBER")
                        .kerning(5)
                        .font(.headline)
                        .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 30.0)
                    
                    TabView(selection: $selection) {
                        ForEach(Array(manager.books.enumerated()), id: \.offset) { index, book in
                            CoverArt(textColor: $textColor, book: book).environmentObject(manager)
                                .tag(index)
                        }
                    }
                    
                    .frame(height: 500)
                    .tabViewStyle(PageTabViewStyle())
                    
                } else {
                    DetailPage()
                        .environmentObject(manager)
                }
            }
        }
        .onChange(of: selection) { newValue in
            withAnimation {
                manager.currentBook = manager.books[newValue]
            }
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
        }
        .background {
            AsyncImage(
                url:URL(string: manager.currentBook.imageURL),
                content: { image in
                    image.resizable()
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fit)
                        .blur(radius: 50)
                },
                placeholder: {
                }
            )
            .frame(width: 1000, height: 1000)
        }
        .foregroundColor(manager.currentBook.foreground)
        .preferredColorScheme(manager.currentBook.colorScheme)
    }
    
    struct CoverArt: View {
        
        @EnvironmentObject var manager: AppManager
        @Binding var textColor: Color
        
        var book: BookDetails
        
        
        var body: some View {
            AsyncImage(
                url:URL(string: book.imageURL),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                },
                placeholder: {
                }
            )
            .onTapGesture {
                withAnimation{
                    manager.showDetail.toggle()
                }
            }
            .cornerRadius(11)
            .frame(width: 386, height: 386)
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
