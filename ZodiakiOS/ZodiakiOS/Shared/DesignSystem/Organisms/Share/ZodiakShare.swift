import SwiftUI

// MARK: - Zodiak Share
// Figma: "catalog.component_name.share" — share button that opens a bottom sheet with sharing options.
// Mobile: bottom sheet (same pattern as ZodiakDownloadButton).

struct ZodiakShareOption: Identifiable {
    let id: UUID
    let title: String
    let icon: ZodiakIcon
    let action: () -> Void

    init(id: UUID = UUID(), title: String, icon: ZodiakIcon, action: @escaping () -> Void) {
        self.id = id
        self.title = title
        self.icon = icon
        self.action = action
    }
}

struct ZodiakShare: View {
    let options: [ZodiakShareOption]
    var label: String = "shared.action.share"
    var isEnabled: Bool = true

    @State private var showSheet = false

    var body: some View {
        Button {
            guard isEnabled else { return }
            showSheet = true
        } label: {
            HStack(spacing: ZodiakSpacing.s4) {
                ZodiakIconView(
                    .share,
                    size: .small,
                    color: isEnabled ? ZodiakColors.textSecondary : ZodiakColors.actionDisabledContent
                )
                ZodiakText(
                    LocalizedStringKey(label),
                    style: .body(color: isEnabled ? .secondary : .disabled)
                )
            }
        }
        .disabled(!isEnabled)
        .accessibilityLabel(Text("shared.action.share"))
        .accessibilityHint(isEnabled
            ? Text("catalog.spec.share_options")
            : Text("shared.state.unavailable"))
        .sheet(isPresented: $showSheet) {
            ZodiakShareSheet(options: options, isPresented: $showSheet, label: label)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Share Sheet

private struct ZodiakShareSheet: View {
    let options: [ZodiakShareOption]
    @Binding var isPresented: Bool
    let label: String

    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                ZodiakText(LocalizedStringKey(label), style: .title2)
                Spacer()
                ZodiakIconButton(
                    icon: "xmark",
                    action: { isPresented = false },
                    style: .tertiary,
                    accessibilityLabel: "shared.action.close"
                )
            }
            .padding(.top, ZodiakSpacing.s24)
            .padding([.horizontal, .bottom], ZodiakSpacing.s16)

            ZodiakDivider(hierarchy: .secondary)

            // Options list
            VStack(spacing: 0) {
                ForEach(Array(options.enumerated()), id: \.element.id) { idx, option in
                    Button {
                        option.action()
                        isPresented = false
                    } label: {
                        HStack(spacing: ZodiakSpacing.s8) {
                            ZodiakIconView(option.icon, size: .small, color: ZodiakColors.textSecondary)
                            ZodiakText(option.title, style: .bodySmall())
                            Spacer()
                        }
                        .padding(.horizontal, ZodiakSpacing.s16)
                        .padding(.vertical, ZodiakSpacing.s8)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(Text(verbatim: option.title))
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 8)
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.85).delay(Double(idx) * 0.05),
                        value: appeared
                    )

                    if idx < options.count - 1 {
                        let dividerInset = ZodiakSpacing.s16 + ZodiakIconSize.small.dimension + ZodiakSpacing.s8
                        ZodiakDivider(hierarchy: .secondary)
                            .padding(.leading, dividerInset)
                    }
                }
            }
            .onAppear { withAnimation { appeared = true } }

            Spacer(minLength: ZodiakSpacing.s32)
        }
        .background(ZodiakColors.surface.ignoresSafeArea())
    }
}

// MARK: - Preview

#Preview("Share") {
    VStack {
        ZodiakShare(
            options: [
                .init(title: "Email", icon: .mail, action: {}),
                .init(title: "LinkedIn", icon: .linkedin, action: {}),
                .init(title: "Copiar link", icon: .copy, action: {})
            ]
        )

        ZodiakShare(
            options: [
                .init(title: "Email", icon: .mail, action: {}),
                .init(title: "WhatsApp", icon: .whatsapp, action: {})
            ],
            label: "Compartilhar artigo",
            isEnabled: false
        )
    }
    .padding()
    .background(ZodiakColors.background)
}
