//
//  Searchbar.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct Searchbar: View {
    @Binding var selectedDetent: PresentationDetent
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    Circle()
                        .stroke(.orange, lineWidth: 4)
                        .frame(width: 16, height: 16)
                        
                    TextField("Search for destination", text: .constant(""))
                        .foregroundStyle(.ink)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.ink)
                    .padding(.trailing, 10)
                    .font(.body)
            }
            .padding(12)
            .background(.gray.opacity(0.12))
            .clipShape(.rect(cornerRadius: 999))
        }
        .padding(16)
        .contentShape(.rect)
        .onTapGesture {
            selectedDetent = .medium
        }
    }
}

#Preview {
    Searchbar(selectedDetent: .constant(.height(70)))
}
