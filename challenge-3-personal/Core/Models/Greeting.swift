//
//  Greeting.swift
//  challenge-3-personal
//

import SwiftUI

struct Greeting {
    let message: String
    let recipient: String
    
    static let `default` = Greeting(message: "Hello, world!", recipient: "world")
    
    var headline: String {
        message
    }
    
    var subtitle: String {
        "Welcome, \(recipient)!"
    }
}
