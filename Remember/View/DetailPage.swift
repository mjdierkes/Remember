//
//  DetailPage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI

struct DetailPage: View {
    
    @EnvironmentObject var manager: AppManager
    @StateObject var model = UIStateModel()

    var body: some View {
        
        ZStack {
           
            ZStack {
                
                ScrollView {
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
                        
                        SnapCarousel(items: $manager.cards)
                            .environmentObject(model)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("Add")
                                        .bold()
                                    Image(systemName: "text.quote")
                                }
                                .foregroundColor(.black)
                            }
                            .cornerRadius(.infinity)
                            .tint(.white)
                            .buttonStyle(.borderedProminent)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "rectangle.stack.fill.badge.plus")
                                    .padding(7)
                            }
                            .background {
                                Circle()
                                    .foregroundColor(.white)
                                    .opacity(0.12)
                            }
                            
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
                    .padding(20)
                }
                .offset(y: 40)

                VStack {
                    HStack{
                        Button {
                            withAnimation  {
                                manager.showDetail.toggle()
                            }
                        } label: {
                            Label("", systemImage: "chevron.backward")
                                .font(.title2)
                        }
                        Spacer()
                        Button {} label: {
                            Label("", systemImage: "square.and.arrow.up")
                                .font(.title2)
                        }
                    }
                    .padding(20)
                    .frame(height: 50)
//                    .background(.white.opacity(0.12))
                    Spacer()
                }
                
            }
            .preferredColorScheme(.dark)
//            .foregroundColor(AverageColor.getColor(url: manager.currentBook.imageURL))
            
            HStack {
                Rectangle()
                    .foregroundColor(.white).opacity(0.0001)
                    .frame(width: 20)
                    .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                        .onEnded { value in
                            print(value)
                            let horizontalAmount = value.translation.width
                            if horizontalAmount > 0 {
                                withAnimation {
                                    manager.showDetail.toggle()
                                }
                            }
                        })
                Spacer()
            }
            
        }


    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
