import SwiftUI

// MARK: - LogosGalleryView

struct LogosGalleryView: View {
    var body: some View {
        ZodiakGalleryShell(spacing: ZodiakSpacing.s24) {
            galleryHeader(
                title: "catalog.home.logos",
                subtitle: "catalog.logos.subtitle",
                figmaRef: "40010369:17219"
            )

            usageRulesSection

            logosList
        }
        .zodiakPage(title: "catalog.home.logos")
    }

    // MARK: - Usage rules

    private var usageRulesSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            ZodiakText(verbatim: "Regras de Uso", style: .title2)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ruleRow(text: "Logo colorido é sempre preferido.")
                ruleRow(text: "Wordmark: largura mínima de 175pt.")
                ruleRow(text: "Espada: altura mínima de 24pt.")
                ruleRow(text: "Não altere cores, proporções ou orientação.")
                ruleRow(text: "Use espada apenas quando o logo completo já apareceu na tela.")
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
        }
    }

    private func ruleRow(text: String) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(ZodiakColors.brand)
                .font(.system(size: 14))
            ZodiakText(verbatim: text, style: .bodySmall())
            Spacer(minLength: 0)
        }
    }

    // MARK: - Logos list

    private var logosList: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText(verbatim: "Biblioteca", style: .title2)

            // Primary Capgemini logos on white background
            primarySection

            // Entity logos
            entitySection

            // Partner logos
            partnerSection
        }
    }

    private var primarySection: some View {
        logoGroup(
            title: "Principal",
            variants: [.capgemini, .spade]
        )
    }

    private var entitySection: some View {
        logoGroup(
            title: "Entidades",
            variants: [.capgeminiInvent, .capgeminiEngineering, .sogeti, .frog]
        )
    }

    private var partnerSection: some View {
        logoGroup(
            title: "Outros",
            // swiftlint:disable:next line_length
            variants: [.cambridgeConsultants, .purpose, .university, .researchInstitute, .ventures, .appliedInnovationExchange]
        )
    }

    private func logoGroup(title: String, variants: [ZodiakLogoVariant]) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(verbatim: title)
                .font(ZodiakTypography.captionLarge)
                .foregroundStyle(ZodiakColors.textSecondary)
                .textCase(.uppercase)
                .tracking(ZodiakTypography.BodySize.xs.tracking)

            VStack(spacing: 0) {
                ForEach(variants, id: \.imageName) { variant in
                    logoRow(variant)
                    if variant != variants.last {
                        ZodiakDivider(hierarchy: .secondary)
                    }
                }
            }
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
        }
    }

    private func logoRow(_ variant: ZodiakLogoVariant) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            // Logo on white background
            ZStack {
                Color.white
                    .cornerRadius(ZodiakRadii.xs)
                ZodiakLogoView(variant)
                    .frame(
                        width: variant.isSymbol ? nil : 200,
                        height: variant.isSymbol ? 36 : 28
                    )
                    .padding(.horizontal, ZodiakSpacing.s16)
                    .padding(.vertical, ZodiakSpacing.s8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)

            // Metadata
            HStack {
                Text(variant.displayName)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundStyle(ZodiakColors.textPrimary)
                Spacer()
                if variant.isSymbol {
                    Text("catalog.spec.symbol_min_size")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundStyle(ZodiakColors.textDisabled)
                } else {
                    Text("catalog.spec.wordmark_min_size")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundStyle(ZodiakColors.textDisabled)
                }
            }
        }
        .padding(ZodiakSpacing.s8)
        .accessibilityLabel(variant.accessibilityLabel)
    }
}

#Preview {
    NavigationStack {
        LogosGalleryView()
            .environmentObject(CatalogViewModel())
    }
}
