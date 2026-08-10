import SwiftUI

// MARK: - Helpers (file-private)

private func fmtPt(_ val: CGFloat) -> String {
    guard val != 0 else { return "0pt" }
    let sign: String = val > 0 ? "+" : "\u{2212}"
    return "\(sign)\(String(format: "%.2g", val.magnitude))pt"
}

// MARK: - StyleSpec (file-private data model)

private struct StyleSpec {
    let styleName: String
    let tokenName: String       // canonical ZodiakTypography.xxx reference
    let size: String
    let weight: String
    let tracking: String
    let lineHeight: String
    let colorBehavior: String
    let isHeader: Bool
}

// swiftlint:disable:next closure_body_length
private let textsStyleSpecs: [StyleSpec] = {
    func sz(_ s: ZodiakTypography.HeadingSize) -> String { "\(Int(s.pointSize))pt" }
    func lh(_ s: ZodiakTypography.HeadingSize) -> String { "\(Int(s.lineHeight))pt" }
    func tr(_ s: ZodiakTypography.HeadingSize,
            _ w: ZodiakTypography.HeadingWeight = .light) -> String { fmtPt(s.tracking(for: w)) }
    func bSz(_ s: ZodiakTypography.BodySize) -> String { "\(Int(s.pointSize))pt" }
    func bLh(_ s: ZodiakTypography.BodySize) -> String { "\(Int(s.lineHeight))pt" }
    func bTr(_ s: ZodiakTypography.BodySize) -> String { fmtPt(s.tracking) }

    return [
        // Display headings
        StyleSpec(
            styleName: ".headline6XL()", tokenName: "displayLarge",
            size: sz(.sixXLarge), weight: "Light 300",
            tracking: tr(.sixXLarge), lineHeight: lh(.sixXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline6XL(weight: .regular)", tokenName: "heading(.sixXLarge, .regular)",
            size: sz(.sixXLarge), weight: "Regular 400",
            tracking: tr(.sixXLarge, .regular), lineHeight: lh(.sixXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline5XL()", tokenName: "displayMedium",
            size: sz(.fiveXLarge), weight: "Light 300",
            tracking: tr(.fiveXLarge), lineHeight: lh(.fiveXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline5XL(weight: .regular)", tokenName: "heading(.fiveXLarge, .regular)",
            size: sz(.fiveXLarge), weight: "Regular 400",
            tracking: tr(.fiveXLarge, .regular), lineHeight: lh(.fiveXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline4XL()", tokenName: "displaySmall",
            size: sz(.fourXLarge), weight: "Light 300",
            tracking: tr(.fourXLarge), lineHeight: lh(.fourXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline3XL()", tokenName: "headlineLarge",
            size: sz(.threeXLarge), weight: "Light 300",
            tracking: tr(.threeXLarge), lineHeight: lh(.threeXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline3XL(weight: .regular)", tokenName: "heading(.threeXLarge, .regular)",
            size: sz(.threeXLarge), weight: "Regular 400",
            tracking: tr(.threeXLarge, .regular), lineHeight: lh(.threeXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headline2XL()", tokenName: "headlineMedium",
            size: sz(.twoXLarge), weight: "Light 300",
            tracking: tr(.twoXLarge), lineHeight: lh(.twoXLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".headlineXL()", tokenName: "headlineSmall",
            size: sz(.xLarge), weight: "Light 300",
            tracking: tr(.xLarge), lineHeight: lh(.xLarge),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        // Standard headings
        StyleSpec(
            styleName: ".headline", tokenName: "titleLarge",
            size: sz(.large), weight: "Light 300",
            tracking: tr(.large), lineHeight: lh(.large),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".title1", tokenName: "titleMedium",
            size: sz(.medium), weight: "Light 300",
            tracking: tr(.medium), lineHeight: lh(.medium),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".title2", tokenName: "titleSmall",
            size: sz(.small), weight: "Regular 400",
            tracking: tr(.small, .regular), lineHeight: lh(.small),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".title3", tokenName: "labelLarge",
            size: sz(.xSmall), weight: "Regular 400",
            tracking: tr(.xSmall, .regular), lineHeight: lh(.xSmall),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        StyleSpec(
            styleName: ".subtitleSmall", tokenName: "labelMedium",
            size: sz(.twoXSmall), weight: "Regular 400",
            tracking: tr(.twoXSmall, .regular), lineHeight: lh(.twoXSmall),
            colorBehavior: "textPrimary (fixo)", isHeader: true
        ),
        // Body
        StyleSpec(
            styleName: ".bodyXL()", tokenName: "bodyXL",
            size: bSz(.xl), weight: "Regular 400",
            tracking: bTr(.xl), lineHeight: bLh(.xl),
            colorBehavior: "ZodiakTextColor param", isHeader: false
        ),
        StyleSpec(
            styleName: ".bodyLarge()", tokenName: "bodyLarge",
            size: bSz(.l), weight: "Regular 400",
            tracking: bTr(.l), lineHeight: bLh(.l),
            colorBehavior: "ZodiakTextColor param", isHeader: false
        ),
        StyleSpec(
            styleName: ".body()", tokenName: "bodyMedium",
            size: bSz(.m), weight: "Regular 400",
            tracking: bTr(.m), lineHeight: bLh(.m),
            colorBehavior: "ZodiakTextColor param", isHeader: false
        ),
        StyleSpec(
            styleName: ".bodySmall()", tokenName: "bodySmall",
            size: bSz(.s), weight: "Regular 400",
            tracking: bTr(.s), lineHeight: bLh(.s),
            colorBehavior: "ZodiakTextColor param", isHeader: false
        ),
        StyleSpec(
            styleName: ".caption()", tokenName: "captionLarge",
            size: bSz(.xs), weight: "Regular 400",
            tracking: bTr(.xs), lineHeight: bLh(.xs),
            colorBehavior: "ZodiakTextColor param (.secondary)", isHeader: false
        ),
        // Italic
        StyleSpec(
            styleName: ".italic(size: .m)", tokenName: "bodyItalic",
            size: bSz(.m), weight: "Italic 400",
            tracking: bTr(.m), lineHeight: bLh(.m),
            colorBehavior: "ZodiakTextColor param", isHeader: false
        )
    ]
}()

// MARK: - Texts Specs View
// Tabela de especificações do componente ZodiakText.
// Mostra o mapeamento de cada ZodiakTextViewStyle → token de tipografia (tamanho, peso, tracking, line-height).
// Usado pela aba "Specs" em TextsGalleryView.

struct TextsSpecsView: View {
    @EnvironmentObject private var catalog: CatalogViewModel

    var body: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            relatedSection
            gallerySectionCard(title: "catalog.section.specifications") {
                specsTable
            }
            gallerySectionCard(title: "catalog.texts.spec.color_behavior_title") {
                colorBehaviorNote
            }
            gallerySectionCard(title: "catalog.texts.spec.api_title") {
                apiReference
            }
        }
    }

    // MARK: - Related

    private var relatedSection: some View {
        gallerySectionCard(title: "catalog.texts.spec.related_title") {
            Button {
                catalog.selectedItem = .item(.typography)
            } label: {
                HStack(spacing: ZodiakSpacing.s8) {
                    Image(systemName: "textformat")
                        .font(.body)
                        .foregroundColor(ZodiakColors.actionPrimary)
                        .frame(width: 24)
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text(verbatim: "ZodiakTypography")
                            .font(ZodiakTypography.labelLarge)
                            .foregroundColor(ZodiakColors.actionPrimary)
                        ZodiakText("catalog.texts.related_hint", style: .caption(color: .secondary))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(ZodiakColors.actionPrimary)
                }
            }
        }
    }

    // MARK: - Specs Table

    private var specsTable: some View {
        VStack(spacing: 1) {
            tableHeader
            ForEach(textsStyleSpecs, id: \.styleName) { spec in
                specRow(spec)
            }
        }
        .cornerRadius(ZodiakRadii.xs)
    }

    private var tableHeader: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            Text(LocalizedStringKey("catalog.spec.label_style"))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(LocalizedStringKey("catalog.spec.label_size"))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 40, alignment: .center)
            Text(LocalizedStringKey("catalog.spec.label_weight"))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 56, alignment: .center)
            Text(LocalizedStringKey("catalog.spec.label_tracking"))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 52, alignment: .center)
            Text(LocalizedStringKey("catalog.spec.label_line_height"))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 40, alignment: .center)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surfaceSmoke)
    }

    private func specRow(_ spec: StyleSpec) -> some View {
        HStack(spacing: ZodiakSpacing.s4) {
            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(systemName: spec.isHeader ? "lock.fill" : "slider.horizontal.3")
                        .font(.caption2)
                        .foregroundColor(spec.isHeader ? ZodiakColors.textDisabled : ZodiakColors.actionPrimary)
                    Text(verbatim: spec.styleName)
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                Text(verbatim: "\u{2192} \(spec.tokenName)")
                    .font(ZodiakTypography.captionSmall)
                    .foregroundColor(ZodiakColors.textDisabled)
                    .padding(.leading, ZodiakSpacing.s16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(verbatim: spec.size)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 40, alignment: .center)
            Text(verbatim: spec.weight)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 56, alignment: .center)
            Text(verbatim: spec.tracking)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 52, alignment: .center)
            Text(verbatim: spec.lineHeight)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 40, alignment: .center)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
    }

    // MARK: - Color Behavior Note

    private var colorBehaviorNote: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            noteRow(
                icon: "lock.fill",
                color: ZodiakColors.textPrimary,
                title: "catalog.texts.spec.color_fixed",
                desc: "catalog.texts.spec.color_fixed_desc"
            )
            ZodiakDivider(hierarchy: .secondary)
            noteRow(
                icon: "slider.horizontal.3",
                color: ZodiakColors.actionPrimary,
                title: "catalog.texts.spec.color_param",
                desc: "catalog.texts.spec.color_param_desc"
            )
        }
    }

    private func noteRow(icon: String, color: Color, title: LocalizedStringKey, desc: LocalizedStringKey) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(color)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(title)
                    .font(ZodiakTypography.labelLarge)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(desc)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    // MARK: - API Reference

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            apiRow(
                init: "ZodiakText(\"key\", style:)",
                desc: "catalog.texts.spec.api_localized_desc"
            )
            ZodiakDivider(hierarchy: .secondary)
            apiRow(
                init: "ZodiakText(_ key: LocalizedStringKey, style:)",
                desc: "catalog.texts.spec.api_lsk_desc"
            )
            ZodiakDivider(hierarchy: .secondary)
            apiRow(
                init: "ZodiakText(verbatim: text, style:)",
                desc: "catalog.texts.spec.api_verbatim_desc"
            )
        }
    }

    private func apiRow(init initSignature: String, desc: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(verbatim: initSignature)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.l)
            Text(desc)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            TextsSpecsView()
                .padding(.top, ZodiakSpacing.s16)
        }
    }
}
