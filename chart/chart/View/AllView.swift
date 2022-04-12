//
//  AllView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI

struct AllView: View {
//    let data: [String: [String: Int]]
//    @State var filteredDict: [[String: [String: Int]]]
//    let failedTestDetailsArry = chartData.results?[0].testDetails
//    let passedTestDetailsArry = chartData.results?[1].testDetails
//    @State var values: [Double]
//    @State var colorDict: [Color]
//    @State var checked: Bool = false
//    @State var showMenu: Bool = false
//    @State var labels: [Int: String]
//
//    init(data: [String: [String: Int]] ){
//        self.filteredDict = []
//        self.data = data
//
//        self.values = [Double(passedTestDetailsArry?.count ?? 0),Double(failedTestDetailsArry?.count ?? 0)]
//        self.colorDict = [Color.green, Color.red]
//        self.labels = [3: "Title", 4: "Language", 2: "Time"]
//
//    }
//    var body: some View {
//        VStack{
//            HStack {
//                Text("Filter")
//                        .padding(.horizontal)
//                        .overlay(Divider(), alignment: .trailing)
//                ForEach(filteredDict, id: \.self) { arr in
//                        ForEach(arr.keys.sorted(), id: \.self){ key in
//                            Button(formatMenu(arr.first?.value["type"] ?? 0, labels)) {
//                                labels[arr.first?.value["type"] ?? 0] = key
//
//
//                                let formatter = DateFormatter()
//                                formatter.dateFormat = "h:mm a"
//                                var finalFailedCount = 0
//                                var finalPassedCount = 0
//                                for failedTest in failedTestDetailsArry ?? [] {
//                                    let timeStrArry = failedTest.timeDuration.components(separatedBy: " to ")
//                                    let startDateTime = formatter.date(from: timeStrArry[0])
//                                    let endDateTime = formatter.date(from: timeStrArry[1])
//                                    let delta = (Int(endDateTime?.timeIntervalSinceReferenceDate ?? 0.0) - Int(startDateTime?.timeIntervalSinceReferenceDate ?? 0.0))/60
//                                    if (failedTest.title == labels[3] || labels[3] == "Title") && (failedTest.language == labels[4] || labels[4] == "Language") && (delta <= Int(labels[2] ?? "failed") ?? -1 || labels[2] == "Time"){
//                                        finalFailedCount += 1
//                                    }
//                                }
//                                for passedTest in passedTestDetailsArry ?? [] {
//                                    let timeStrArry = passedTest.timeDuration.components(separatedBy: " to ")
//                                    let startDateTime = formatter.date(from: timeStrArry[0])
//                                    let endDateTime = formatter.date(from: timeStrArry[1])
//                                    let delta = (Int(endDateTime?.timeIntervalSinceReferenceDate ?? 0.0) - Int(startDateTime?.timeIntervalSinceReferenceDate ?? 0.0))/60
//                                    if (passedTest.title == labels[3] || labels[3] == "Title") && (passedTest.language == labels[4] || labels[4] == "Language") && (delta <= Int(labels[2] ?? "failed") ?? -1 || labels[2] == "Time"){
//                                        finalPassedCount += 1
//                                    }
//                                }
//                                if finalPassedCount < finalFailedCount {
//                                    colorDict[0] = Color.red
//                                    colorDict[1] = Color.green
//                                } else {
//                                    colorDict[0] = Color.green
//                                    colorDict[1] = Color.red
//                                }
//                                values = [Double(finalPassedCount), Double(finalFailedCount)]
//                                values = values.sorted(by: >)
//                                if values[0] == 0 && values[1] == 0 {
//                                    values[0] = 1
//                                    values[1] = 1
//                                    colorDict[0] = Color.blue
//                                    colorDict[1] = Color.blue
//                                }
//
//                            }
//                            .popover(isPresented: $showMenu) {
//                                ScrollView {
//                                    VStack {
//                                        ForEach(Array(data.keys.sorted().enumerated()) , id: \.element){ idx, key in
//                                            Toggle(isOn: $checked) {
//                                                Text("\(Int(key) == nil ? key : key + "m")")
//                                            }
//                                            .toggleStyle(CheckboxToggleStyle())
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .onChange(of: checked) {newValue in
//                                               print(key)
//
//                                            }
//                                        }
//                                    }
//                                    .frame(width: 100, alignment: .leading)
//                                    .padding([.top, .leading, .bottom])
//                                }
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 200)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//
//                        }
//
//
//                }
//                .padding(.trailing)
//            }.onAppear {
//                var tempArr: [[String: [String: Int]]] = []
//                for idx in 2..<5 {
//                    let tempDict = calculateTimeRange(data:  filterForParameters(filteredResults: data, searchResult: idx))
//                    tempArr.append(tempDict)
//                }
//                self.filteredDict = tempArr
//
//            }
//        VStack{
//        ChartView(data: data)
//            .frame(width: 300, height: 300)
//            HStack(alignment: .center){
//            ForEach(0..<values.count, id:\.self) {i in
//                HStack {
//                    RoundedRectangle(cornerRadius: 5.0)
//                        .fill(colorDict[i])
//                        .frame(width: 20, height: 20)
//                    Text("\(colorDict[i] == Color.red ? "Failed": "Passed"): \(Int(values[i]))")
//                }
//            }
//            }
//
//        }
//    }
//
    let data: [String: [String: Int]]
   
