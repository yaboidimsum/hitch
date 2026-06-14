//
//  RequestSearchLocation.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestSearchLocation: View{
    
    private let locations = [
        LocationCardData(
            mainAddress: "Apple Developer Academy @ Binus",
            subAddress: "Jl. Grand Boulevard, BSD Green Office Park 9, BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345, Indonesia",
         
        ),
        LocationCardData(
            mainAddress: "Gelora Bung Karno",
            subAddress: "Jl. Pintu Satu Senayan, RT.1/RW.3, Gelora, Kec. Tanah Abang, Jakarta Pusat, DKI Jakarta 10270",
         
        ),
        
    ]
    
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
               
                ForEach(locations){
                    location in LocationCard(data:location)
                }
                
            }
        }
    }
}

#Preview{
    RequestSearchLocation()
}
 
