//
//  PinnedScrollableExampleView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct PinnedScrollableExampleView: View {
    
    let firstInspiration = NatureInspiration.examples()[0...2]
    let secondInspiration = NatureInspiration.examples()[3...5]
    let thirdInspiration = NatureInspiration.examples()[6...8]
    
    var body: some View {
        NavigationView {

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10, pinnedViews: .sectionHeaders) {
                Section {
                    ForEach(firstInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                    }
                } header: {
                    SectionHeaderView(title: "First Section")
                }

                Section {
                    ForEach(secondInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                    }
                } header: {
                    SectionHeaderView(title: "Second Section")
                }
               
                Section {
                    ForEach(thirdInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                    }
                } header: {
                    SectionHeaderView(title: "Third Section")
                }
            }
            .padding()
        }
        .navigationTitle("Inspirations")
        }
    }
}

struct SectionHeaderView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.vertical, 10).padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.edgesIgnoringSafeArea(.top).shadow(radius: 5))
            
    }
}

struct PinnedScrollableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedScrollableExampleView()
    }
}