    @State private var checked: [[Bool]]
    @State private var showMenu : [Bool]
    @State private var filteredData:[String: [String:Int]]
    @State private var filteredValDict: [String: Bool]
    @State private var filteredDict : [[String: [String: Int]]]
    var labels: [Int: String]
    init(data: [String: [String:Int]]){
        
        self.data = data
    
        _checked = State(initialValue: [[Bool]](repeating: Array(repeating: false, count: data.values.count), count: data.keys.count))
        _filteredDict = State(initialValue: [filterForParameters(filteredResults: self.data, searchResult: 3), filterForParameters(filteredResults: self.data, searchResult: 4)])
        
        self.filteredData = data
        self.filteredValDict = [:]
        self.labels =  [0: "Title", 1: "Language"]
        _showMenu = State(initialValue: [Bool](repeating: false, count: labels.count))
      
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
                                        
                                    }
                                }
                            }
                            .frame(width: 100, alignment: .leading)
                            .padding([.top, .leading, .bottom])
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        
                    }
                }
                    
            }
            .onAppear {
//                for key in self.filteredData.keys {
//                    self.filteredValDict[key] = false
//                }
//                print(filteredValDict)
            }
            .frame(maxWidth: .infinity)
            ScrollView {
                VStack(spacing: 20){
                    ForEach(filteredDict.indices, id: \.self){idx in
                        ForEach(filteredDict[idx].keys.sorted(), id: \.self) { key in
                            Text("\(key)")
                                .font(.system(.title)).bold()
                            ChartView(data: [key: filteredDict[idx][key] ?? ["passed": 0]])
                            Text("\(String(describing: filteredDict[idx][key] ?? ["Passed": 0]))")
                                .overlay(Divider(), alignment: .bottom)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
          
            
           
        }
        
        
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

func calculateIdx(idx: Int) -> Int {
    var idxPLus =  idx+1
    if idxPLus != 1 {
        idxPLus += 2
    }
    return idxPLus
}
//func setValsAndLabels(values: Binding<[Double]>, colorDict: [Color], failedTestDetailsArry: [TestDetail], passedTestDetailsArry:[TestDetail], labels: [Int: String] ) {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "h:mm a"
//    var finalFailedCount = 0
//    var finalPassedCount = 0
//    for failedTest in failedTestDetailsArry ?? [] {
//        let timeStrArry = failedTest.timeDuration.components(separatedBy: " to ")
//        let startDateTime = formatter.date(from: timeStrArry[0])
//        let endDateTime = formatter.date(from: timeStrArry[1])
//        let delta = (Int(endDateTime?.timeIntervalSinceReferenceDate ?? 0.0) - Int(startDateTime?.timeIntervalSinceReferenceDate ?? 0.0))/60
//        if (failedTest.title == labels[3] || labels[3] == "Title") && (failedTest.language == labels[4] || labels[4] == "Language") && (delta <= Int(labels[2] ?? "failed") ?? -1 || labels[2] == "Time"){
//            finalFailedCount += 1
//        }
//    }
//    for passedTest in passedTestDetailsArry ?? [] {
//        let timeStrArry = passedTest.timeDuration.components(separatedBy: " to ")
//        let startDateTime = formatter.date(from: timeStrArry[0])
//        let endDateTime = formatter.date(from: timeStrArry[1])
//        let delta = (Int(endDateTime?.timeIntervalSinceReferenceDate ?? 0.0) - Int(startDateTime?.timeIntervalSinceReferenceDate ?? 0.0))/60
//        if (passedTest.title == labels[3] || labels[3] == "Title") && (passedTest.language == labels[4] || labels[4] == "Language") && (delta <= Int(labels[2] ?? "failed") ?? -1 || labels[2] == "Time"){
//            finalPassedCount += 1
//        }
//    }
//    if finalPassedCount < finalFailedCount {
//        colorDict[0] = Color.red
//        colorDict[1] = Color.green
//    } else {
//        colorDict[0] = Color.green
//        colorDict[1] = Color.red
//    }
//    values = [Double(finalPassedCount), Double(finalFailedCount)]
//    values = values.sorted(by: >)
//    if values[0] == 0 && values[1] == 0 {
//        values[0] = 1
//        values[1] = 1
//        colorDict[0] = Color.blue
//        colorDict[1] = Color.blue
//    }
//}

//            for searchResult in 2..<5 {
//                self.filteredDict.append(filterForParameters(filteredResults: self.data, searchResult: searchResult))
//            }
//            self.filteredDict[0] = calculateTimeRange(data: self.filteredDict[0])
