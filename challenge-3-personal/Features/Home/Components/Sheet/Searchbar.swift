//
//  Searchbar.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct Searchbar: View {
    @Binding var selectedDetent: PresentationDetent
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    Circle()
                        .stroke(.greenBrand, lineWidth: 4)
                        .frame(width: 16, height: 16)
                        
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search for destination")
                                .foregroundStyle(.ink.opacity(0.8))
                                .font(.caption)
                                .bold()
                        }
                        TextField("", text: $searchText)
                            .foregroundStyle(.ink)
                            .font(.caption)
                            .bold()
                    }
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
