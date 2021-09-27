//
//  Canvas.swift
//  iDraw
//
//  Created by Marat on 23.09.2021.
//

import UIKit

class Canvas: UIView {
    
    private var lines: [Line] = []
    private var color = UIColor.black
    private var lineWidth: Float = 1
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { line in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.width))
            
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(width: lineWidth, color: color, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastElement = lines.popLast() else { return }
        lastElement.points.append(point)
        
        lines.append(lastElement)
        
        setNeedsDisplay()
    }
    
    func undoLine() {
        if !lines.isEmpty {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
    func cleanLines() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func discolorationLine(color: UIColor) {
        self.color = color
    }
    
    func changeLineWidth(width: Float) {
        lineWidth = width
    }
}
