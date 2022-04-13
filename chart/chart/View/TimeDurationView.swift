//
//  TimeDurationView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI

struct TimeDurationView: View {
    var convertedValues: [String: [String: Int]]
    let menuTitle: String
    init(data: [String: [String: Int]], menuTitle: String) {
        self.convertedValues = calculateTimeRange(data: data)
        self.menuTitle = menuTitle
    }
    var body: some View {
        TitleView(data: convertedValues, menuTitle: menuTitle, searchLabel: "Time")
    }
}

struct TimeDurationView_Previews: PreviewProvider {
    static var previews: some View {
        TimeDurationView(data: ["t": ["t":0]], menuTitle: "TIME")
    }
}

func calculateTimeRange(data: [String: [String: Int]]) -> [String: [String: Int]] {
    if data.first?.value["type"] != 2 {
        return data
    }
    var temp: [String: [String: Int]] = [:]
    var rangeDict: [String: [String:Int]] = [:]
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    _ =  data.map{ (time) -> Bool in
        let timeStrArry = time.key.components(separatedBy: " to ")
        let startDateTime = formatter.date(from: timeStrArry[0])
        let endDateTime = formatter.date(from: timeStrArry[1])
        let delta = (Int(endDateTime?.timeIntervalSinceReferenceDate ?? 0.0) - Int(startDateTime?.timeIntervalSinceReferenceDate ?? 0.0))/60
        if ((temp.index(forKey: "\(delta)")) == nil) {
            temp["\(delta)"] = ["Passed":0, "Failed": 0]
        }
        temp["\(delta)"]?["Passed"]! += time.value["Passed"] ?? 0
        temp["\(delta)"]?["Failed"]! += time.value["Failed"] ?? 0
        return true
    }
  
    rangeDict["5"] = ["Passed":0, "Failed": 0, "type": 2]
    rangeDict["10"] = ["Passed":0, "Failed": 0, "type": 2]
    rangeDict["15"] = ["Passed":0, "Failed": 0, "type":2]
    for (k, v) in temp.sorted(by: {Int($0.key) ?? 0 < Int($1.key) ?? 0}){
        let currKey = Int(k) ?? 0
        if currKey <= 5 {
            rangeDict["5"]?["Passed"]! += v["Passed"] ?? 0
            rangeDict["5"]?["Failed"]! += v["Failed"] ?? 0
        }
        if currKey <= 10 {
            rangeDict["10"]?["Passed"]! += v["Passed"] ?? 0
            rangeDict["10"]?["Failed"]! += v["Failed"] ?? 0
        }
        if currKey <= 15 {
            rangeDict["15"]?["Passed"]! += v["Passed"] ?? 0
            rangeDict["15"]?["Failed"]! += v["Failed"] ?? 0
        }
    }
  
    return rangeDict
    
}

