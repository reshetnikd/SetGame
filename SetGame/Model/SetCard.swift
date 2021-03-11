//
//  SetCard.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import Foundation

struct SetCard: Equatable, Identifiable {
    let id: UUID = UUID()
    let number: Number
    let shape: Shape
    let shading: Shading
    let color: Color
    var status: Status
    
    enum Status: String {
        case unselected
        case selected
        case matched
        case mismatched
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all: [Number] = [Number.one, Number.two, Number.three]
    }
    
    enum Shape: String {
        case diamond
        case squiggle
        case oval
        
        static var all: [Shape] = [Shape.diamond, Shape.squiggle, Shape.oval]
    }
    
    enum Shading: String {
        case striped
        case solid
        case outlined
        
        static var all: [Shading] = [Shading.striped, Shading.solid, Shading.outlined]
    }
    
    enum Color: String {
        case red
        case green
        case purple
        
        static var all: [Color] = [Color.red, Color.green, Color.purple]
    }
}
