//
//  BarView.swift
//  chart
//
//  Created by Noah Cordova on 4/13/22.
//

import SwiftUI

struct BarView: View {
    var value : Double
    var maxValue: Double
    var fullBarHeight: Double
    var totalValue: Double
    // pass color
    var color : Color
    var body: some View {
        let barHeight = (Double(fullBarHeight) / maxValue) * value
        VStack{
            Spacer()
            ZStack{
                VStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(color)
                        .frame(height: CGFloat(barHeight), alignment: .trailing)
                }
                VStack {
                    Spacer()
                    Text("\((value/totalValue)*100, specifier: "%.1F")%")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.horizontal, 4)
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: 95, maxValue: 95, fullBarHeight: 95*0.90, totalValue: 100, color: Color.green)
    }
}
