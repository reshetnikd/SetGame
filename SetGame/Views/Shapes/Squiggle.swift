//
//  Squiggle.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Squiggle: Shape {
    
    // MARK: - Drawing Constants
    
    private let widthDeviation: CGFloat = 0.1
    private let heightDeviation: CGFloat = 0.2
    
    func path(in rect: CGRect) -> Path {
        var squiggle: Path = Path()
        squiggle.move(to: CGPoint(x: rect.minX, y: rect.midY))
        squiggle.addCurve(to: CGPoint(x: rect.minX + rect.size.width * 1/2, y: rect.minY + rect.size.height/8),
                          control1: CGPoint(x: rect.minX, y: rect.minY),
                          control2: CGPoint(x: rect.minX + rect.size.width * 1/2 - (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 - (rect.size.height * heightDeviation)))
        squiggle.addCurve(to: CGPoint(x: rect.minX + rect.size.width * 4/5, y: rect.minY + rect.size.height/8),
                          control1: CGPoint(x: rect.minX + rect.size.width * 1/2 + (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 + (rect.size.height * heightDeviation)),
                          control2: CGPoint(x: rect.minX + rect.size.width * 4/5 - (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 + (rect.size.height * heightDeviation)))
        squiggle.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY + rect.size.height/2),
                          control1: CGPoint(x: rect.minX + rect.size.width * 4/5 + (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 - (rect.size.height * heightDeviation)),
                          control2: CGPoint(x: rect.maxX, y: rect.minY))
        // Create rotated copy of squiggle path and add it to original path.
        var path: Path = squiggle
        path = path.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        path = path.applying(CGAffineTransform.identity.translatedBy(x: rect.width, y: rect.height))
        squiggle.move(to: CGPoint(x: rect.minX, y: rect.midY))
        squiggle.addPath(path)
        return squiggle
    }
    
}

struct SquiggleShape_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
            .padding()
    }
}
