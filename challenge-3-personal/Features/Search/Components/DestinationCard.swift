import SwiftUI

struct DestinationCard: View {
    let currentLocation: String?
    let selectedPlace: Place?
    var isEditable: Bool = true
    let onPlaceSelected: (Place) -> Void
    
    @State private var searchModel = DestinationSearchModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.default)
                    .foregroundStyle(.greenBrand)
                Text(currentLocation ?? "Locating")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.ink)
            }
            
            Rectangle()
                .fill(.mutedSlate.opacity(0.3))
                .frame(height: 2)
                .padding(.leading, 24)
            
            if let place = selectedPlace {
                HStack {
                    Image(systemName: "flag.pattern.checkered.circle.fill")
                        .font(.default)
                        .foregroundStyle(.greenBrand)
                    Text(place.name)
                        .font(.caption)
                        .foregroundStyle(.ink.opacity(0.8))
                        .bold()
                    
                    Spacer()
                    
                    if isEditable {
                        Button("Change", systemImage: "xmark.circle.fill") {
                            searchModel.clear()
//                            onPlaceSelected(place)
                        }
                        .labelStyle(.iconOnly)
                        .font(.default)
                        .foregroundStyle(.secondary)
                    }
                }
            } else if isEditable {
                HStack(spacing: 8) {
                    Image(systemName: "flag.pattern.checkered.circle.fill")
                        .font(.default)
                        .foregroundStyle(.greenBrand)
                    
                    TextField("Search destination", text: $searchModel.query)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.ink)
                        .submitLabel(.search)
                        .onSubmit {
                            searchModel.search(near: nil)
                        }
                    
                    if searchModel.isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(0.6)
                    }
                    
                    if !searchModel.query.isEmpty {
                        Button("Clear", systemImage: "xmark.circle.fill") {
                            searchModel.clear()
                        }
                        .labelStyle(.iconOnly)
                        .font(.default)
                        .foregroundStyle(.secondary)
                    }
                }
                
                if !searchModel.results.isEmpty {
                    VStack(spacing: 12) {
                        ForEach(searchModel.results) { place in
                            Button {
                                searchModel.clear()
                                onPlaceSelected(place)
                            } label: {
                                LocationCard(place: place)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.plain)
                            .padding(.vertical, 8)
                            
                            if place.id != searchModel.results.last?.id {
                                Rectangle()
                                    .fill(.mutedSlate.opacity(0.2))
                                    .frame(height: 1)
                                    .padding(.leading, 56)
                            }
                        }
                    }
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 12))
                }
                
//                if searchModel.query.isEmpty {
//                    Text("Search for destination")
//                        .font(.caption)
//                        .foregroundStyle(.ink.opacity(0.5))
//                        .bold()
//                        .padding(.leading, 24)
//                } else if searchModel.results.isEmpty && !searchModel.isSearching {
//                    ContentUnavailableView.search(text: searchModel.query)
//                }
            } else {
                HStack {
                    Image(systemName: "flag.pattern.checkered.circle.fill")
                        .font(.default)
                        .foregroundStyle(.greenBrand)
                    Text("Search for destination")
                        .font(.caption)
                        .foregroundStyle(.ink.opacity(0.5))
                        .bold()
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.mutedSlate.opacity(0.05))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    let store = AppStore.mock()
    VStack(spacing: 16) {
        DestinationCard(
            currentLocation: "Autograph Tower level 52",
            selectedPlace: store.recentPlaces[0],
            isEditable: true,
            onPlaceSelected: { _ in }
        )
        
        DestinationCard(
            currentLocation: "Autograph Tower level 52",
            selectedPlace: nil,
            isEditable: true,
            onPlaceSelected: { _ in }
        )
    }
    .padding()
}
