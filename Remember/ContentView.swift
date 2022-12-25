////
////  ContentView.swift
////  Remember
////
////  Created by Mason Dierkes on 12/2/22.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @StateObject var manager = AppManager()
//    @State private var selection = 0
//    var body: some View {
//        VStack {
//            
//            if manager.books.count > 0 {
//                TabView(selection: $selection) {
//                    ForEach(Array(manager.books.enumerated()), id: \.offset) { index, book in
//                        AsyncImage(
//                            url:URL(string: book.volumeInfo.imageLinks.thumbnail ?? ""),
//                            content: { image in
//                                image.resizable()
//                                    .aspectRatio(contentMode: .fit)
//                            },
//                            placeholder: {
//                            }
//                        )
//                        .cornerRadius(8)
//                        .frame(width: 400, height: 400)
//                        .tag(index)
//                    }
//                }
//                .tabViewStyle(PageTabViewStyle())
//            }
//            
//        }
//        .background {
//            if manager.books.count > 0 {
//                AsyncImage(
//                    url:URL(string: manager.books[selection].volumeInfo.imageLinks.thumbnail ?? ""),
//                    content: { image in
//                        image.resizable()
//                            .cornerRadius(8)
//                            .aspectRatio(contentMode: .fit)
//                            .blur(radius: 30)
//                    },
//                    placeholder: {
//                    }
//                )
//                .frame(width: 1000, height: 1000)
//
//            }
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            Task {
//                await loadData()
//            }
//        }
//        .padding()
//
//    }
//    
//    func loadData() async {
//        do {
//            try await manager.loadData()
//        } catch {
//            print("Error")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
