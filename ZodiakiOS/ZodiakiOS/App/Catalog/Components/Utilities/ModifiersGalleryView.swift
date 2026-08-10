import SwiftUI

// MARK: - Modifiers Gallery View

struct ModifiersGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            header
            cardStyleSection
            errorStyleSection
            expandedTouchSection
            buttonStylesSection
            keyboardSection
        }
        .zodiakPage(title: "catalog.section.view_modifiers")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.section.view_modifiers", style: .headline)
            ZodiakText(
                "catalog.utilities.desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - .cardStyle()

    private var cardStyleSection: some View {
        modifierCard(
            name: ".cardStyle()",
            description: "Aplica padding (twoXSmall), fundo surface, cornerRadius S e shadow oficial Zodiak.",
            preview: AnyView(
                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakText("catalog.section.without_card_style", style: .body())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(ZodiakSpacing.s8)
                        .background(ZodiakColors.surfaceSmoke)
                        .cornerRadius(ZodiakRadii.s)
                    ZodiakText("catalog.section.with_card_style", style: .body())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cardStyle()
                }
            )
        )
    }

    // MARK: - .errorStyle()

    private var errorStyleSection: some View {
        modifierCard(
            name: ".errorStyle()",
            description: "Aplica font caption e cor textNegative (#9e0029). Usado em mensagens de erro inline.",
            preview: AnyView(
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.section.normal_text", style: .body())
                    Text("catalog.modifiers.desc_0")
                        .errorStyle()
                    Text("catalog.modifiers.desc_1")
                        .errorStyle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.s)
            )
        )
    }

    // MARK: - .expandedTouchTarget()

    private var expandedTouchSection: some View {
        modifierCard(
            name: ".expandedTouchTarget()",
            // swiftlint:disable:next line_length
            description: "Garante área mínima de toque 44×44pt (WCAG 2.5.5). Aplicado automaticamente em todos os botões Zodiak.",
            preview: AnyView(
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakText(
                        // swiftlint:disable:next line_length
                        "Todos os ZodiakButton, ZodiakSecondaryButton, ZodiakTertiaryButton e ZodiakSmallButton incluem .expandedTouchTarget() por padrão.",
                        style: .caption()
                    )
                        .fixedSize(horizontal: false, vertical: true)
                    ZodiakSmallButton(title: "catalog.spec.small_button_note", action: {})
                }
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.s)
            )
        )
    }

    // MARK: - Button Styles

    private var buttonStylesSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("Button Styles", style: .title2)
            ZodiakText(
                "5 ButtonStyle customizados aplicados via modifier nos componentes Zodiak.",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
            VStack(spacing: ZodiakSpacing.s8) {
                styleRow(
                    name: "ZodiakPrimaryButtonStyle",
                    description: "Pill, 48pt, bg: actionPrimary, texto: textInverse"
                )
                styleRow(
                    name: "ZodiakSecondaryButtonStyle",
                    description: "Pill, 48pt, borda: actionPrimary, fill no pressed"
                )
                styleRow(
                    name: "ZodiakDangerButtonStyle",
                    description: "Pill, 48pt, bg: actionWarningSecondary (#9e0029)"
                )
                styleRow(
                    name: "ZodiakSmallButtonStyle",
                    description: "Pill, 38pt, bg: actionPrimary, padding horizontal xs"
                )
            }
        }
    }

    private func styleRow(name: String, description: String) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: "wand.and.stars")
                .foregroundColor(ZodiakColors.actionPrimary)
                .font(.system(size: 14))
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(description)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(ZodiakSpacing.s8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }

    // MARK: - Keyboard

    private var keyboardSection: some View {
        modifierCard(
            name: ".dismissKeyboardOnTap()",
            description: "Dispensa o teclado ao tocar fora de campos de texto. Aplicado em todos os templates.",
            preview: AnyView(
                ZodiakText(
                    "Ativo nesta tela — toque em qualquer área fora dos campos para ver o efeito.",
                    style: .caption()
                )
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.s)
            )
        )
    }

    // MARK: - Helper

    private func modifierCard(name: String, description: String, preview: AnyView) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: "wand.and.stars")
                    .foregroundColor(ZodiakColors.actionPrimary)
                ZodiakText(name, style: .title3)
            }
            ZodiakText(description, style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            preview
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    NavigationStack {
        ModifiersGalleryView()
    }
}
