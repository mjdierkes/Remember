//
//  HomePage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var manager: AppManager

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                AppLogo()
                BookSelector()
            }
            
          TabBar()

        }
        .foregroundColor(manager.currentBook.foreground)
        .preferredColorScheme(manager.currentBook.colorScheme)
        .background {
            BackgroundImage()
        }
    }
   
}

struct BackgroundImage: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        AsyncImage(
            url:URL(string: manager.currentBook.imageURL),
            content: { image in
                image.resizable()
                    .cornerRadius(8)
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: 50)
            }, placeholder: {} )
        .frame(width: 1000, height: 1000)
        .ignoresSafeArea()
    }
}

fileprivate struct AppLogo: View {
    var body: some View {
        Text("REMEMBER")
            .kerning(5)
            .font(.headline)
            .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 30.0)
    }
}

fileprivate struct BookSelector: View {
    
    @EnvironmentObject var manager: AppManager
    
    var body: some View {
        TabView(selection: $manager.selection) {
            ForEach(Array(manager.books.enumerated()), id: \.offset) { index, book in
                CoverArt(book: book)
                    .tag(index)
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
}

fileprivate struct CoverArt: View {
    
    @EnvironmentObject var router: Router<Path>
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
                router.updateRoot(root: .DetailPage)
            }
        }
        .cornerRadius(11)
        .frame(width: 386, height: 386)
        
    }
}


fileprivate struct TabBar: View {
    
    @EnvironmentObject var manager: AppManager
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                print(manager.currentBook.title)
                withAnimation {
                    router.updateRoot(root: .SearchPage)
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
            manager.hapticFeedback()
        }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
