//
//  Photo.swift
//  ScrollViewProject
//
//  Created by Daniyal Yousuf on 2023-07-28.
//

import Foundation

struct Photo: Identifiable {
    let id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
