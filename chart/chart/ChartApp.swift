//
//  chartApp.swift
//  chart
//
//  Created by Noah Cordova on 4/1/22.
//

import SwiftUI

@main
struct chartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(searchResult: 5,  filteredDict: ["test": ["type": 0]])
        }
    }
}
