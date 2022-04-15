//
//  XaxisView.swift
//  chart
//
//  Created by Noah Cordova on 4/14/22.
//

import SwiftUI

struct XaxisView: View {
    var data: [Double]
    
    var body: some View {
        GeometryReader {gr in
//            let labelWidth = (gr.size.width * 0.9) / CGFloat(data.count)
//            let padWidth = (gr.size.width * 0.05) / CGFloat(data.count)
//            let labelHeight = gr.size.height
//            let tickHeight = gr.size.height * 0.12
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 1)
                    .offset(x: 1, y: -(gr.size.height/2.0))
//                HStack(spacing: 0) {
//                    ForEach(data.indices, id: \.self) { i in
//                        ZStack {
//                            VStack{
//                                Rectangle()
//                                    .frame(width: 1, height: tickHeight)
//                                Spacer()
//                            }
////                            Text("")
////                                .font(.footnote)
////                                .frame(width: labelWidth, height: labelHeight)
//                        }
//
//                    }
//                    .padding(.horizontal, padWidth)
//                }
            }
        }
    }
}

struct XaxisView_Previews: PreviewProvider {
    static var previews: some View {
        XaxisView(data: [34.4,54.4])
    }
}
    
