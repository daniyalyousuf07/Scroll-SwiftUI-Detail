//
//  InspirationListView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 06.02.23.
//

import SwiftUI

struct InspirationListView: View {
    @State private var inspiration = NatureInspiration.examples()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(inspiration) { inspiration in
                    InspirationRowView(inspiration: inspiration)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            }
            .listStyle(.plain)
            
            .navigationTitle("Inspirations")
        }
    }
}

struct InspirationListView_Previews: PreviewProvider {
    static var previews: some View {
        InspirationListView()
    }
}
