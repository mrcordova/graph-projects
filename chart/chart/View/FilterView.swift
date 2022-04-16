//
//  FilterView.swift
//  chart
//
//  Created by Noah Cordova on 4/11/22.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var currentChart: CurrentChart
    @Binding var showMenu: Bool
    @Binding  var checked: [Bool]
    @Binding  var filteredData:[String: [String:Int]]
    @Binding var filteredValDict: [String: Bool]
    @State var showChartMenu: Bool = false
    let menuTitle: String
    let data: [String: [String: Int]]
    let chartChoices : [String] = ["Pie Chart", "Bar Chart", "Line Chart", "Capsule Chart", "Bubble Chart"]
    
    var body: some View {
        HStack {
          Text("Filter")
                .padding(.horizontal)
                .overlay(Divider(), alignment: .trailing)
      
            Button("\(menuTitle)") {
                showMenu = true
            }
            .popover(isPresented: $showMenu) {
                ScrollView {
                    VStack {
                        ForEach(Array(data.keys.sorted().enumerated()) , id: \.element){ idx, key in
                            Toggle(isOn: $checked[idx]) {
                                Text("\(key)")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onChange(of: checked[idx]) {newValue in
                                filteredValDict[key] = !(filteredValDict[key] ?? false)
                                self.filteredData =  data.filter{(filteredValDict[$0.key] ?? false) }
                                
                            }
                        }
                    }
                    .frame(width: 100, alignment: .leading)
                    .padding([.top, .leading, .bottom])
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                showChartMenu = true
            }) {
                Image(systemName: "plus")
            }
            .popover(isPresented: $showChartMenu){
                VStack {
                    ForEach(Array(chartChoices.enumerated()), id: \.element){ i, chart in
                        Button("\(chart)") {
                            currentChart.selection = chart
                        }
                       .buttonStyle(PlainButtonStyle())
                       .padding([.bottom], 4)
                    }
                }
                .padding()
            }
            .padding([.trailing])
            .buttonStyle(BorderedButtonStyle())
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var showMenu = false
    @State static var checked = [false]
    @State static var filteredDict = ["test": [":type": 0]]
    @State static var filteredValDict = ["ter":false]
    static var previews: some View {
        FilterView(showMenu: $showMenu, checked: $checked, filteredData: $filteredDict, filteredValDict: $filteredValDict, menuTitle: "", data: [:])
    }
}
