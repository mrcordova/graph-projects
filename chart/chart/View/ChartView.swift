//
//  ChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/8/22.
//

import SwiftUI


struct ChartView: View {
    let data: [String: [String: Int]]
    @State var values: [Double]
    @State var colorDict: [Color]
   
    init(data: [String: [String:Int]]) {
        self.data = data
        self.values = setValues(with: data)
        self.colorDict = [Color.green, Color.red]
       
    }
    var body: some View {
        VStack {
//            HStack {
//            Text("Filter")
//                    .padding(.horizontal)
//                    .overlay(Divider(), alignment: .trailing)
//
//            Menu("\(menu)") {
//                ForEach((Int(data.first?.key ?? "failed") == nil) ? data.keys.sorted(): data.keys.sorted(by: {Int($0) ?? 0 < Int($1) ?? 0}) , id: \.self){ key in
//                    Button("\(Int(key) == nil ? key : key + "m")") {
//                        values = [Double(data[key]?["Passed"] ?? 0), Double(data[key]?["Failed"] ?? 0)]
//                        values = values.sorted(by: >)
//                        colorDict[0] = values[0] == Double(data[key]?["Passed"] ?? 0) ? Color.green : Color.red
//                        colorDict[1] = colorDict[0] == Color.green ? Color.red : Color.green
//                        menu = Int(key) == nil ? key : key + "m"
//
//                        }
//                    }
//                }
//            .frame(width: 250, height: 100)
//            }
            VStack{
                PieChaetView(values: convertToPercentage(values), labelOffset: 70.0, colorArry: colorDict)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300, alignment: .center)
            
                .padding()
                HStack(alignment: .center){
                ForEach(0..<values.count, id:\.self) {i in
                    HStack {
                        RoundedRectangle(cornerRadius: 5.0)
                            .fill(colorDict[i])
                            .frame(width: 20, height: 20)
                        Text("\(colorDict[i] == Color.red ? "Failed": "Passed"): \(Int(values[i]))")
                    }
                }
                }
            }
                        
        }
        
           
        }
    }


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(data: ["test":["type": 0]], menuTitle: "Tile")
    }
}

func setValues(with data: [String: [String:Int]]) -> [Double] {
          var tempArry: [Double] = [0,0]
        if (data.index(forKey: "15") != nil) {
            return [Double(data["15"]?["Passed"] ?? 0), Double(data["15"]?["Failed"] ?? 0)]
        }
        _ = data.mapValues{
               tempArry[0] += Double($0["Passed"] ?? 0)
               tempArry[1] += Double($0["Failed"] ?? 0)
           }
    
          return tempArry

}

func convertToPercentage(_ values: [Double]) -> [Double] {
    let totalVal = values.reduce(0,+)
    return [(values[0]/totalVal)*100, (values[1]/totalVal)*100]
}

