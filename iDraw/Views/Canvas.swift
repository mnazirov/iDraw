//
//  Canvas.swift
//  iDraw
//
//  Created by Marat on 23.09.2021.
//

import UIKit

class Canvas: UIView {
    
    private var lines: [CGPoint] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for (i, p) in lines.enumerated() {
            if i == 0 {
                context.move(to: p)
            } else {
                context.addLine(to: p)
            }
        }
        
        context.strokePath()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let point = touches.first?.location(in: nil) else { return }
        lines.append(point)
        
        setNeedsDisplay()
    }
}
