//
//  ScrollFixedTextView.swift
//  LayoutProject
//
//  Created by Karin Prater on 01.07.22.
//

import SwiftUI

struct ScrollFixedTextView: View {
    let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eget mi quis tortor efficitur porta. Vivamus quis vehicula ligula. Aliquam finibus congue risus nec dignissim. Nunc vel congue massa. Cras ullamcorper risus urna, vel varius turpis lobortis et. Fusce malesuada tincidunt tincidunt. Nam id felis ac ante vestibulum posuere quis a diam. Integer justo dolor, pellentesque bibendum justo sit amet, gravida dapibus turpis. \n Proin pellentesque accumsan purus quis eleifend. Integer justo dolor, pellentesque bibendum justo sit amet, gravida dapibus turpis. Proin pellentesque accumsan purus quis eleifend."
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image("minime")
                    .resizable()
                    .scaledToFit()
                
                Text("Mini-me")
                    .font(.largeTitle)
                
                Text(description)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
    }
}

struct ScrollFixedBackgroundView: View {
    let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eget mi quis tortor efficitur porta. Vivamus quis vehicula ligula. Aliquam finibus congue risus nec dignissim. Nunc vel congue massa. Cras ullamcorper risus urna, vel varius turpis lobortis et. Fusce malesuada tincidunt tincidunt. Nam id felis ac ante vestibulum posuere quis a diam. Integer justo dolor, pellentesque bibendum justo sit amet, gravida dapibus turpis. \n Proin pellentesque accumsan purus quis eleifend. Integer justo dolor, pellentesque bibendum justo sit amet, gravida dapibus turpis. Proin pellentesque accumsan purus quis eleifend."
    
    var body: some View {
       
        ScrollView {
            
            Spacer()
                .frame(height: 250)
            VStack(alignment: .leading, spacing: 20) {
                Text("Mini-me")
                    .font(.largeTitle)
                
                Text(description)
                    .multilineTextAlignment(.leading)
                
                Text(description)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8))
            .padding()
            
        }
       
        .background(
            Image("minime")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .frame(maxHeight: .infinity, alignment: .top)
        )
        .edgesIgnoringSafeArea(.top)
    }
}

struct ScrollFixedTextView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollFixedTextView()
        
        ScrollFixedBackgroundView()
    }
}
