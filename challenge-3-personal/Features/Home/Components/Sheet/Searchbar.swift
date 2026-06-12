//
//  Searchbar.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct Searchbar: View {
    
    var body: some View {
        HStack{
            HStack{
                Circle()
                    .stroke(.orange, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    
                TextField("Search for destination", text: .constant(""))
                    .foregroundStyle(.mutedSlate).font(.caption)
                    .fontWeight(.medium)
            }
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.trailing, 10)
                .font(.body)
            
        }.padding(12).background(.searchbarBg.opacity(0.30)).clipShape(
            .rect(cornerRadius: 999)
        )
    }
}

#Preview{
    Searchbar()
}
