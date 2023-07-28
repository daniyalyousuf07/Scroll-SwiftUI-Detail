//
//  InspirationRowView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct InspirationRowView: View {
    
    let inspiration: NatureInspiration
    //
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            Image(inspiration.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading, spacing: 5) {
                Text(inspiration.name)
                
                Text(inspiration.description)
                    .font(.caption)
            }
            .padding(.trailing, 10)
            .padding(.vertical, 5)
        }
    }
}

struct InspirationRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            InspirationRowView(inspiration: NatureInspiration.example1())
            InspirationRowView(inspiration: NatureInspiration.example2())
        }
        .padding()
    }
}
