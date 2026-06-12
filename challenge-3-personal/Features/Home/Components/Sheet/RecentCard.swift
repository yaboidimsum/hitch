//
//  RecentCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct RecentCard: View{
    var body: some View{
        VStack{
            HStack(alignment:.top, spacing: 16){
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
                VStack(spacing:16){
                    HStack{
                        VStack(alignment:.leading,spacing:4){
                            Text("Little Olie!").font(.subheadline).fontWeight(.semibold)
                                .foregroundStyle(.ink)
                            Text("Bendungan Hilir, South Jakarta")
                                .font(.caption2)
                                .fontWeight(.regular).foregroundStyle(.mutedSlate)
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.3)).frame(height: 1)
                }
            }.padding(.horizontal,20).padding(.top,16).padding(.bottom,8)
            HStack(alignment:.top, spacing: 16){
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
                VStack(spacing:16){
                    HStack{
                        VStack(alignment:.leading,spacing:4){
                            Text("Little Olie!").font(.subheadline).fontWeight(.semibold)
                                .foregroundStyle(.ink)
                            Text("Bendungan Hilir, South Jakarta")
                                .font(.caption2)
                                .fontWeight(.regular).foregroundStyle(.mutedSlate)
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.3)).frame(height: 1)
                }
            }.padding(.horizontal,20).padding(.vertical,8)
            HStack(alignment:.top, spacing: 16){
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
                VStack(spacing:16){
                    HStack{
                        VStack(alignment:.leading,spacing:4){
                            Text("Little Olie!").font(.subheadline).fontWeight(.semibold)
                                .foregroundStyle(.ink)
                            Text("Bendungan Hilir, South Jakarta")
                                .font(.caption2)
                                .fontWeight(.regular).foregroundStyle(.mutedSlate)
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                }
            }.padding(.horizontal,20).padding(.top,8).padding(.bottom,16)
        }.background(.canvas).clipShape(
            .rect(cornerRadius: 26)) .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 4)
    }
}

#Preview{
    RecentCard()
}
