//
//  BubbleChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/15/22.
//

import SwiftUI

struct BubbleChartView: View {
    private var value: Double
    private var maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let colorArry: [Color]
    private let total: Double
    var radius: CGFloat
    var maxRad: CGFloat
    let pi = Double.pi
    init(value: Double, maxValue: Double, colorArry: [Color], backgroundEnabled: Bool = true){
        self.maxValue = maxValue
        self.value = value
        self.colorArry = colorArry
        self.foregroundColor = colorArry[1]
        self.backgroundColor = colorArry[0]
        self.radius = 0
        self.total = (value + maxValue)
        self.value = (value/self.total)
        self.maxValue = (maxValue/self.total)
        self.maxRad = ((self.maxValue)/2)
        self.radius = ((self.value)/2)
        self.backgroundEnabled = backgroundEnabled
    }
    
    var body: some View {
       
        ZStack {
            GeometryReader{ gr in
                
                if self.backgroundEnabled {
                    VStack {
                        Spacer()
                        ZStack{
                            Circle()
                                .foregroundColor(self.backgroundColor)
                                .frame(width: ((pi * maxRad * maxRad) * gr.size.width))
                                .frame(maxHeight: (pi * maxRad * maxRad) * gr.size.height, alignment: .bottom)
                            Text("\(maxValue * 100, specifier: "%.1f")%")
                                .frame(alignment: .top)
                                .padding(.horizontal)
                        }
                       
                    }
                    .frame(maxWidth: .infinity)
                }
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(self.foregroundColor)
                            .frame(width:( pi * radius * radius) * gr.size.width)
                            .frame(maxHeight: (pi * radius * radius) * gr.size.height, alignment: .bottom)
                        Text("\(value * 100, specifier: "%.1f")%")
                            .frame(alignment: .center)
                            .padding([.horizontal])
                    }
                    
                }
                .frame(maxWidth: gr.size.width, minHeight: gr.size.height)
            }
            .padding(30)
        }
        
    }
}

struct BubbleChartView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleChartView(value: 2, maxValue: 5, colorArry: [Color.red, Color.green])
    }
}
