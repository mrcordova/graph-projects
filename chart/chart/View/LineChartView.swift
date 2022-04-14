//
//  LineChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/14/22.
//

import SwiftUI

struct LineChartView: View {
    var data: [Double]
    var arryDat: [[Double]]
    init(data: [Double]) {
        self.data = data
        self.arryDat = [[0, data[0]], [0, data[1]]]
        print(arryDat)
    }
    var body: some View {
        GeometryReader { gr in
//            let headHeight = gr.size.height * 0.10
            let maxValue = data.max()
            let axisWidth = gr.size.width * 0.15
            let axisHight = gr.size.height * 0.1
            let fullCHartHeight = gr.size.height - axisHight
            
            let tickMarks = AxisParameters.getTicks(top: Int(maxValue ?? 0))
            let scaleFactor = (fullCHartHeight * 0.95) / CGFloat(tickMarks[tickMarks.count - 1])
            
            VStack{
                HStack(spacing:0){
                    YaxisView(ticks: tickMarks, scaleFactor: scaleFactor)
                        .frame(width: axisWidth, height: fullCHartHeight)
                    ZStack {
                        ForEach(arryDat.indices, id:\.self) { i in
                            LineShape(yValues: arryDat[i], scaleFactor: scaleFactor)
                                .stroke(i == 0 ? Color.green : Color.red, lineWidth: 2.0)
                                .frame(height: fullCHartHeight)
        //                        .frame(width: 300, height: 300, alignment: .center)
                        }
                    }
                    
                }
                HStack(spacing:0){
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: axisWidth, height: axisHight)
                    XaxisView(data: data)
                        .frame(height: axisHight)
                }
            }
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(data: [95,5])
    }
}

struct AxisParameters {
    static func getTicks(top:Int) -> [Int] {
        var step = 0
        var high = top
        switch(top) {
        case 0...8:
            step = 1
        case 9...17:
            step = 2
        case 18...50:
            step = 5
        case 51...170:
            step = 10
        case 171...500:
            step = 50
        case 501...1700:
            step = 200
        case 1701...5000:
            step = 500
        case 5001...17000:
            step = 1000
        case 17001...50000:
            step = 5000
        case 50001...170000:
            step = 10000
        case 170001...1000000:
            step = 50000
        default:
            step = 10000
        }
        high = ((top/step) * step) + step + step
        var ticks:[Int] = []
        for i in stride(from: 0, to: high, by: step) {
            ticks.append(i)
        }
        return ticks
    }
}
