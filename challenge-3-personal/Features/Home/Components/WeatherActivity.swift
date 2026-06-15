import SwiftUI

struct WeatherActivity: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        HStack {
            Image(systemName: store.weather.iconName)
                .font(.title2)
                .foregroundStyle(.sun)
            Text(store.weather.displayText)
                .font(Font.system(.body, design: .rounded))
        }
        .padding(8)
        .clipShape(.rect(cornerRadius: 999))
        .glassEffect()
    }
}

#Preview {
    WeatherActivity()
        .environment(AppStore.mock())
}
