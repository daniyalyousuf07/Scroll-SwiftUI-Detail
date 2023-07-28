//
//  PagingScrollChallengeView.swift
//  LayoutProject
//
//  Created by Karin Prater on 20.06.22.
//

import SwiftUI
import Introspect

struct PagingScrollView: View {
    
    let natureInspiration = NatureInspiration.examples()
    let padding: CGFloat = 10
    let rows = [
        GridItem(.fixed(100), spacing: 5),
        GridItem(.fixed(100), spacing: 5),
        GridItem(.fixed(100), spacing: 5)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .top, spacing: 0) {
                    ForEach(natureInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                            .frame(width: geometry.size.width - (2 * padding),
                                   alignment: .leading)
                            .padding(.horizontal, padding)
                    }
                }
            }
        }
        .introspectScrollView { view in
            view.isPagingEnabled = true
        }
    }
}



struct PagingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PagingScrollView()
    }
}
