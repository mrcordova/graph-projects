//
//  TitleView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI


struct TitleView: View {
    let data: [String: [String: Int]]
    let menuTitle: String
    @State private var checked: [Bool]
    @State private var showMenu = false
    @State private var filteredData:[String: [String:Int]]
    @State private var filteredValDict: [String: Bool]
    let searchLabel: String
    
    
    init(data: [String: [String:Int]], menuTitle: String, searchLabel: String){
        self.data = data
        self.menuTitle = menuTitle
        _checked = State(initialValue: [Bool](repeating: false, count: data.keys.count))
        self.filteredData = data
        self.filteredValDict = [:]
        self.searchLabel = searchLabel
        for key in self.filteredData.keys {
            self.filteredValDict[key] = false
        }
        
    }
    var body: some View {
        VStack {
            HStack{
                FilterView(showMenu: $showMenu, checked: $checked, filteredData: $filteredData, filteredValDict: $filteredValDict, menuTitle: menuTitle, data: data)
            }
            ChartScrollView(filteredData: $filteredData, data: data, searchLabel: searchLabel)
        }
        
           
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(data: ["test":["type": 0]], menuTitle: "Tile", searchLabel: "TIME")
    }
}


