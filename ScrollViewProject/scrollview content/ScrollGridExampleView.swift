//
//  ScrollGridExampleView.swift
//  ScrollViewProject
//
//  Created by Karin Prater on 02.02.23.
//


import SwiftUI

struct ScrollGridExampleView: View {

    let columns = [GridItem(.adaptive(minimum: 75.00), spacing: 10)]

      var body: some View {
           ScrollView {
               LazyVGrid(columns: columns) {
                   ForEach(0x1f600...0x1f679, id: \.self) { value in
                       GroupBox {
                           Text(emoji(value))
                               .font(.largeTitle)
                               .fixedSize()
                           Text(String(format: "%x", value))
                               .fixedSize()
                           
                       }
                   }
               }
               .padding()
           }
      }

      private func emoji(_ value: Int) -> String {
          guard let scalar = UnicodeScalar(value) else { return "?" }
          return String(Character(scalar))
      }
    
    

}











struct ScrollGridExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollGridExampleView()
    }
}
