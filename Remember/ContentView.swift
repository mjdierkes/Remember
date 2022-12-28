//
//  SwiftUIView.swift
//  Remember
//
//  Created by Mason Dierkes on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var router = Router<Path>(root: .DetailPage)
    @StateObject var manager = AppManager()

    var body: some View {
        RouterView(router: router) { path in
            switch path {
            case .HomePage: HomePage().environmentObject(manager)
            case .SearchPage: SearchPage().environmentObject(manager)
            case .DetailPage: DetailPage().environmentObject(manager)
            }
        }
    }
}

enum Path {
    case HomePage
    case SearchPage
    case DetailPage
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
