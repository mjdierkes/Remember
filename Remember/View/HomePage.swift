//
//  HomePage.swift
//  Remember
//
//  Created by Mason Dierkes on 12/21/22.
//

import SwiftUI

struct HomePage: View {
    @State private var selection = 0
    @State private var mode: ColorScheme = .dark
    @StateObject var manager = AppManager()
    
    var book = BookDetails.example

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if true {
                    
                    Text("REMEMBER")
                        .kerning(5)
                        .font(.headline)
                        .foregroundColor(.white)
                        .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 30.0)
                    
                    TabView {
                        NavigationLink(destination: DetailPage().environmentObject(manager)) {
                            CoverArt(book: book)
                       }
                        Text("Hey")
                    }
                    .frame(height: 500)
                    .tabViewStyle(PageTabViewStyle())
                } else {
                    DetailPage()
                        .environmentObject(manager)
                }
            }
        }
        .preferredColorScheme(getAverageColor())
        .background {
            AsyncImage(
                url:URL(string: book.imageURL),
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
    }
    
    func getAverageColor() -> ColorScheme {
        let imageUrl = URL(string: book.imageURL)!
        var mode: ColorScheme = .dark
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)!
                let average = AverageColor.get(from: image)
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0

                average.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                let luminosity = 0.2126 * red + 0.7152 * green + 0.0722 * blue
                print(luminosity)
                if luminosity > 0.5 {
                    // Use dark text on light background
                    mode = .light
                } else {
                    // Use white text on dark background
                    mode = .dark
                }
            }
        }.resume()
        return mode
    }

}

struct CoverArt: View {
    
    @EnvironmentObject var manager: AppManager
    let book: BookDetails
    
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
//        .onTapGesture {
//            withAnimation{
//                manager.showDetail.toggle()
//            }
//        }
        .cornerRadius(11)
        .frame(width: 386, height: 386)
    }
    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
