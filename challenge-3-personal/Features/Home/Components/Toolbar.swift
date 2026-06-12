//
//  Toolbar.swift
//  challenge-3-personal
//

import SwiftUI

struct Toolbar: View {
    var body: some View {
        HStack(spacing: 8) {
            Button("􀋙", action: {})
                .font(.system(size: 18))
                .frame(width: 36, height: 36)
            
            Button("􂷼", action: {})
                .font(.system(size: 18))
                .frame(width: 36, height: 36)
            
            Button("􀣔", action: {})
                .font(.system(size: 18))
                .frame(width: 36, height: 36)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    Toolbar()
}
