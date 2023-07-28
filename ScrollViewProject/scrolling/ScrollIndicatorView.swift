//
//  ScrollIndicatorView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct ScrollIndicatorView: View {
    let natureInspiration = NatureInspiration.examples()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(natureInspiration) { inspiration in
                    InspirationRowView(inspiration: inspiration)
                }
            }
            .padding()
        }
    }
}

struct ScrollIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollIndicatorView()
    }
}
