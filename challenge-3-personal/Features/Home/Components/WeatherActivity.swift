//
//  WeatherActivity.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct WeatherActivity: View{
    var body: some View {
        HStack{
            Image(systemName: "sun.max.fill").font(.title2)
                .foregroundStyle(.sun)
            Text("27°C").font(Font.system(.body, design: .rounded))
        }
        .padding(8)
//        .background(.white)
        .clipShape(.rect(cornerRadius: 999))
        .glassEffect()
    }
}

#Preview {
    WeatherActivity()
}
