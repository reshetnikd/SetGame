//
//  Stripes.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Stripes: Shape {
    func path(in rect: CGRect) -> Path {
        let stripes: UIBezierPath = UIBezierPath()
        
        for x in stride(from: 0, to: rect.width, by: 6){
            stripes.move(to: CGPoint(x: rect.minX + x, y: rect.minY))
            stripes.addLine(to: CGPoint(x: rect.minX + x, y: rect.maxY))
        }
        
        return Path(stripes.cgPath)
    }
}

struct Stripes_Previews: PreviewProvider {
    static var previews: some View {
        Stripes()
            .stroke()
    }
}
