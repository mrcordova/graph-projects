//
//  ChartData.swift
//  chart
//
//  Created by Noah Cordova on 4/13/22.
//

import Foundation



var chartData: ChartData = load()



struct ChartData: Codable {
    var id: String? {
        return suiteId
    }
    let suiteId: String?
    let results: [Result]?
}

func load() -> ChartData {
 
    guard let dataPathUrl = Bundle.main.path(forResource: "DataSet", ofType: "json"),
        
    let dataSet = FileManager.default.contents(atPath: dataPathUrl) else
    {
        fatalError("Path url: failed")
    }
    do {
        let contents = dataSet
        let decoder = JSONDecoder()
        return try decoder.decode(ChartData.self, from: contents)
    } catch {
        fatalError("\(error)")
    }
}
