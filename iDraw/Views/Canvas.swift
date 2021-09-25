//
//  Canvas.swift
//  iDraw
//
//  Created by Marat on 23.09.2021.
//

import UIKit

class Canvas: UIView {
    
    private var lines: [[CGPoint]] = [[]]
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { line in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastElement = lines.popLast() else { return }
        lastElement.append(point)
        
        lines.append(lastElement)
        
        setNeedsDisplay()
    }
    
    func undoLine() {
        lines.removeLast()
        setNeedsDisplay()
    }
    
    func cleanLines() {
        lines.removeAll()
        setNeedsDisplay()
    }
}
