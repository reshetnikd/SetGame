//
//  Oval.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Oval: Shape {
    
    // MARK: - Drawing Constants
    
    private let startAngel: Angle = Angle(degrees: 0-90)
    private let endAngel: Angle = Angle(degrees: 180-90)
    
    func path(in rect: CGRect) -> Path {
        var oval: Path = Path()
        
        if rect.height > rect.width {
            return Capsule().path(in: rect)
        } else {
            oval.addArc(center: CGPoint(x: rect.midX - rect.width/4, y: rect.midY), radius: rect.height/3, startAngle: startAngel, endAngle: endAngel, clockwise: true)
            oval.addArc(center: CGPoint(x: rect.midX + rect.width/4, y: rect.midY), radius: rect.height/3, startAngle: endAngel, endAngle: startAngel, clockwise: true)
            oval.closeSubpath()
            return oval
        }
    }
}

struct OvalShape_Previews: PreviewProvider {
    static var previews: some View {
        Oval()
            .padding()
    }
}
