//
//  FriendMeter.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct FriendMeter: View{
    var body: some View{
        VStack(spacing: 8){
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(.circle)
            VStack(spacing: 4){
                Text("Contact's Name")
                    .foregroundStyle(.greenBrand).font(.caption).fontWeight(.medium)
                Text("25m")
                    .foregroundStyle(.greenBrand)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
           
        }
        
        
    }
}

#Preview{
    FriendMeter()
}
