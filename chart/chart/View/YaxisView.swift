//
//  YaxisView.swift
//  chart
//
//  Created by Noah Cordova on 4/14/22.
//

import SwiftUI

struct YaxisView: View {
    var ticks: [Int]
    var scaleFactor: Double
    
    var body: some View {
        GeometryReader {gr in
            let fullChartHeight = gr.size.height
            ZStack {
                //y-axis line
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 1)
                    .offset(x: (gr.size.width/2.0) - 1, y: 1)
                
                //Tick Marks
                ForEach(ticks, id: \.self) {t in
                    HStack {
                        Spacer()
                        Text("\(t)")
                            .font(.footnote)
                        Rectangle()
                            .frame(width: 10, height: 1)
                    }
                    .offset(y: (fullChartHeight/2.0) - (CGFloat(t) * CGFloat(scaleFactor)))
                }
            }
        }
    }
}

struct YaxisView_Previews: PreviewProvider {
    static var previews: some View {
        YaxisView(ticks: [10,23,45,36,35], scaleFactor: 5)
    }
}
