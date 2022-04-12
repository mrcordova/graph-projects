//
//  SectorView.swift
//  chart
//
//  Created by Noah Cordova on 4/2/22.
//

import SwiftUI

struct SectorView: View {
    var startAngle: Angle
    var endAngle: Angle
    var value: Double
    var color: Color
    var labelOffset: Double
    var labelSize: Double = 20.0
    
    var labelPoint: CGPoint {
        let midAngleRad = startAngle.radians + (endAngle.radians - startAngle.radians)/2.0
        return CGPoint(x: labelOffset * cos(midAngleRad), y: labelOffset * sin(midAngleRad))
    }
    
    var body: some View {
        VStack {
          Sector(startAngle: startAngle, endAngle: endAngle)
                .fill(color)
                .overlay(Text(value != 0 ? "\(value, specifier: "%.1f")%" : "")
                    .font(.system(size: CGFloat(labelSize), weight: .bold, design: .rounded))
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color(.black).opacity(value != 0 ? 0.3: 0))
                    .cornerRadius(5)
                    .offset(x: labelPoint.x,
                            y: labelPoint.y
                           ))
                    
        }
    }
}

struct SectorView_Previews: PreviewProvider {
    static var previews: some View {
        SectorView(startAngle: Angle(degrees: -65), endAngle: Angle(degrees: -15), value: 35, color: Color.red, labelOffset: 20.0)
    }
}
