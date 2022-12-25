//
//  TestView.swift
//  Remember
//
//  Created by Mason Dierkes on 12/24/22.
//

import SwiftUI

struct TestView: View {
    @State private var showMore = false
    let text: String
    var body: some View {
        VStack {
            Text(text)
                .lineLimit(showMore ? nil : 4)
                .truncationMode(.tail)

            
            HStack {
                Button {
                    withAnimation {
                        self.showMore.toggle()
                    }
                } label: {
                    Text(showMore ? "Show Less" : "Read More")
                        .padding(.vertical, 2)
                        .bold()
                }
                Spacer()
            }
           
        }
    }
}

struct TestView2: View {

    var attributedString: AttributedString

    init() {
        //either like this:
        attributedString = AttributedString("Hello, #swift")
        let range = attributedString.range(of: "#swift")!
        attributedString[range].link = URL(string: "https://www.hackingwithswift.com")!

        //or like this:
        attributedString = try! AttributedString(markdown: "Hello, [#swift](https://www.hackingwithswift.com)")
    }

    var body: some View {
        Text(attributedString)
            .padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
//        TestView(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        TestView2()
    }
}
