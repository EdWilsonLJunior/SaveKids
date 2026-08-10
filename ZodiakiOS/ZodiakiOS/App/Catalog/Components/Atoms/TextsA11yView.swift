import SwiftUI

// MARK: - Texts A11y View
// Demonstra os comportamentos de acessibilidade do componente ZodiakText:
// — trait `.isHeader` automático em todos os estilos de heading
// — leitura por VoiceOver com label correto
// — cor em contexto (contraste adequado por token semântico)
// — Dynamic Type: body scales, display headings são clampeados
// Usado pela aba "A11y" em TextsGalleryView.

// MARK: - Testing Guide Helper

private func testingGuide(_ steps: [String]) -> some View {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
        HStack(spacing: ZodiakSpacing.s4) {
            Image(systemName: "list.number")
                .font(.caption2)
                .foregroundColor(ZodiakColors.textLink)
            Text(verbatim: "Como Testar")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textLink)
        }
        ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
            HStack(alignment: .top, spacing: ZodiakSpacing.s4) {
                Text(verbatim: "\(index + 1).")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(width: 16, alignment: .trailing)
                Text(verbatim: step)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    .padding(ZodiakSpacing.s8)
    .background(ZodiakColors.background)
    .cornerRadius(ZodiakRadii.xs)
}

// swiftlint:disable:next type_body_length
struct TextsA11yView: View {
    var body: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            gallerySectionCard(title: "catalog.texts.a11y.header_trait_title") {
                headerTraitSection
            }
            gallerySectionCard(title: "catalog.texts.a11y.color_contrast_title") {
                colorContrastSection
            }
            gallerySectionCard(title: "catalog.texts.a11y.dynamic_type_title") {
                dynamicTypeSection
            }
            gallerySectionCard(title: "catalog.texts.a11y.verbatim_title") {
                verbatimSection
            }
        }
    }

    // MARK: - isHeader Trait

    private var headerTraitSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.texts.a11y.header_trait_desc", style: .body(color: .secondary))

            ZodiakDivider(hierarchy: .secondary)

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                a11yDemoRow(
                    voiceOverLabel: "catalog.texts.a11y.vo_header",
                    isHeader: true
                ) {
                    ZodiakText("catalog.texts.a11y.example_heading", style: .title2)
                }

                a11yDemoRow(
                    voiceOverLabel: "catalog.texts.a11y.vo_title1",
                    isHeader: true
                ) {
                    ZodiakText("catalog.texts.a11y.example_title1", style: .title1)
                }

                a11yDemoRow(
                    voiceOverLabel: "catalog.texts.a11y.vo_body",
                    isHeader: false
                ) {
                    ZodiakText("catalog.texts.a11y.example_body", style: .body())
                }
            }

            ZodiakDivider(hierarchy: .secondary)

            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(ZodiakColors.textLink)
                ZodiakText("catalog.texts.a11y.header_trait_note", style: .caption(color: .secondary))
            }
            testingGuide([
                "Ative VoiceOver: Ajustes → Acessibilidade → VoiceOver.",
                "Navegue com swipe direito entre os exemplos — cada elemento é focado separadamente.",
                "Ao focar \"Título de Seção\": o VoiceOver anuncia \"Título de Seção, Cabeçalho\".",
                "No rotor (giro com 2 dedos) selecione \"Cabeçalhos\" — navegue só entre headings com swipe ↑↓."
            ])
        }
    }

    private func a11yDemoRow<Content: View>(
        voiceOverLabel: LocalizedStringKey,
        isHeader: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .trailing, spacing: 2) {
                Image(systemName: isHeader ? "h.square.fill" : "paragraph")
                    .font(.caption)
                    .foregroundColor(isHeader ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled)
                Text(voiceOverLabel)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }

    // MARK: - Color Contrast

    private var colorContrastSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.texts.a11y.color_contrast_desc", style: .body(color: .secondary))

            ZodiakDivider(hierarchy: .secondary)

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                contrastRow(
                    style: .body(),
                    bg: ZodiakColors.surface,
                    label: ".primary on surface",
                    wcag: "AA ✓ (≥4.5:1)"
                )
                contrastRow(
                    style: .body(color: .secondary),
                    bg: ZodiakColors.surface,
                    label: ".secondary on surface",
                    wcag: "AA ✓"
                )
                contrastRow(
                    style: .body(color: .inverse),
                    bg: ZodiakColors.surfaceInk,
                    label: ".inverse on surfaceInk",
                    wcag: "AA ✓",
                    wcagColor: ZodiakColors.textInverse.opacity(0.78)
                )
                contrastRow(
                    style: .caption(color: .disabled),
                    bg: ZodiakColors.surface,
                    label: ".disabled (decorativo)",
                    wcag: "catalog.texts.a11y.contrast_disabled_note"
                )
            }
            ZodiakDivider(hierarchy: .secondary)
            testingGuide([
                "Mac: Xcode → Open Developer Tool → Accessibility Inspector.",
                "Na aba Audit clique em Run Audit — confirme 0 falhas nos tokens .primary, .secondary e .inverse.",
                ".disabled é decorativo e pode não atingir 4.5:1 — isso é intencional.",
                "Simulador: Ajustes → Acessibilidade → Exibição e Tamanho do Texto → Aumentar Contraste."
            ])
        }
    }

    private func contrastRow(
        style: ZodiakTextViewStyle, bg: Color, label: String, wcag: LocalizedStringKey,
        wcagColor: Color = ZodiakColors.textSecondary
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.l)
                .padding(.bottom, ZodiakSpacing.s4)
            HStack {
                ZodiakText(verbatim: "Texto de exemplo", style: style)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(wcag)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(wcagColor)
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(bg)
        .cornerRadius(ZodiakRadii.xs)
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                .stroke(ZodiakColors.borderPrimary, lineWidth: 0.5)
        )
    }

    // MARK: - Dynamic Type

    private var dynamicTypeSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.texts.a11y.dynamic_type_desc", style: .body(color: .secondary))

            ZodiakDivider(hierarchy: .secondary)

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                dynamicTypeRow(
                    label: ".body() — escala com Dynamic Type",
                    icon: "arrow.up.and.down.text.horizontal",
                    scales: true
                ) {
                    ZodiakText("catalog.texts.a11y.example_body", style: .body())
                }
                dynamicTypeRow(
                    label: ".caption() — escala com Dynamic Type",
                    icon: "arrow.up.and.down.text.horizontal",
                    scales: true
                ) {
                    ZodiakText("catalog.texts.a11y.example_caption", style: .caption())
                }
                dynamicTypeRow(
                    label: ".headline6XL() — .largeTitle como base",
                    icon: "textformat.size",
                    scales: true
                ) {
                    ZodiakText("Display", style: .headline6XL())
                        .lineLimit(1)
                }
            }

            ZodiakDivider(hierarchy: .secondary)

            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: "info.circle")
                    .foregroundColor(ZodiakColors.textLink)
                ZodiakText("catalog.texts.a11y.dynamic_type_note", style: .caption(color: .secondary))
            }
            testingGuide([
                "Ajustes → Acessibilidade → Tamanho do Texto → deslize ao máximo.",
                "Volte ao Catálogo: .body() e .caption() devem escalar com o sistema.",
                ".headline6XL() usa .largeTitle como âncora — cresce de forma controlada.",
                "Simulador: Xcode → Simulador → Features → Text Size."
            ])
        }
    }

    private func dynamicTypeRow<Content: View>(
        label: String,
        icon: String,
        scales: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundColor(scales ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled)
                Text(verbatim: label)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .padding(.vertical, 2)
                    .background(ZodiakColors.background)
                    .cornerRadius(ZodiakRadii.l)
            }
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }

    // MARK: - Verbatim vs Localized

    private var verbatimSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.texts.a11y.verbatim_desc", style: .body(color: .secondary))

            ZodiakDivider(hierarchy: .secondary)

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                verbatimRow(
                    label: "ZodiakText(\"catalog.key\", style:)",
                    desc: "catalog.texts.a11y.verbatim_key_note"
                ) {
                    ZodiakText("catalog.texts.a11y.example_body", style: .body())
                }
                verbatimRow(
                    label: "ZodiakText(verbatim: dynamicString, style:)",
                    desc: "catalog.texts.a11y.verbatim_dynamic_note"
                ) {
                    ZodiakText(verbatim: "João da Silva — dado dinâmico", style: .body())
                }
            }
            ZodiakDivider(hierarchy: .secondary)
            testingGuide([
                "Ative VoiceOver e foque no primeiro exemplo (chave localizada).",
                "O VoiceOver anuncia o texto traduzido — nunca a chave \"catalog.texts…\".",
                "Mude o idioma do dispositivo para inglês e confirme que o texto muda junto.",
                "Para verbatim (dado dinâmico): o texto completo é lido sem truncamento."
            ])
        }
    }

    private func verbatimRow<Content: View>(
        label: String,
        desc: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(verbatim: label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.l)
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            Text(desc)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            TextsA11yView()
                .padding(.top, ZodiakSpacing.s16)
        }
    }
}
