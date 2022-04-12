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
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                ForEach(filteredData.keys.sorted(), id: \.self) { key in
                    Text("\(key)")
                        .font(.system(.title)).bold()
                    ChartView(data: [key: data[key] ?? ["passed": 0]])
                    Text("\(String(describing: data[key] ?? ["Passed": 0]))")
                        .overlay(Divider(), alignment: .bottom)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ChartScrollView_Previews: PreviewProvider {
    @State static var filteredDict = ["test": [":type": 0]]
    static var previews: some View {
        ChartScrollView(filteredData: $filteredDict, data: [:])
    }
}
