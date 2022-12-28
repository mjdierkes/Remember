//
//  Card.swift
//  Remember
//
//  Created by Mason Dierkes on 12/24/22.
//

import SwiftUI

struct QuoteCard: View {
    
    @EnvironmentObject var manager: AppManager
    @Binding var color: Color
    
    var body: some View {
        VStack(spacing: 20){
            Text("\"Numbing the pain for a while will make it worse when you finally feel it.\"")
                .font(.title3)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Text("DUBMLEDORE")
                Spacer()
                Text("Page 28")
                    .bold()
            }
            .font(.subheadline)
        }
        .padding(25)
        .background( .regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
