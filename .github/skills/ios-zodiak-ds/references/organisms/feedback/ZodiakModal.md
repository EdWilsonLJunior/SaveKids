> **Platform**: iOS

# ZodiakModal — `Shared/DesignSystem/Organisms/Modal/ZodiakModal.swift`

```swift
// Direct component
ZodiakModal<Content: View>(
    isPresented: Binding<Bool>,
    title: String? = nil,
    showCloseButton: Bool = true,
    @ViewBuilder content: () -> Content
)

// View modifier (preferred — attach to screen root)
extension View {
    func zodiakModal<C: View>(
        isPresented: Binding<Bool>,
        title: String? = nil,
        showCloseButton: Bool = true,
        @ViewBuilder content: @escaping () -> C
    ) -> some View
}

// Bottom sheet variant
ZodiakBottomSheet<Content: View>(
    isPresented: Binding<Bool>,
    title: String? = nil,
    detents: Set<PresentationDetent> = [.medium, .large],
    @ViewBuilder content: () -> Content
)
```

## Size
- Desktop/iPad: fixed **480pt width** (`ZodiakSizing.cardMaxWidth`). Mobile: full width.

## When to use
- Critical decisions that need immediate attention (warnings, confirmations).
- Required input before continuing (authentication, permissions, terms).
- Content/notification that must not be missed.

## When NOT to use

<never>
- ❌ Complex or multi-step tasks — use full screen or `ZodiakFormInDrawer`.
- ❌ Extensive data gathering — use form-on-page or `ZodiakFormInDrawer`.
- ❌ Information that doesn't need immediate action — use `ZodiakNotificationBanner`.
</never>

## Accessibility
- Dismiss with Esc key (dismissible modals only).
- Tab/Shift+Tab cycles through focusable elements inside the modal.
- Non-dismissible modals: no close button, forces user choice.

---
