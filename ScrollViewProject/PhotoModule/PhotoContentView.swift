//
//  PhotoContentView.swift
//  ScrollViewProject
//
//  Created by Daniyal Yousuf on 2023-07-28.
//

import SwiftUI

struct PhotoContentView: View {
    @State var gridLayout: [GridItem] = [ GridItem() ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(samplePhotos.indices, id: \.self) { index in
                        Image(samplePhotos[index].name)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: gridLayout.count == 1 ? 200 : 100)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    }
                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                    ForEach(samplePhotos) { photo in
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .cornerRadius(10)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                .animation(.easeIn, value: gridLayout.count)
            }

            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                               self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                           } label: {
                               Image(systemName: "square.grid.2x2")
                                   .font(.title)
                                   .foregroundColor(.primary)
                           }
                }
            }
        }
    }
}

struct PhotoContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoContentView()
    }
}
