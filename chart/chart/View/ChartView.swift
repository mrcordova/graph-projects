//
//  ChartView.swift
//  chart
//
//  Created by Noah Cordova on 4/8/22.
//

import SwiftUI


struct ChartView: View {
    @EnvironmentObject var currentChart: CurrentChart
    @State var values: [Double]
    @State var colorDict: [Color]
    @State var pieColorDict: [Color]
    let data: [String: [String: Int]]
    let searchLabel: String
   
    init(data: [String: [String:Int]], searchLabel: String) {
        self.data = data
        self.values = setValues(with: data)
        self.colorDict = [Color.green, Color.red]
        self.searchLabel = searchLabel
        self.pieColorDict = colorOrder(with: data)
        
       
    }
    var body: some View {
        VStack {
            VStack{
                switch currentChart.selection {
                case "Pie Chart":
                    PieChaetView(values: convertToPercentage(values), labelOffset: 70.0, colorArry: pieColorDict)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300, alignment: .center)
                        .padding()
                case "Bar Chart":
                    BarChartView(values: values, colorArry: pieColorDict)
                        .frame(maxWidth: 200)
                        .frame(height: 300, alignment: .center)
                        .padding()
                default:
                    PieChaetView(values: convertToPercentage(values), labelOffset: 70.0, colorArry: pieColorDict)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300, alignment: .center)
                        .padding()
                       
                }
                HStack(alignment: .center){
                    ForEach(0..<values.count, id:\.self) {i in
                        HStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(colorDict[i])
                                .frame(width: 20, height: 20)
                            Text("\(colorDict[i] == Color.red ? "Failed": "Passed"): \(Int(values[i]))")
                        }
                        
                    }
                    .padding([.bottom])
                }
                .overlay(Divider(), alignment: .bottom)
            }
                        
        }
        
           
        }
    }


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(data: ["test":["type": 0]], menuTitle: "Tile", searchLabel: "HOLDER")
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

func colorOrder(with data: [String: [String:Int]]) -> [Color] {
    var tempArry: [String:Double] = ["Passed":0, "Failed":0]
  if (data.index(forKey: "15") != nil) {
      return [Color.green, Color.red]
  }
  _ = data.mapValues{
         tempArry["Passed"]? += Double($0["Passed"] ?? 0)
         tempArry["Failed"]? += Double($0["Failed"] ?? 0)
     }

    if tempArry["Passed"] ?? 0 < tempArry["Failed"] ?? 0 {
        return [Color.red, Color.green]
    }
    return [Color.green, Color.red]
}
