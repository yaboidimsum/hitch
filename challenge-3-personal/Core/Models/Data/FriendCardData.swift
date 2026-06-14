//
//  FriendCardData.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import Foundation

struct FriendCardData: Identifiable {
    let id = UUID()
    let name: String
    let distance: String
    let imageName: String
    
    init(
        name: String,
        distance: String,
        imageName: String = "person.crop.circle"
    ) {
        self.name = name
        self.distance = distance
        self.imageName = imageName
    }
}
