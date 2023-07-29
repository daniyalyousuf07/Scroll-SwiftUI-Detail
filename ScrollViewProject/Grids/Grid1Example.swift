//
//  Grid1Example.swift
//  ScrollViewProject
//
//  Created by Daniyal Yousuf on 2023-07-28.
//

import SwiftUI
import Introspect

struct Grid1Example: View {
    private var symbols = [
        "keyboard",
        "hifispeaker.fill",
        "printer.fill", "tv.fill",
        "desktopcomputer",
        "headphones",
        "tv.music.note",
        "mic",
        "plus.bubble",
        "video"
    ]
    
    let padding = 5.0
    
    private var colors: [Color] = [
        .yellow,
        .purple,
        .green
    ]
    
    //Vertical
    
    private var gridItemLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)]
    
    private var gridItemLayout1 = [GridItem(.flexible()),
                                   GridItem(.flexible()),
                                   GridItem(.flexible())]
    
    private var gridItemLayout2 = [GridItem(.adaptive(minimum: 50))]
    
    private var gridItemLayout3 = [GridItem(.fixed(100)), GridItem(.fixed(150))]
    
    private var gridItemLayout4 = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 50))]

    //Horizontal
    private var gridItemLayout5 = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 50))]
    
    
    private var gridItemLayout6 = [GridItem(.fixed(50), spacing: 300),
                                                    GridItem(.fixed(50))]
    
    var body: some View {
        TabView {
            layout6()
                .tabItem {
                    Label("Layout", systemImage: "heart")
                }
            layout1()
                .tabItem {
                    Label("Layout1", systemImage: "eraser")
                }
            layout2()
                .tabItem {
                    Label("Layout2", systemImage: "eraser")
                }
            layout3()
                .tabItem {
                    Label("Layout3", systemImage: "eraser")
                }
            layout4()
                .tabItem {
                    Label("Layout4", systemImage: "eraser")
                }
            layout5()
                .tabItem {
                    Label("Layout5", systemImage: "eraser")
                }
            layout6()
                .tabItem {
                    Label("Layout6", systemImage: "eraser")
                }
        }
    }
    
    func  layout()  ->  some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func  layout1()  ->  some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout1, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func  layout2()  ->  some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout2, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func  layout3()  ->  some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout3, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func  layout4()  ->  some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout4, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func layout5() -> some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout5, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func layout6() -> some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayout6, spacing: 0) {
                    ForEach((0...9999), id: \.self) {
                        Image(systemName: symbols[$0 % symbols.count])
                            .font(.system(size: 30))
                            .frame(width: geo.size.width - (2  * padding), height: 300, alignment: .center)
                            .background(colors[$0 % colors.count])
                            .cornerRadius(10)
                            .padding(.horizontal, padding)
                    }
                }
            }
        }
        .introspectScrollView { view in
            view.isPagingEnabled = true
        }
    }
}

struct Grid1Example_Previews: PreviewProvider {
    static var previews: some View {
        Grid1Example()
    }
}
