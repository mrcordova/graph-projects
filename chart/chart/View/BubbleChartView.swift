//
//  BubbleChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/15/22.
//

import SwiftUI

struct BubbleChartView: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let colorArry: [Color]
    private let totalRadius: Double
    let radius: CGFloat
    let pi = Double.pi
    init(value: Double, maxValue: Double, colorArry: [Color], backgroundEnabled: Bool = true){
        self.maxValue = maxValue
        self.value = value
        self.foregroundColor = Color.red
        self.backgroundColor = Color.green
        self.radius = ((value+maxValue)*100)/2
        self.totalRadius = maxValue/2
        self.colorArry = colorArry
        self.backgroundEnabled = backgroundEnabled
    }
    
    var body: some View {
       
        ZStack {
            if self.backgroundEnabled {
                VStack {
//                    Sector(startAngle: Angle(degrees:0), endAngle: Angle(degrees: 360))
//                        .padding(4)
//                        .foregroundColor(.green)
//                        .cornerRadius(5)
//                        .frame(width: ((maxValue)/2)*2, height: (maxValue/2)*2)
                    Circle()
                        .foregroundColor(.green)
                }
            }
            
            VStack {
                Circle()
                    .foregroundColor(.red)
                    .frame(width: pi * radius * radius, height: pi * radius * radius)
//                Sector(startAngle: Angle(degrees:0), endAngle: Angle(degrees: 360))
//                    .padding(4)
//                    .foregroundColor(.red)
//                    .cornerRadius(5)
//                    .frame(width: (value/2)*2, height: (value/2)*2)
                        
            }

        }
        .frame(height: 100)
        .padding(30)
    }
}

struct BubbleChartView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleChartView(value: 5, maxValue: 95, colorArry: [Color.red, Color.green])
    }
}
