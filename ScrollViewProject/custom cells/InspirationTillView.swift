//
//  InspirationTillView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 01.02.23.
//

import SwiftUI

struct InspirationTillView: View {
    let inspiration: NatureInspiration
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        Image(inspiration.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: 5)
    }
}

struct InspirationTillView_Previews: PreviewProvider {
    static var previews: some View {
        InspirationTillView(inspiration: NatureInspiration.example1(),
                            size: 300,
                            cornerRadius: 15)
    }
}
