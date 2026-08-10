import SwiftUI

// MARK: - Zodiak Text Link
// Fonte: Zodiak Design System – Capgemini | Página "Text Link"
// Specs: texto inline com underline + ícone trailing opcional (chevron.right ou arrow.up.right)
// Cores: textLink (light: #1d365a / dark: #ffffff)

struct ZodiakTextLink: View {
    let label: String
    let action: () -> Void
    var showIcon: Bool = true
    var isExternal: Bool = false
    var font: Font = ZodiakTypography.bodyMedium
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            HStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(label))
                    .font(font)
                    .underline()
                if showIcon {
                    Image(systemName: isExternal ? "arrow.up.right" : "chevron.right")
                        .font(.system(size: 12, weight: .medium))
                }
            }
            .fixedSize(horizontal: true, vertical: false)
            .foregroundColor(isEnabled ? ZodiakColors.textLink : ZodiakColors.textDisabled)
            .tracking(ZodiakTypography.BodySize.m.tracking)
        }
        .disabled(!isEnabled)
        .accessibilityLabel(Text(LocalizedStringKey(label)))
        .accessibilityAddTraits(.isLink)
        .accessibilityHint(isExternal ? Text("shared.accessibility.opens_external_link") : Text(verbatim: ""))
        .zodiakA11yID("link")
    }
}

// MARK: - Previews

#Preview("Text Link") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
        ZodiakText("Texto normal com um ", style: .body())
        ZodiakTextLink(label: "link interno", action: {})
        ZodiakTextLink(label: "link externo", action: {}, isExternal: true)
        ZodiakTextLink(label: "sem ícone", action: {}, showIcon: false)
        ZodiakTextLink(label: "desabilitado", action: {}, isEnabled: false)
        ZodiakTextLink(label: "caption link", action: {}, font: ZodiakTypography.captionLarge)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
