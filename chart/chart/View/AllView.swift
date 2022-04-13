//
//  AllView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI

struct AllView: View {
    let data: [String: [String: Int]]
   
    @State private var checked: [[Bool]]
    @State private var showMenu : [Bool]
    @State private var filteredData:[String: [String:Int]]
    @State private var filteredValDict: [String: Bool]
    @State private var filteredDict : [[String: [String: Int]]]
    @State private var filteredResults: [String: [String: Int]]
    var labels: [Int: String]
    let failedTestDetailsArry = chartData.results?[0].testDetails
    let passedTestDetailsArry = chartData.results?[1].testDetails
    
    init(data: [String: [String:Int]]){
        
        self.data = data
    
        _checked = State(initialValue: [[Bool]](repeating: Array(repeating: false, count: data.values.count), count: data.keys.count))
        _filteredDict = State(initialValue: [filterForParameters(filteredResults: self.data, searchResult: 3), filterForParameters(filteredResults: self.data, searchResult: 4)])
        
        self.filteredData = data
        self.filteredValDict = [:]
        self.labels =  [0: "Title", 1: "Language"]
        _showMenu = State(initialValue: [Bool](repeating: false, count: labels.count))
        self.filteredResults = ["All":["Passed": 95, "Failed": 5]]
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
                                        
                                                if temp["\(passedTest.title), \(passedTest.language)"]?["Passed"] == nil {
                                                    
                                                    temp["\(passedTest.title), \(passedTest.language)"] = ["Passed": 0, "Failed": 0]
                                                }
                                                
                                                temp["\(passedTest.title), \(passedTest.language)"]?["Passed"]! += 1
                                                
                                            }
                                        }
                                        for failedTest in failedTestDetailsArry ?? [] {
                                            if (titleDict?[failedTest.title] != nil || titleDict?.count == 0) && (langDict?[failedTest.language] != nil || langDict?.count == 0) {
                      
                                                if temp["\(failedTest.title), \(failedTest.language)"]?["Failed"] == nil {
                                                    
                                                    temp["\(failedTest.title), \(failedTest.language)"] = ["Passed": 0, "Failed": 0]
                                                }
                                                
                                                temp["\(failedTest.title), \(failedTest.language)"]?["Failed"]! += 1
                                                
                                            }
                                        }
                                        filteredResults = temp
                                        print(filteredResults)
                                        
                                       
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
//                    ForEach(filteredDict.indices, id: \.self){idx in
//                        ForEach(filteredDict[idx].keys.sorted(), id: \.self) { key in
//                            Text("\(key)")
//                                .font(.system(.title)).bold()
//                            ChartView(data: [key: filteredDict[idx][key] ?? ["passed": 0]])
//                            Text("\(String(describing: filteredDict[idx][key] ?? ["Passed": 0]))")
//                                .overlay(Divider(), alignment: .bottom)
//                        }
//                    }
                    ForEach(filteredResults.keys.sorted(), id: \.self) { key in
                        Text("\(key)")
                            .font(.system(.title)).bold()
                        PieChaetView(filteredData: $filteredResults, data: data)

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
