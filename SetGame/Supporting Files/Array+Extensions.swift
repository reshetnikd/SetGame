//
//  Array+Extensions.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import Foundation
import SwiftUI

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

extension Shape {
    /// Draw strips on a symbol.
    private func stripeSymbol(path: UIBezierPath, in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        path.addClip()
        drawStripes(rect)
        context?.restoreGState()
    }
    
    /// Draw dashed line with width of bounds size height.
    private func drawStripes(_ rect: CGRect) {
        let stripe: UIBezierPath = UIBezierPath()
        let dashes: [CGFloat] = [1.0,4.0]
        stripe.setLineDash(dashes, count: dashes.count, phase: 0.0)
        stripe.lineWidth = rect.size.height
        stripe.lineCapStyle = CGLineCap.butt
        stripe.move(to: CGPoint(x: rect.minX, y: rect.midY))
        stripe.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        stripe.stroke()
    }
}
