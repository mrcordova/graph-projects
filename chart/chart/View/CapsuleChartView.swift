//
//  CapsuleChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/15/22.
//

import SwiftUI

struct CapsuleChartView: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let colorArry: [Color]
    private let total: Double
    init(value: Double,
         maxValue: Double,
         colorArry: [Color],
         backgroundEnabled: Bool = true) {
        self.value = value
        self.maxValue = maxValue
        self.backgroundEnabled = backgroundEnabled
        self.colorArry = colorArry
        self.total = maxValue + value
        self.backgroundColor = colorArry[0]
        self.foregroundColor = colorArry[1]
        
    }
    var body: some View {
        ZStack {
            GeometryReader{ gr in
                if self.backgroundEnabled {
                    ZStack{
                        Capsule()
                            .foregroundColor(self.backgroundColor)
                        Text("\(convertSingleValue(num:maxValue, total: total), specifier: "%.1f")%")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            
                    }
                    
                }
                Capsule()
                    .frame(width: self.progress(value: self.value, totalValue: self.total, width: gr.size.width))
                    .foregroundColor(self.foregroundColor)
                Text("\(convertSingleValue(num:value, total: total), specifier: "%.1f")%")
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding([.horizontal])
                
            }
        }
        .frame(height: 25)
        .padding(30)
    }
    private func progress(value: Double, totalValue: Double, width: CGFloat) -> CGFloat {
        let percentage = value/totalValue
        return width * CGFloat(percentage)
    }
}

struct CapsuleChartView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleChartView(value: 4, maxValue: 14, colorArry: [Color.green, Color.red])
    }
}


