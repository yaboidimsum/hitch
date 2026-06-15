import SwiftUI
import Foundation

@Observable
final class WeatherData {
    var iconName: String
    var temperature: Int
    var tempUnit: String
    
    init(iconName: String, temperature: Int, tempUnit: String = "°C") {
        self.iconName = iconName
        self.temperature = temperature
        self.tempUnit = tempUnit
    }
    
    var displayText: String {
        "\(temperature)\(tempUnit)"
    }
}
