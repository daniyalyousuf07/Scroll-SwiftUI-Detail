//
//  ContentView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inspiration = NatureInspiration.examples()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10, pinnedViews: .sectionHeaders) {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(inspiration) { inspiration in
                                InspirationCardView(inspiration: inspiration)
                            }
                        }
                        .padding()
                    }
                    .frame(height: 150)
                    
                    Section {
                        InspirationGridSectionView()
                        
                    } header: {
                        Text("Second Section")
                            .modifier(SectionHeaderStyling())
                            
                    }
                    
                    Section {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(inspiration) { inspiration in
                                InspirationRowView(inspiration: inspiration)
                            }
                            .padding(.horizontal)
                        }
                    } header: {
                        Text("Third Section")
                            .modifier(SectionHeaderStyling())
                    }
                    
                }
            }
            .navigationTitle("Inspirations")
        }
    }
}

struct SectionHeaderStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.white
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

