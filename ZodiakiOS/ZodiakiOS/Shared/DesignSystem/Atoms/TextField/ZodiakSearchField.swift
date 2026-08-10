import SwiftUI

// MARK: - Zodiak Search Field
// Figma: "Search field" — TextField variant with leading search icon and inline clear button

public struct ZodiakSearchField: View {
    @Binding var text: String
    let placeholder: LocalizedStringKey
    let onSubmit: (() -> Void)?

    @FocusState private var focused: Bool

    public init(
        text: Binding<String>,
        placeholder: LocalizedStringKey = "shared.placeholder.search",
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconView(
                .searchMagnifyingGlass,
                size: .small,
                color: focused ? ZodiakColors.actionPrimary : ZodiakColors.textSecondary
            )
            .animation(.easeInOut(duration: 0.2), value: focused)

            TextField(placeholder, text: $text)
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textPrimary)
                .tint(ZodiakColors.actionPrimary)
                .focused($focused)
                .submitLabel(.search)
                .onSubmit { onSubmit?() }
                .zodiakA11yID("textfield", role: "search")

            if !text.isEmpty {
                Button {
                    text = ""
                    focused = false
                } label: {
                    ZodiakIconView(.close, size: .small, color: ZodiakColors.textSecondary)
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(.horizontal, ZodiakSpacing.s16)
        .frame(height: ZodiakSizing.textFieldHeight)
        .background(
            RoundedRectangle(cornerRadius: ZodiakRadii.l, style: .continuous)
                .fill(ZodiakColors.surfaceSmoke)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.l, style: .continuous)
                        .stroke(
                            focused ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary,
                            lineWidth: focused ? 1.5 : 1
                        )
                )
        )
        .animation(.easeInOut(duration: 0.18), value: text.isEmpty)
    }
}
