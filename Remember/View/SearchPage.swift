//
//  SearchPage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/26/22.
//

import SwiftUI

struct SearchPage: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var searchText: String = ""
    @EnvironmentObject var router: Router<Path>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                ScrollView(showsIndicators: false) {
                    ForEach(manager.searchBooks, id: \.id) { book in
                        HStack {
                            AsyncImage(url: URL(string: book.volumeInfo.imageLinks.thumbnail!)!
                                       , content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 140)
                            }, placeholder: {
                                ProgressView()
                            })
                            .cornerRadius(8)
                            Text(book.volumeInfo.title)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .tint(.white)
            .onChange(of: searchText) { value in
                Task {
                    do {
                        try await manager.loadData(with: value)
                    } catch {
                        
                    }
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
                            .edgesIgnoringSafeArea(.all)
                    },
                    placeholder: {
                    }
                )
                .frame(width: 1000, height: 1000)
            }
            .foregroundColor(manager.currentBook.foreground)
            .preferredColorScheme(manager.currentBook.colorScheme)
            .navigationTitle("Discover")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    withAnimation {
                        router.updateRoot(root: .A)
                    }
                }
                .tint(manager.currentBook.foreground)
            }
        }
        .tint(manager.currentBook.foreground)
        .onAppear {
            Task {
                do {
                    try await manager.loadData(with: "Harry")
                } catch {
                    
                }
            }
        }
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
