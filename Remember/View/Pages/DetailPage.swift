//
//  DetailPage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI
import UIKit

struct DetailPage: View {
    
    @EnvironmentObject var manager: AppManager
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                
                Spacer()
                
                Header()
                ExpandableText(manager.currentBook.description, lineLimit: 4)
                QuoteSection()
                BookBar()
                RelatedBooks()
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .foregroundColor(manager.currentBook.foreground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Done") {
                    withAnimation {
                        router.updateRoot(root: .HomePage)
                    }
                }
                .tint(manager.currentBook.foreground)
            }
        }
        .preferredColorScheme(manager.currentBook.colorScheme)
        .toolbarColorScheme(manager.currentBook.colorScheme, for: .navigationBar)
        .background {
            BackgroundImage()
        }
    }
}


fileprivate struct Header: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var selection = 0

    var body: some View {
        Text(manager.currentBook.title)
            .font(.title2)
            .fontWeight(.bold)
        HStack{
            Text(manager.currentBook.author)
                .fontWeight(.heavy)
            
            Text(manager.currentBook.releaseDate)
                .kerning(3)
            Spacer()
            
        }
        .opacity(0.6)
    }
}


fileprivate struct QuoteSection: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<3) { quote in
                QuoteCard(color: $manager.currentBook.foreground)
                    .padding()
            }
        }
        .onChange(of: selection) { newValue in
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }
        .padding(.horizontal, -20)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 160)
        .padding(.vertical, 10)
    }
}

fileprivate struct RelatedBooks: View {
    
    @EnvironmentObject var manager: AppManager
    
    var body: some View {
        Text("Related Books")
            .font(.title3)
            .bold()
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 15) {
                ForEach(manager.currentBook.relatedBooks){ book in
                    AsyncImage(
                        url:URL(string: book.imageURL),
                        content: { image in
                            image.resizable()
                                .cornerRadius(8)
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                        }
                    )
                    .frame(width: 90, height: 140)
                    .offset(x: 20)
                }
            }
        }
        .padding(.horizontal, -20)
    }
}

fileprivate struct BookBar: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        HStack {
            Button {
                
            } label: {
                HStack {
                    Text("Add")
                        .bold()
                    Image(systemName: "text.quote")
                }
                .foregroundColor(manager.currentBook.foreground)
            }
            .cornerRadius(.infinity)
            .tint((manager.currentBook.foreground == .black) ? .white : .black)
            .buttonStyle(.borderedProminent)
            
            Button {
                
            } label: {
                Image(systemName: "rectangle.stack.fill.badge.plus")
                    .padding(7)
            }
            .background(
                .regularMaterial,
                in: Circle()
            )
            
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0..<5) { i in
                    Button {
                        manager.currentBook.rating = i + 1
                    } label: {
                        Label("", systemImage: (i < manager.currentBook.rating) ?  "star.fill" : "star")
                            .font(.headline)
                    }
                    .frame(width: 22)
                }
            }
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
