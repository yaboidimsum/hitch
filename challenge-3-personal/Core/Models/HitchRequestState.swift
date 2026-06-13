//
//  HitchRequestState.swift
//  challenge-3-personal
//

import SwiftUI

enum HitchRequestState {
    case empty
    case incoming(HitchRequestData)
    case inProgress(HitchRequestData)
    case done(HitchRequestData)
    case rejected(HitchRequestData)
}
