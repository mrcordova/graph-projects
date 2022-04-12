//
//  Result.swift
//  chart
//
//  Created by Noah Cordova on 4/5/22.
//

import Foundation

struct Result: Codable {
    let color: String
    let status: String
    let testDetails: [TestDetail]
}
