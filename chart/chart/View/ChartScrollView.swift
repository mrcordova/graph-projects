//
//  ChartScrollView.swift
//  chart
//
//  Created by Noah Cordova on 4/11/22.
//

import SwiftUI

struct ChartScrollView: View {
    @Binding var filteredData: [String: [String:Int]]
    let data: [String: [String: Int]]
    let searchLabel: String
    let col = [
        GridItem(.adaptive(minimum: 350)),
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: col) {
                
                ForEach(filteredData.keys.sorted(), id: \.self) { key in
                    VStack(alignment: .center, spacing: 20){
                        Text("\(searchLabel): \(key)")
                            .font(.system(.title)).bold()
                            .padding([.top])
                        ChartView(data: [key: data[key] ?? ["passed": 0]], searchLabel: searchLabel)
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(Divider(), alignment: .top)
    }
}

struct ChartScrollView_Previews: PreviewProvider {
    @State static var filteredDict = ["test": [":type": 0]]
    static var previews: some View {
        ChartScrollView(filteredData: $filteredDict, data: ["tese":["trrt":0]], searchLabel: "HOLDER")
    }
}
