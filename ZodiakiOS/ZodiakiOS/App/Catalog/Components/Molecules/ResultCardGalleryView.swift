import SwiftUI

// MARK: - Result Card Gallery View

struct ResultCardGalleryView: View {
    @State private var cardTitle = "feature.grades.final_average"
    @State private var cardValue = "8.5"
    @State private var cardSubtitle = "catalog.resultcard.demo.above_avg_class"
    @State private var badgeText = "shared.state.passed_decorated"
    @State private var selectedColor: ColorOption = .success
    @State private var showSkeleton = false

    enum ColorOption: String, CaseIterable {
        case success = "catalog.spec.label_success"
        case negative = "Negative"
        case brand = "Brand"
        case marine = "catalog.spec.color_marine"

        var color: Color {
            switch self {
            case .success:  return ZodiakColors.surfacePositive
            case .negative: return ZodiakColors.surfaceNegative
            case .brand:    return ZodiakColors.brand
            case .marine:   return ZodiakColors.surfaceMarine
            }
        }
    }

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.result_cards",
                subtitle: "catalog.result_card.subtitle",
                figmaRef: nil
            )
            playgroundSection
            resultCardSection
            resultCardWithBadgeSection
            usageExamplesSection

            gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.loading_state")) {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)

                ZodiakResultCard(
                    title: "feature.grades.final_average",
                    value: "8.5",
                    subtitle: "feature.grades.above_average")
                    .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.component.result_cards")
    }

    private var playgroundSection: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "catalog.resultcard.demo.title_label",
                    placeholder: "feature.grades.final_average",
                    text: $cardTitle
                )
                ZodiakLabelledField(label: "Valor", placeholder: "8.5", text: $cardValue)
                ZodiakLabelledField(
                    label: "catalog.resultcard.label.subtitle",
                    placeholder: "feature.grades.above_average",
                    text: $cardSubtitle)
                ZodiakLabelledField(
                    label: "Texto do badge",
                    placeholder: "shared.state.passed_decorated",
                    text: $badgeText)
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.section.badge_color", style: .title3)
                    HStack(spacing: ZodiakSpacing.s8) {
                        ForEach(ColorOption.allCases, id: \.self) { option in
                            Button {
                                selectedColor = option
                            } label: {
                                Text(option.rawValue)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(selectedColor == option ? .white : ZodiakColors.textSecondary)
                                    .padding(.horizontal, ZodiakSpacing.s8)
                                    .padding(.vertical, ZodiakSpacing.s4)
                                    // swiftlint:disable:next line_length
                                    .background(selectedColor == option ? ZodiakColors.actionPrimary : ZodiakColors.background)
                                    .cornerRadius(ZodiakRadii.l)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            ZodiakResultCardWithBadge(
                title: cardTitle.isEmpty ? String(localized: "catalog.resultcard.demo.default_title") : cardTitle,
                value: cardValue.isEmpty ? "–" : cardValue,
                badgeText: badgeText.isEmpty ? "catalog.spec.badge_default" : badgeText,
                badgeColor: selectedColor.color,
                subtitle: cardSubtitle.isEmpty ? nil : cardSubtitle
            )
        }
    }

    private var resultCardSection: some View {
        gallerySectionCard(title: "catalog.section.resultcard") {
            ZodiakResultCard(
                title: "feature.grades.final_average",
                value: "8.5",
                subtitle: "catalog.resultcard.demo.above_avg_class"
            )
            ZodiakResultCard(
                title: "Valor Total",
                value: "R$ 1.250,00",
                subtitle: nil
            )
            ZodiakResultCard(
                title: "Tentativas",
                value: "4",
                subtitle: "catalog.resultcard.demo.attempts",
                valueColor: ZodiakColors.textNegative
            )
        }
    }

    private var resultCardWithBadgeSection: some View {
        gallerySectionCard(title: "catalog.section.resultcardwithbadge") {
            ZodiakResultCardWithBadge(
                title: "catalog.inforow.demo.status",
                value: "shared.state.passed",
                badgeText: "✓ Sucesso",
                badgeColor: ZodiakColors.surfacePositive,
                subtitle: "catalog.resultcard.demo.above_avg"
            )
            ZodiakResultCardWithBadge(
                title: "catalog.resultcard.demo.check",
                value: "catalog.resultcard.demo.palindrome",
                badgeText: "✓ Sim",
                badgeColor: ZodiakColors.brand,
                subtitle: nil
            )
        }
    }

    private var usageExamplesSection: some View {
        gallerySectionCard(title: "catalog.section.uso_nos_exemplos") {
            ZodiakText(
                "catalog.result_card.usage_desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    NavigationStack {
        ResultCardGalleryView()
    }
}
