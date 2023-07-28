//
//  ProgrammaticScrollExampleView.swift
//  LayoutProject
//
//  Created by Karin Prater on 20.06.22.
//

import SwiftUI

struct ProgrammaticScrollExampleView: View {
    
    let natureInspiration = NatureInspiration.examples()
    
    @Namespace var topID
    @Namespace var bottomID
    
    @State private var selectedInspirationId: UUID? = nil
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .buttonStyle(.bordered)
                .id(topID)
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(natureInspiration) { inspiration in
                        InspirationRowView(inspiration: inspiration)
                            .foregroundColor(forgroundColor(for: inspiration))
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(color(for: inspiration)))
                            .id(inspiration.id)
                            .onTapGesture {
                                tapped(on: inspiration)
                            }
                        
                        Divider()
                    }
                }
                .padding()
                
                
                
                if selectedInspirationId != nil {
                    VStack {
                        // default scrolling behaviour
                        Button("Scroll to top") {
                            withAnimation {
                                proxy.scrollTo(selectedInspirationId, anchor: .top)
                            }
                        }
                        Button("Scroll to center") {
                            withAnimation {
                                proxy.scrollTo(selectedInspirationId, anchor: .center)
                            }
                        }
                        Button("Scroll to bottom") {
                            withAnimation {
                                proxy.scrollTo(selectedInspirationId, anchor: .bottom)
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                }
                
                Button("Top") {
                    withAnimation {
                        proxy.scrollTo(topID)
                    }
                }
                .buttonStyle(.bordered)
                .id(bottomID)
                
                
                
            }
            
        }
        .overlay {
            VStack(spacing: 0) {
                Rectangle().stroke(Color.pink, lineWidth: 2)
                Rectangle().stroke(Color.pink, lineWidth: 2)
            }
        }
        
    }
    
    func color(for inspiration: NatureInspiration) -> Color {
        inspiration.id == selectedInspirationId ? Color.gray : Color.clear
    }
    
    func forgroundColor(for inspiration: NatureInspiration) -> Color {
        inspiration.id == selectedInspirationId ? Color.white : Color.black
    }
    
    func tapped(on inspiration: NatureInspiration) {
        if selectedInspirationId == inspiration.id {
            selectedInspirationId = nil
        } else {
            selectedInspirationId = inspiration.id
        }
    }
}


struct ProgrammaticScrollExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgrammaticScrollExampleView()
        
        NavigationView(content: {
            ProgrammaticScrollExampleView()
                .navigationTitle("NavigationView")
        })
    }
}
