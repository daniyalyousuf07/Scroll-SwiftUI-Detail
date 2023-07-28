//
//  DisableScrollExampleView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

@available(iOS 16.0, *)
struct DisableScrollExampleView: View {
    
    @State private var isScrollDisabled = false
    let natureInspiration = NatureInspiration.examples()
    
    var body: some View {
        ScrollView {
            Toggle(isScrollDisabled ? "no scrolling" : "scrolling works",
                   isOn: $isScrollDisabled)
            .padding()
            Divider()
            
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(natureInspiration) { inspiration in
                    InspirationRowView(inspiration: inspiration)
                }
            }
            .padding()
        }
        .scrollDisabled(isScrollDisabled)
    }
}

@available(iOS 16.0, *)
struct DisableScrollExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DisableScrollExampleView()
    }
}
