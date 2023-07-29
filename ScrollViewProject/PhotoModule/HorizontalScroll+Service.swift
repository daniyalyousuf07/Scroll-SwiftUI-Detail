//
//  HorizontalScroll+Service.swift
//  ScrollViewProject
//
//  Created by Daniyal Yousuf on 2023-07-28.
//

import SwiftUI

struct HorizontalScroll_Service: View {
    let networkService = NetworkService(baseURLString: "https://api.slingacademy.com/public/sample-photos/2.jpeg")
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(1...100, id: \.self) { item in
                        VStack {
                            Text("Image downloading is \(item)")
                            ZStack(alignment: .topTrailing) {
                                let url = URL(string: "https://api.slingacademy.com/public/sample-photos/\(item).jpeg")
                                AsyncImage(url: url) { proxy in
                                    if proxy.image == nil  {
                                        ProgressView()
                                    }
                                    proxy.image?
                                        .resizable()
                                        .cornerRadius(10)
                                }
                                .frame(width: geo.size.width - 10, height: 300)
                                .padding(.horizontal, 5)
                                
                                Text("Image")
                                    .frame(width: 80, height: 40)
                                    .foregroundColor(.white)
                                    .background(.black.opacity(0.6))
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10, x: 0, y: 10)
                                    .offset(x: -10, y: 6)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }
    }
}


struct HorizontalScroll_Service_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScroll_Service()
    }
}
