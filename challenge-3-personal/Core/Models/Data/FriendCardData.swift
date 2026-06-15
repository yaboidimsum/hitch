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
    let imageUrl: String
    
    init(
        name: String,
        distance: String,
        imageUrl: String = "https://api.dicebear.com/10.x/lorelei/svg?seed=Felix"
    ) {
        self.name = name
        self.distance = distance
        self.imageUrl = imageUrl
    }
}
