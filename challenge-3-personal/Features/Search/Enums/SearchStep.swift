//
//  SearchStep.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 16/06/26.
//

import SwiftUI

enum SearchStep: Hashable {
    case location
    case pickFriend(selectedPlace: Place)
    case receipt(selectedPlace: Place, selectedFriend: User)
    case sent(selectedPlace: Place, selectedFriend: User)
}
