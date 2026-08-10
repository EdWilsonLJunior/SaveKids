import SwiftUI

// MARK: - Card Arrow Indicator Gallery View

struct CardArrowIndicatorGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = ["onLite", "onHeavy / onPhoto", "Tamanhos", "Accessibility"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.arrow_button",
                subtitle: "catalog.arrow_button.subtitle",
                figmaRef: nil
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.descricao",
                value: "catalog.cardarrow.spec.desc",
                style: .spec()
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
        }
        .zodiakPage(title: "catalog.component.arrow_button")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: onLiteSection
        case 1: onHeavySection
        case 2: sizesSection
        default: accessibilitySection
        }
    }

    // MARK: - onLite

    private var onLiteSection: some View {
        gallerySectionCard(title: "onLite") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.cor"),
                value: "actionPrimary default · actionPressed pressed · actionDisabled disabled",
                style: .spec()
            )

            HStack(spacing: ZodiakSpacing.s32) {
                ZodiakArrowButton(action: {}, size: .small)
                ZodiakArrowButton(action: {}, size: .medium)
                ZodiakArrowButton(action: {}, size: .large)
                ZodiakArrowButton(action: {}, size: .xLarge)
                ZodiakArrowButton(action: {}, size: .medium, isEnabled: false)
            }
            .padding(ZodiakSpacing.s8)

            // Exemplo em contexto de card
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.uso"),
                value: "catalog.cardarrow.spec.usage",
                style: .spec()
            )
            HStack {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.cardarrow.demo.title", style: .title3)
                    ZodiakText("catalog.cardarrow.demo.body", style: .body(color: .secondary))
                }
                Spacer()
                ZodiakArrowButton(action: {}, size: .medium)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
        }
    }

    // MARK: - onHeavy / onPhoto

    private var onHeavySection: some View {
        gallerySectionCard(title: "onHeavy / onPhoto") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.cor"),
                value: "actionPrimaryOnHeavy default · actionPressedOnHeavy pressed",
                style: .spec()
            )

            ZStack {
                RoundedRectangle(cornerRadius: ZodiakRadii.m)
                    .fill(ZodiakColors.surfaceInk)
                VStack(spacing: ZodiakSpacing.s8) {
                    HStack(spacing: ZodiakSpacing.s32) {
                        ZodiakArrowButton(action: {}, size: .small, surface: .onHeavy)
                        ZodiakArrowButton(action: {}, size: .medium, surface: .onHeavy)
                        ZodiakArrowButton(action: {}, size: .large, surface: .onHeavy)
                        ZodiakArrowButton(action: {}, size: .xLarge, surface: .onHeavy)
                        ZodiakArrowButton(action: {}, size: .medium, surface: .onHeavy, isEnabled: false)
                    }
                }
                .padding(ZodiakSpacing.s16)
            }
        }
    }

    // MARK: - Tamanhos

    private var sizesSection: some View {
        gallerySectionCard(title: "catalog.section.tamanhos") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "S 12px/1px · M 18px/1.4px · L 24px/1.8px · XL 40px/2.8px",
                style: .spec()
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                sizeRow("Small — 12px · stroke 1px", size: .small)
                sizeRow("Medium — 18px · stroke 1.4px", size: .medium)
                sizeRow("Large — 24px · stroke 1.8px", size: .large)
                sizeRow("XLarge — 40px · stroke 2.8px", size: .xLarge)
            }
        }
    }

    private func sizeRow(_ label: String, size: ZodiakArrowButtonSize) -> some View {
        HStack(spacing: ZodiakSpacing.s16) {
            ZodiakArrowButton(action: {}, size: size)
                .frame(width: 60)
            ZodiakText(label, style: .body(color: .secondary))
        }
    }

    // MARK: - Accessibility

    private var accessibilitySection: some View {
        gallerySectionCard(title: "Accessibility") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.cardarrow.spec.a11y_desc",
                style: .spec()
            )

            ZodiakInfoRow(
                "Default label",
                value: "\"shared.action.navigate\" (Navigate / Navegar)",
                style: .spec()
            )

            ZodiakInfoRow(
                "Identifier",
                value: "zodiak.button.arrow.<lite|heavy>",
                style: .spec()
            )

            ZodiakText("Exemplos com labels customizados", style: .title3)
            HStack(spacing: ZodiakSpacing.s32) {
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakArrowButton(
                        action: {},
                        size: .medium,
                        accessibilityLabelKey: "Continue"
                    )
                    Text(verbatim: "label: Continue")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                }
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakArrowButton(
                        action: {},
                        size: .medium,
                        accessibilityLabelKey: "See more"
                    )
                    Text(verbatim: "label: See more")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(ZodiakSpacing.s8)
        }
    }
}

#Preview { NavigationStack { CardArrowIndicatorGalleryView() } }
