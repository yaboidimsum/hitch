//
//  WeatherData.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI
import Foundation

@Observable
class WeatherData{
    var iconName: String
    var temperature: Int
    var tempUnit: String
    
    init(iconName: String, temperature: Int, tempUnit:String = "°C") {
        self.iconName = iconName
        self.temperature = temperature
        self.tempUnit = tempUnit
    }
    
    var displayText: String {
        "\(temperature)\(tempUnit)"
    }
}
