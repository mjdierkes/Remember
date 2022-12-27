//
//  SwiftUIView.swift
//  Remember
//
//  Created by Mason Dierkes on 12/26/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    @ObservedObject var router = Router<Path>(root: .C)
    @StateObject var manager = AppManager()

    var body: some View {
        RouterView(router: router) { path in
            switch path {
            case .A: HomePage().environmentObject(manager)
            case .B: SearchPage().environmentObject(manager)
            case .C: DetailPage().environmentObject(manager)
            }
        }
    }
}

enum Path {
    case A
    case B
    case C
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
