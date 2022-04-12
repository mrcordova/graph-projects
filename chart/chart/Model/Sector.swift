//
//  Sector.swift
//  chart
//
//  Created by Noah Cordova on 4/2/22.
//

import Foundation
import SwiftUI

struct Sector: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect ) -> Path {
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
        let r = Double(min(rect.width, rect.height)) * 0.9 / 2.0
        var path = Path()
        path.move(to: c)
        path.addArc(center: c, radius: CGFloat(r), startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}
