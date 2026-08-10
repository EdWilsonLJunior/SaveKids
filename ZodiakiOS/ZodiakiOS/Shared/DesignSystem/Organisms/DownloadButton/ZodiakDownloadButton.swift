import SwiftUI

// MARK: - Zodiak Download Button
// Figma: "Download" — triggers a menu of download options.
// On mobile: bottom sheet with options (matches Figma spec).
// On tap: SwiftUI Menu (compact) or sheet (full mobile).

struct ZodiakDownloadOption: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String?
    let icon: String
    let url: URL?
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        icon: String = "arrow.down.circle",
        url: URL? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.url = url
        self.onTap = onTap
    }
}

// MARK: - Zodiak Download Button

struct ZodiakDownloadButton: View {
    let options: [ZodiakDownloadOption]
    var label: String = "Download"
    var isEnabled: Bool = true

    @State private var showSheet = false
    @Environment(\.redactionReasons) private var redactionReasons

    var body: some View {
        if redactionReasons.contains(.placeholder) {
            // SF Symbol icons in the button label don't redact natively.
            // Render a pill-shaped placeholder matching the button dimensions.
            RoundedRectangle(cornerRadius: ZodiakRadii.l, style: .continuous)
                .fill(ZodiakColors.borderPrimary)
                .frame(height: ZodiakSizing.buttonHeightMedium)
        } else {
            Button {
                if options.count == 1 {
                    options.first?.onTap?()
                } else {
                    showSheet = true
                }
            } label: {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 16, weight: .regular))
                    Text(LocalizedStringKey(label))
                        .font(ZodiakTypography.button)
                    if options.count > 1 {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 11, weight: .semibold))
                    }
                }
                .foregroundColor(isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabledContent)
                .padding(.horizontal, ZodiakSpacing.s16)
                .frame(height: ZodiakSizing.buttonHeightMedium)
                .background(.clear)
                .cornerRadius(ZodiakRadii.l)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.l)
                        .stroke(isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabled, lineWidth: 1.5)
                )
            }
            .disabled(!isEnabled)
            .accessibilityLabel(label)
            .accessibilityHint(
                isEnabled
                    ? Text("shared.action.tap_to_view_download")
                    : Text("shared.state.unavailable"))
            .sheet(isPresented: $showSheet) {
                ZodiakDownloadSheet(options: options, label: label)
                    .presentationDetents([.fraction(0.45), .medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: - Download Options Sheet (mobile bottom sheet variant)
// Figma: "opens a bottom sheet that slides up from the bottom on mobile"

private struct ZodiakDownloadSheet: View {
    let options: [ZodiakDownloadOption]
    let label: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(options) { option in
                Button {
                    option.onTap?()
                    dismiss()
                } label: {
                    HStack(spacing: ZodiakSpacing.s8) {
                        Image(systemName: option.icon)
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .frame(width: 32)

                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            Text(LocalizedStringKey(option.title))
                                .font(ZodiakTypography.bodyMedium)
                                .foregroundColor(ZodiakColors.textPrimary)
                            if let subtitle = option.subtitle {
                                Text(LocalizedStringKey(subtitle))
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(ZodiakColors.textDisabled)
                    }
                }
                .listRowBackground(ZodiakColors.surface)
            }
            .listStyle(.plain)
            .navigationTitle(label)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("shared.action.cancel") { dismiss() }
                        .foregroundColor(ZodiakColors.actionPrimary)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        // Single option (direct download)
        ZodiakDownloadButton(
            options: [.init(title: "Relatório PDF", icon: "doc.richtext", onTap: {})],
            label: "Baixar PDF"
        )

        // Multiple options (shows sheet)
        ZodiakDownloadButton(
            options: [
                .init(title: "catalog.spec.format_pdf", subtitle: "2.3 MB", icon: "doc.richtext", onTap: {}),
                .init(title: "catalog.spec.format_excel", subtitle: "1.1 MB", icon: "tablecells", onTap: {}),
                .init(title: "catalog.spec.format_csv", subtitle: "320 KB", icon: "doc.plaintext", onTap: {})
            ],
            label: "Exportar relatório"
        )

        ZodiakDownloadButton(
            options: [.init(title: "catalog.spec.format_pdf", icon: "doc.richtext")],
            label: "Download desabilitado",
            isEnabled: false
        )
    }
    .padding()
    .background(ZodiakColors.background)
}
