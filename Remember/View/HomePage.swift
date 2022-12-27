//
//  HomePage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI
import UIKit

struct HomePage: View {
    
    @EnvironmentObject var router: Router<Path>

    @State private var mode: ColorScheme = .dark
    @EnvironmentObject var manager: AppManager
    @State private var textColor: Color = .purple

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Text("REMEMBER")
                    .kerning(5)
                    .font(.headline)
                    .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 30.0)
                
                TabView(selection: $manager.selection) {
                    ForEach(Array(manager.books.enumerated()), id: \.offset) { index, book in
                        CoverArt(textColor: $textColor, book: book).environmentObject(manager)
                            .tag(index)
                    }
                }
                
                .frame(height: 500)
                .tabViewStyle(PageTabViewStyle())
            }
            
            VStack {
                Spacer()
                
                
                Button {
                    print(manager.currentBook.title)
                    withAnimation {
                        router.updateRoot(root: .B)
                    }
                } label: {
                    Label("", systemImage: "magnifyingglass")
                        .font(.title2)
                        .offset(x: 5)
                }
                .padding(40)
            }
            .onChange(of: manager.selection) { newValue in
                withAnimation {
                    manager.currentBook = manager.books[newValue]
                }
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
           
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
            .ignoresSafeArea()
        }
        .foregroundColor(manager.currentBook.foreground)
        .preferredColorScheme(manager.currentBook.colorScheme)
    }
    
    struct CoverArt: View {
        
        @EnvironmentObject var router: Router<Path>
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
                withAnimation {
                    router.updateRoot(root: .C)
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
