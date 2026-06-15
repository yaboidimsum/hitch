## Side-by-Side Comparison

### Current `.request` case (already works)

**ContentView (caller):**
```swift
case .request:
    HitchRequestContainer(
        state: .incoming(pendingRide),
        currentUserID: store.currentUser.id
    ) {
        // ← trailing closure = onBack
        sheetContent = .hitch
    }
```

**HitchRequestContainer (view):**
```swift
struct HitchRequestContainer: View {
    let state: HitchRequestState
    let currentUserID: UUID
    let onBack: () -> Void  // ← has callback
    
    var body: some View {
        HStack {
            Button("Back", systemImage: "chevron.left", action: onBack)
            // ...
        }
    }
}
```

---

### Current `.searchLocation` case (broken)

**ContentView (caller):**
```swift
case .searchLocation:
    RequestSearchLocation()  // ← no callback, no back button
        .presentationDetents([.medium, .large])
```

**RequestSearchLocation (view):**
```swift
struct RequestSearchLocation: View {
    // ← no onBack property at all
    // ← no back button anywhere
    
    var body: some View {
        VStack {
            DestinationCard()
            MapButton()
            // ...
        }
    }
}
```

---

### Fixed `.searchLocation` case (what you need)

**ContentView (caller):**
```swift
case .searchLocation:
    RequestSearchLocation {
        // ← trailing closure = onBack
        sheetContent = .request
    }
    .presentationDetents([.medium, .large])
```

**RequestSearchLocation (view):**
```swift
struct RequestSearchLocation: View {
    var onBack: () -> Void  // ← add callback
    
    var body: some View {
        VStack {
            HStack {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .labelStyle(.iconOnly)
                Spacer()
            }
            .padding(.horizontal)
            
            DestinationCard()
            MapButton()
            // ...
        }
    }
}
```

---

## Summary

| | `.request` | `.searchLocation` (current) | `.searchLocation` (fixed) |
|---|---|---|---|
| **Callback?** | `onBack` ✅ | ❌ nothing | `onBack` ✅ |
| **Back button?** | ✅ | ❌ | ✅ |
| **Can change sheet?** | ✅ | ❌ | ✅ |
| **Trailing closure?** | ✅ | N/A | ✅ |
