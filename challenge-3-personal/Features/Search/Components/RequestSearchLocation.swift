//
//  RequestSearchLocation.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestSearchLocation: View{
    var body: some View {
        VStack(spacing:20){
            VStack(alignment:.leading, spacing:12){
                DestinationCard()
                MapButton()
            }.padding(.horizontal,16)
            ScrollView{
                Rectangle()
                    .fill(.mutedSlate.opacity(0.2))
                    .frame(height: 1)
                LocationCard()
                LocationCard()
                LocationCard()
                LocationCard()
            }
        }
    }
}

#Preview{
    RequestSearchLocation()
}
 
