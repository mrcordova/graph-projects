//
//  ContentView.swift
//  chart
//
//  Created by Noah Cordova on 4/1/22.
//

import SwiftUI

enum SearchParameter: Int, CaseIterable, Codable {
    case status = 1
    case timeDuration = 2
    case title = 3
    case language =  4
    case all = 5
    
    func description() -> String {
        var result  = "all"
        switch self {
        case .status:
            result = "status"
        case .timeDuration:
            result = "timeDuration"
        case .title:
            result = "title"
        case .language:
            result = "language"
        case .all:
            result = "all"
        }
        return result
    }
    
}


let colors = [
    Color.green,
    Color.red,
    Color.blue]


struct ContentView: View {
    @State var searchResult: Int
    var filteredResults = filterResults()
    @State var filteredDict: [String: [String: Int]]

    var body: some View {
        
        VStack {
            HStack {
                Button("Title") {
                    searchResult = 3
                    filteredDict = filterForParameters(filteredResults: filteredResults, searchResult: searchResult)

                }
                Button("Language") {
                    searchResult = 4
                    filteredDict =  filterForParameters(filteredResults: filteredResults, searchResult: searchResult)
//                    print(filteredDict)
                }
                Button("Time Duration") {
                    searchResult = 2
                    filteredDict = filterForParameters(filteredResults: filteredResults, searchResult: searchResult)

                }
                Button("All") {
                    searchResult = 5
                    filteredDict = filteredResults
                }
            }
            .padding()
            
            HStack {
                switch searchResult {
                case 4:
                    LanguageView(data: filteredDict, menuTitle: "Language")
                case 3:
                    TitleView(data: filteredDict, menuTitle: "Title")
                case 2:
                    TimeDurationView(data: filteredDict, menuTitle: "Time Ranges")
                case 5:
                    AllView(data: filteredResults)
                default:
                    Text("Data not found \(searchResult.description)")
                }
            }
            .frame(width: 450, height: 500)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchResult: 5, filteredDict: ["test": ["type": 0]])
    }
}

func filterResults() -> [String: [String:Int]] {
    let searchResultDict = chartData.results.map { result -> [String: [String:Int]] in
       let finalDic = result.reduce(into: [String: [String: Int]]()){ dictionary, result in
          _ = result.testDetails.map { testDetail in
              if dictionary[testDetail.title] == nil {
                  dictionary[testDetail.title] = [result.status:0, "type": 3]
              }
              if dictionary[testDetail.language] == nil {
                  dictionary[testDetail.language] = [result.status:0, "type": 4]
              }
              if dictionary[testDetail.timeDuration] == nil {
                  dictionary[testDetail.timeDuration] = [result.status:0, "type": 2]
              }
                  let title = dictionary[testDetail.title]
                  let language = dictionary[testDetail.language]
                  let timeDuration = dictionary[testDetail.timeDuration]
                  
                  dictionary[testDetail.title]?.updateValue((title?[result.status] ?? 0)+1, forKey: result.status)
                  dictionary[testDetail.language]?.updateValue((language?[result.status] ?? 0)+1, forKey: result.status)
                  dictionary[testDetail.timeDuration]?.updateValue((timeDuration?[result.status] ?? 0)+1, forKey: result.status)
              
           }
           
       }

       return finalDic
    }!
    return searchResultDict
}

func filterForParameters(filteredResults: [String: [String:Int]], searchResult: Int) -> [String: [String: Int]]{
    var tempDict =  filteredResults.mapValues{$0.filter{
        $0.value == searchResult && $0.key == "type"
    }}.filter{!$0.value.isEmpty}
    _ = filteredResults.map {
        if (tempDict.index(forKey: $0.key) != nil) {
            tempDict[$0.key] = $0.value
        }
    }
    return tempDict
}


