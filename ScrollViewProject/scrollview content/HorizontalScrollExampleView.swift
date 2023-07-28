//
//  HorizontalScrollExampleView.swift
//  LayoutProject
//
//  Created by Karin Prater on 20.06.22.
//

import SwiftUI


struct HorizontalScrollExampleView: View {

    let natureInspiration = NatureInspiration.examples()
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(natureInspiration) { inspiration in
                    InspirationCardView(inspiration: inspiration)
                }
            }
            .padding()
        }
        .frame(height: 200)
    }
}









struct HorizontalScrollExampleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollExampleView()
    }
}
