//
//  PieChaetView.swift
//  chart
//
//  Created by Noah Cordova on 4/2/22.
//

import SwiftUI

struct PieChaetView: View {
    var values: [Double]
    var labelOffset: Double
    var labelSize: Double = 20.0
    var colorArry: [Color]
    let angleOffset = 90.0
    
    var body: some View {
        let total = values.reduce(0, +)
        let sortedSizes = values.sorted(by: >)
        let angles = values.sorted(by: >).map {$0 * 360.0 / total}
        var sum = 0.0
        let runningAngles = angles.map{(sum += Double($0), sum).1}
        ZStack {
            ForEach(0 ..< runningAngles.count, id: \.self){ i in
                let startAngle = i==0 ? 0.0 : runningAngles[i-1]
                
                SectorView(
                    startAngle: Angle(degrees: startAngle - angleOffset),
                    endAngle: Angle(degrees: runningAngles[i] - angleOffset),
                    value: sortedSizes[i],
                    color: colorArry[i],
                    labelOffset: labelOffset,
                    labelSize: labelSize
                    )
            }
        }
        
    }
}

let test = [34.6, 25.3]
struct PieChaetView_Previews: PreviewProvider {
    static var previews: some View {
        PieChaetView(values: test, labelOffset: 70.0, colorArry: [Color.red, Color.green])
    }
}
