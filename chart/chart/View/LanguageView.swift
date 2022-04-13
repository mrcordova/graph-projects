//
//  LanguageView.swift
//  chart
//
//  Created by Noah Cordova on 4/6/22.
//

import SwiftUI



struct LanguageView: View {
    let data: [String: [String: Int]]
    let menuTitle: String
    @State private var checked: [Bool]
    @State private var showMenu = false
    @State private var filteredData:[String: [String:Int]]
    @State private var filteredValDict: [String: Bool]
    

    
    
    init(data: [String: [String:Int]], menuTitle: String){
        self.data = data
        self.menuTitle = menuTitle
        _checked = State(initialValue: [Bool](repeating: false, count: data.keys.count))
        self.filteredData = data
        self.filteredValDict = [:]
        for key in self.filteredData.keys {
            self.filteredValDict[key] = false
        }

    }
    var body: some View {
        VStack{
            FilterView(showMenu: $showMenu, checked: $checked, filteredData: $filteredData, filteredValDict: $filteredValDict, menuTitle: menuTitle, data: data)
        
            ChartScrollView(filteredData: $filteredData,data: data, searchLabel: "Language")
           
        }
    }
}


struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(data: ["ty": ["io":0]], menuTitle: "Lang")
    }
}
