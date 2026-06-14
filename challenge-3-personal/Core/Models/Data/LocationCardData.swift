//
//  LocationCardData.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import Foundation

struct LocationCardData: Identifiable{
    let id = UUID()
    let mainAddress: String
    let subAddress: String
    let historyImage: String
    
    init(mainAddress: String, subAddress: String, historyImage: String = "clock.fill") {
        self.mainAddress = mainAddress
        self.subAddress = subAddress
        self.historyImage = historyImage
    }
}
