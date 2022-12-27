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
    @State private var selection = 0

    var body: some View {
        
//        NavigationView {
                           
            ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        Spacer()
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
                        ExpandableText(manager.currentBook.description, lineLimit: 4)
                        
//                        if !manager.currentBook.quotes.isEmpty {
                            TabView(selection: $selection) {
                                ForEach(0..<3) { quote in
                                    MyCard(color: $manager.currentBook.foreground)
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
//                        }
                      
//                        SnapCarousel(items: $manager.cards, foreground: $manager.currentBook.foreground)
//                            .environmentObject(model)
                        
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
                                        withAnimation {
                                            manager.currentBook.rating = i + 1
                                        }
                                    } label: {
                                        Label("", systemImage: (i < manager.currentBook.rating) ?  "star.fill" : "star")
                                            .font(.headline)
                                    }
                                    .frame(width: 22)
                                }
                            }
                            
                            
                        }
                        
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
                           router.updateRoot(root: .A)
                       }
                   }
                   .tint(manager.currentBook.foreground)
                }
            }
            .preferredColorScheme(manager.currentBook.colorScheme)
            .toolbarColorScheme(manager.currentBook.colorScheme, for: .navigationBar)
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
//            HStack {
//                Rectangle()
//                    .foregroundColor(.white).opacity(0.0001)
//                    .frame(width: 20)
//                    .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
//                        .onEnded { value in
//                            print(value)
//                            let horizontalAmount = value.translation.width
//                            if horizontalAmount > 0 {
//                                withAnimation {
//                                    router.updateRoot(root: .C)
//                                }
//                            }
//                        })
//                Spacer()
//            }
            
//        }


    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
