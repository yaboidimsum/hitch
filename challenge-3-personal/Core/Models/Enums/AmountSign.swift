//
//  AmountSign.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import Foundation

/// Represents how a monetary amount should be displayed.
enum AmountSign {
    case positive
    case negative
    case neutral
    
    var prefix: String {
        switch self {
        case .positive: "+"
        case .negative: "-"
        case .neutral: ""
        }
    }
}
