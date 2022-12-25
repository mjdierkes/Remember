//
//  CardView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI


struct CardView: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var offset = CGSize.zero
//    @Binding var assessment: Assignment
    @Binding var card: Card
    
    
    var removal: (() -> Void)? = nil

    var body: some View {
        
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("Background"))
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(card.name)
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 2)

                        Text(card.dueDate)
                        
                        Spacer()
//                        NavigationLink(destination: DetailedAssignmentPage(assessment: card.assignment)) {
//                            Text("Learn More")
//                        }
//                        .tint(Color("GradGreen"))
                    }
                    .padding(.vertical)
                    .padding(.trailing, 19)

                    Spacer()
                }
            }
            .padding()
        }
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    @State private static var card = Card(id: 0, name: "Gradual Grades", className: "Mobile Apps", dueDate: "February 20th")
//    static var previews: some View {
//        CardView(card: $card)
//    }
//}
