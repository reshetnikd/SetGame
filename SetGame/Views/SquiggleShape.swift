//
//  SquiggleShape.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct SquiggleShape: Shape {
    
    // MARK: - Drawing Constants
    
    private let ident: CGFloat = 2.0
    private let widthParameter: CGFloat = 0.6
    private let heightParameter: CGFloat = 0.25
    private let widthDeviation: CGFloat = 0.1
    private let heightDeviation: CGFloat = 0.2
    
    func path(in rect: CGRect) -> Path {
        let squiggle: UIBezierPath = UIBezierPath()
        squiggle.move(to: CGPoint(x: rect.minX, y: rect.midY))
        squiggle.addCurve(to: CGPoint(x: rect.minX + rect.size.width * 1/2, y: rect.minY + rect.size.height/8),
                          controlPoint1: CGPoint(x: rect.minX, y: rect.minY),
                          controlPoint2: CGPoint(x: rect.minX + rect.size.width * 1/2 - (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 - (rect.size.height * heightDeviation)))
        squiggle.addCurve(to: CGPoint(x: rect.minX + rect.size.width * 4/5, y: rect.minY + rect.size.height/8),
                          controlPoint1: CGPoint(x: rect.minX + rect.size.width * 1/2 + (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 + (rect.size.height * heightDeviation)),
                          controlPoint2: CGPoint(x: rect.minX + rect.size.width * 4/5 - (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 + (rect.size.height * heightDeviation)))
        squiggle.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY + rect.size.height/2),
                          controlPoint1: CGPoint(x: rect.minX + rect.size.width * 4/5 + (rect.size.width * widthDeviation), y: rect.minY + rect.size.height/8 - (rect.size.height * heightDeviation)),
                          controlPoint2: CGPoint(x: rect.maxX, y: rect.minY))
        // Create rotated copy of squiggle path and add it to original path.
        let path: UIBezierPath = UIBezierPath(cgPath: squiggle.cgPath)
        path.apply(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        path.apply(CGAffineTransform.identity.translatedBy(x: rect.width, y: rect.height))
        squiggle.move(to: CGPoint(x: rect.minX, y: rect.midY))
        squiggle.append(path)
        return Path(squiggle.cgPath)
    }
    
}

struct SquiggleShape_Previews: PreviewProvider {
    static var previews: some View {
        SquiggleShape()
    }
}
