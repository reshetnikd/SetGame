//
//  Diamond.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var diamond: Path = Path()
        diamond.move(to: CGPoint(x: rect.midX, y: rect.minY))
        diamond.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        diamond.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        diamond.closeSubpath()
        return diamond
    }
}

struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
            .padding()
    }
}
