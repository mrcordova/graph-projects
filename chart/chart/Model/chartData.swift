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
    
    let fm = FileManager.default
    let home = fm.homeDirectoryForCurrentUser
    let dataPathUrl = home
        .appendingPathComponent("Desktop")
        .appendingPathComponent("DataSet")
        .appendingPathExtension("json")
    
    do {
        let contents = try Data(contentsOf: dataPathUrl)
        let decoder = JSONDecoder()
        return try decoder.decode(ChartData.self, from: contents)
    } catch {
        fatalError("\(error)")
    }
}
