//
//  SearchFilters.swift
//  Remember
//
//  Created by Mason Dierkes on 12/27/22.
//

import SwiftUI

struct SearchFilters: View {
    var body: some View {
        HStack {
            ForEach(Filter.allCases, id: \.rawValue) { item in
               FilterView(item: item)
            }
            .background(
                .regularMaterial,
                                in: Capsule()
                            )
        }
    }
}

struct FilterView: View {
    let item: Filter
    @State private var selected = false
    var body: some View {
        Button {
            selected.toggle()
        } label: {
            Text(item.rawValue)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
        }
        .tint(selected ? .black :. white)
        .frame(width: 80)
    }
}

enum Filter: String, CaseIterable {
    case title = "Title"
    case author = "Author"
    case text = "Text"
    case subject = "Subject"
}

struct SearchFilters_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilters()
    }
}
