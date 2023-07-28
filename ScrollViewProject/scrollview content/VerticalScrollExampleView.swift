//
//  VerticalScrollExampleView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct VerticalScrollExampleView: View {
    
    let natureInspiration = NatureInspiration.examples()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(natureInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                    }
                }
                .padding()
            }
            .navigationTitle("Inspirations")
        }
    }
}

struct VerticalScrollExampleView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalScrollExampleView()
    }
}
