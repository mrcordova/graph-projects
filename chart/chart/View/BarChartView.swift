//
//  BarChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/13/22.
//

import SwiftUI

struct BarChartView: View {
    var values: [Double]
    var colorArry: [Color]
    
    var body: some View {
        GeometryReader { gr in
            let fullBarHeight = gr.size.height * 0.90
            let maxValue = values.max()
            let totalVal = values.reduce(0,+)
            
            VStack{
                HStack(spacing: 0){
                    ForEach(Array(values.enumerated()), id: \.element){ i, val in
                        BarView(
                            value: val,
                            maxValue: maxValue ?? 0,
                            fullBarHeight: Double(fullBarHeight),
                            totalValue: totalVal,
                            color: i == 0 ? Color.green : Color.red
                        )
                        
                    }
                }
                .padding(4)
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(values: [95,5], colorArry: [Color.green, Color.red])
    }
}
