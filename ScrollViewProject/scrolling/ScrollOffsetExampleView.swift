//
//  ScrollOffsetExampleView.swift
//  LayoutProject
//
//  Created by Karin Prater on 18.07.22.
//

import SwiftUI

struct ScrollOffsetExampleView: View {
    
    @State var scrollOffset = CGFloat.zero
    let natureInspiration = NatureInspiration.examples()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    Text( scrollOffset > 100 ? "small detail" : "Large detail")
                        .font(scrollOffset > 100 ? .headline : .title2)
                    
                    if scrollOffset < 50  {
                        Text("more")
                    }
                }
                .animation(.default, value: scrollOffset)
                .frame(height: max(50, 100 - max(scrollOffset, 0)))
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                
                ObservableScrollView(scrollOffset: $scrollOffset) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(natureInspiration) { inspiration in
                            InspirationRowView(inspiration: inspiration)
                        }
                    }
                    .padding()
                }
            }
             .navigationBarTitle("Scroll offset: \(scrollOffset)",
                                 displayMode: .inline)
        }
    }
}



// A ScrollView wrapper that tracks scroll offset changes.
struct ObservableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    
    @Binding var scrollOffset: CGFloat
    let content: () -> Content
    
    init(scrollOffset: Binding<CGFloat>,
         @ViewBuilder content: @escaping () -> Content) {
        _scrollOffset = scrollOffset
        self.content = content
    }
    var body: some View {
        ScrollView {
            content()
                .background(GeometryReader { geo in
                    let offset = -geo.frame(in: .named(scrollSpace)).minY
                    Color.clear
                        .preference(key: ScrollViewOffsetPreferenceKey.self,
                                    value: offset)
                })
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

// Simple preference that observes a CGFloat.
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue = CGFloat.zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}


struct ScrollOffsetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollOffsetExampleView()
    }
}
