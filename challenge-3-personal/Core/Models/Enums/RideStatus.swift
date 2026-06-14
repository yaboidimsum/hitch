//
//  RideStatus.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

/// Represents the current state of a ride request.
enum RideStatus: String {
    case success = "Success"
    case rideRequest = "Ride Request"
    case cancelled = "Cancelled"
    case inProgress = "In Progress"
    
    var color: Color {
        switch self {
        case .success, .rideRequest:
            .greenBrand
        case .cancelled:
            .red
        case .inProgress:
            .orange
        }
    }
}
