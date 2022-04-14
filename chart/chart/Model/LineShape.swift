//
//  LineShape.swift
//  chart
//
//  Created by Noah Cordova on 4/14/22.
//

import Foundation
import SwiftUI

struct LineShape: Shape {
    var yValues: [Double]
    var scaleFactor: Double
    
    func path(in rect: CGRect) -> Path {
        let xIncrement = (rect.width / (CGFloat(yValues.count) - 1))
        var xValue = xIncrement * 0.5
//        let factor = rect.height / CGFloat(yValues.max() ?? 1.0)
        var path = Path()
        path.move(to: CGPoint(x: 0.0, y: (rect.height - (yValues[0] * scaleFactor))))
        
        for i in 1..<yValues.count {
            xValue += xIncrement
            let pt = CGPoint(x: (Double(i) * Double(xIncrement)), y: (rect.height - (yValues[i] * scaleFactor)))
            path.addLine(to: pt)
        }
        return path
    }
    
    
}
