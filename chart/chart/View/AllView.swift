//
//  AllView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI

struct AllView: View {
    @EnvironmentObject var currentChart: CurrentChart
    
   
    @State private var checked: [[Bool]]
    @State private var showMenu : [Bool]
    @State private var filteredData:[String: [String:Int]]
    @State private var filteredValDict: [String: Bool]
    @State private var filteredDict : [[String: [String: Int]]]
    @State private var filteredResults: [String: [String: Int]]
    @State var colorDict: [Color]
    @State var showChartMenu: Bool = false
    
    let data: [String: [String: Int]]
    var labels: [Int: String]
    let failedTestDetailsArry = chartData.results?[0].testDetails
    let passedTestDetailsArry = chartData.results?[1].testDetails
    let col = [
        GridItem(.adaptive(minimum: 350)),
    ]
    let chartChoices : [String] = ["Pie Chart", "Bar Chart"]
    
    init(data: [String: [String:Int]]){
        
        self.data = data
    
        _checked = State(initialValue: [[Bool]](repeating: Array(repeating: false, count: data.values.count), count: data.keys.count))
        _filteredDict = State(initialValue: [filterForParameters(filteredResults: self.data, searchResult: 3), filterForParameters(filteredResults: self.data, searchResult: 4)])
        
        self.filteredData = data
        self.filteredValDict = [:]
        self.labels =  [0: "Title", 1: "Language"]
        _showMenu = State(initialValue: [Bool](repeating: false, count: labels.count))
        self.filteredResults = ["All":["Passed": 95, "Failed": 5]]
        self.colorDict = [Color.green, Color.red]
    }
    var body: some View {
        VStack{
            HStack {
                Text("Filter")
                    .padding(.horizontal)
                    .overlay(Divider(), alignment: .trailing)
                ForEach(filteredDict.indices, id: \.self) { keyIdx in
                    Button("\(labels[keyIdx] ?? "failed")"){
                        showMenu[keyIdx] = true
                    }
                    .popover(isPresented: $showMenu[keyIdx]) {
                        ScrollView {
                            VStack {
                                ForEach(Array(filteredDict[keyIdx].keys.sorted().enumerated()) , id: \.element){ idx, key in
                                    
                                    Toggle(isOn: $checked[keyIdx][idx]) {
                                        Text("\(key)")
                                    }
                                    .toggleStyle(CheckboxToggleStyle())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onChange(of: checked[keyIdx][idx]) {newValue in
                                        filteredValDict[key] = !(filteredValDict[key] ?? false)
                                        self.filteredData =  data.filter{(filteredValDict[$0.key] ?? false)}
                                        
                                        var tempDict: [String: [String:[String: Int]]] = ["Title": [:], "Language": [:]]
                                        for (key, val) in filteredData {
                                            if val["type"] == 3 {
                                                tempDict["Title"]?["\(key)"] = val
                                            } else if val["type"] == 4 {
                                                tempDict["Language"]?["\(key)"] = val
                                            }
                                        }
                                        let titleDict = tempDict["Title"]
                                        let langDict = tempDict["Language"]
                                        
                                        var temp: [String: [String: Int]] = [:]
                                        
                                        for passedTest in passedTestDetailsArry ?? [] {
                                            if (titleDict?[passedTest.title] != nil || titleDict?.count == 0) && (langDict?[passedTest.language] != nil || langDict?.count == 0) {
                      
                                                if temp["\(titleDict?[passedTest.title] != nil ? passedTest.title : ""), \(langDict?[passedTest.language] != nil ? passedTest.language : "")"]?["Passed"] == nil {
                                                    
                                                    temp["\(titleDict?[passedTest.title] != nil ? passedTest.title : ""), \(langDict?[passedTest.language] != nil ? passedTest.language : "")"] = ["Passed": 0, "Failed": 0]
                                                }
                                                
                                                temp["\(titleDict?[passedTest.title] != nil ? passedTest.title : ""), \(langDict?[passedTest.language] != nil ? passedTest.language : "")"]?["Passed"]! += 1
                                                
                                                
                                            }
                                        }
                                        for failedTest in failedTestDetailsArry ?? [] {
                                            if (titleDict?[failedTest.title] != nil || titleDict?.count == 0) && (langDict?[failedTest.language] != nil || langDict?.count == 0) {
                      
                                                if temp["\(titleDict?[failedTest.title] != nil ? failedTest.title : ""), \(langDict?[failedTest.language] != nil ? failedTest.language : "")"]?["Failed"] == nil {
                                                    
                                                    temp["\(titleDict?[failedTest.title] != nil ? failedTest.title : ""), \(langDict?[failedTest.language] != nil ? failedTest.language : "")"] = ["Passed": 0, "Failed": 0]
                                                }
                                                
                                                temp["\(titleDict?[failedTest.title] != nil ? failedTest.title : ""), \(langDict?[failedTest.language] != nil ? failedTest.language : "")"]?["Failed"]! += 1
                                                
                                                
                                            }
                                        }
                                        
                                        filteredResults = temp
                                     
                                        
                                       
                                    }
                                }
                            }
                            .frame(width: 100, alignment: .leading)
                            .padding([.top, .leading, .bottom])
                        }
                        .frame(height: 200)
                        
                    }
                  
                }
                Spacer()
                Button(action: {
                    showChartMenu = true
                }) {
                    Image(systemName: "plus")
                }
                .popover(isPresented: $showChartMenu){
                    VStack {
                        ForEach(Array(chartChoices.enumerated()), id: \.element){ i, chart in
                            Button("\(chart)") {
                                currentChart.selection = chart
                            }
                           .buttonStyle(PlainButtonStyle())
                           .padding([.bottom], 4)
                        }
                    }
                  
                    .padding()
                }
                .padding([.trailing])
                .buttonStyle(BorderedButtonStyle())
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                LazyVGrid(columns: col) {
                    ForEach(filteredResults.keys.sorted(), id: \.self) { key in
                        VStack(spacing: 20){
                            Text("\(key)")
                                .font(.system(.title)).bold()
                            
                            switch currentChart.selection {
                            case "Pie Chart":
                                pieChart(filteredResults: filteredResults, key: key)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300, alignment: .center)
                                    .padding()
                                    
                            case "Bar Chart":
                                BarChartView(values: convertToPercentage([Double(filteredResults[key]?["Passed"] ?? 0), Double(filteredResults[key]?["Failed"] ?? 0)]), colorArry: determineColor(dict: filteredResults, key: key))
                                    .frame(maxWidth: 200)
                                    .frame(height: 300, alignment: .center)
                                    .padding()
                            default:
                                pieChart(filteredResults: filteredResults, key: key)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300, alignment: .center)
                                    .padding()
                            }
                            
                            HStack(alignment: .center) {
                                ForEach(0..<2, id:\.self) {i in
                                    HStack {
                                        RoundedRectangle(cornerRadius: 5.0)
                                            .fill(colorDict[i])
                                            .frame(width: 20, height: 20)
                                        Text("\(colorDict[i] == Color.red ? "Failed": "Passed"): \(testNums(data: filteredResults[key] ?? ["Passed": 0], color: colorDict[i]))")
                                    }
                                    
                                }
                                .padding([.bottom])
                                    
                            }
                            .overlay(Divider(), alignment: .bottom)
                        }
                                
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(Divider(), alignment: .top)
        }
            .frame(maxWidth: .infinity)
          
            
           
        }
        
        
    }

    


struct AllView_Previews: PreviewProvider {
    static var previews: some View {
        AllView(data: ["tets": ["tye":0]])
    }
}

func formatMenu(_ type: Int, _ labels: [Int: String]) -> String {
    let menuVal = labels[type]
    let menu = Int(menuVal ?? "Title Not Found") == nil ? menuVal : (menuVal ?? "Time not found")+"m"
    return menu ?? "Failed Location"
}


func testNums(data: [String: Int], color: Color) -> Int {
    if color == Color.red {
        return data["Failed"] ?? 0
    }
    return data["Passed"] ?? 0
}
func determineColor(dict: [String: [String: Int]], key: String) -> [Color] {
    if dict[key]?["Passed"] ?? 0 > dict[key]?["Failed"] ?? 0{
        return [Color.green, Color.red]
    }
    
    return [ Color.red, Color.green]
}
func determineSingleColor(dict: [String: [String: Int]], key: String) -> Color {
    if dict[key]?["Passed"] ?? 0 > dict[key]?["Failed"] ?? 0{
        return Color.green
    }
    
    return Color.red
}

func pieChart(filteredResults: [String: [String:Int]], key: String) -> PieChaetView {
    let values = convertToPercentage([Double(filteredResults[key]?["Passed"] ?? 0), Double(filteredResults[key]?["Failed"] ?? 0)])
    let colorArr = determineColor(dict: filteredResults, key: key)
    return PieChaetView(values: values, labelOffset: 70, colorArry: colorArr)
}

//pieChart(values: [Double(filteredResults[key]?["Passed"] ?? 0), Double(filteredResults[key]?["Failed"] ?? 0)], labelOffset: 70, colorArr: determineColor(dict: filteredResults, key: key))
