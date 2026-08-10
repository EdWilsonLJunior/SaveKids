> **Platform**: iOS

# ZodiakCounterControl — `Shared/DesignSystem/Molecules/CounterControl/ZodiakCounterControl.swift`

```swift
ZodiakCounterControl(
    value: Binding<Int>,
    min: Int,
    max: Int,
    step: Int = 1,
    label: LocalizedStringKey = "catalog.counter.label_attempts"
)
```

## ⚠️ Known limitation
The `label` default value is "Tentativas" (hardcoded catalog label, not generic). For generic quantity counters (cart items, parcelas, doses), compose manually with `ZodiakIconButton` + `ZodiakText` until the component exposes a neutral label:

```swift
HStack {
    ZodiakIconButton(icon: "minus", action: decrement, size: .small, style: .tertiary,
                     accessibilityLabel: String(localized: "shared.action.decrease"))
    ZodiakText(verbatim: "\(quantity)", style: .title1)
        .contentTransition(.numericText())
        .animation(.spring(response: 0.3), value: quantity)
    ZodiakIconButton(icon: "plus", action: increment, size: .small, style: .tertiary,
                     accessibilityLabel: String(localized: "shared.action.increase"))
}
```
