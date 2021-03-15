//
//  Oval.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let oval: UIBezierPath = UIBezierPath()
        oval.addArc(withCenter: CGPoint(x: rect.midX - rect.size.width/4, y: rect.midY), radius: rect.height/2, startAngle: CGFloat.pi/2, endAngle: (3 * CGFloat.pi)/2, clockwise: true)
        oval.addLine(to: CGPoint(x: rect.midX + rect.size.width/4, y: rect.minY))
        oval.addArc(withCenter: CGPoint(x: rect.midX + rect.size.width/4, y: rect.midY), radius: rect.height/2, startAngle: (3 * CGFloat.pi)/2, endAngle: CGFloat.pi/2, clockwise: true)
        oval.close()
        return Path(oval.cgPath)
    }
}

struct OvalShape_Previews: PreviewProvider {
    static var previews: some View {
        Oval()
    }
}
