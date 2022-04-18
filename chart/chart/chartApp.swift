//
//  ChartApp.swift
//  chart
//
//  Created by Noah Cordova on 4/18/22.
//

import SwiftUI

@main
struct ChartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(searchResult: 5,  filteredDict: ["test": ["type": 0]])
        }
    }
}
