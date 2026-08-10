import SwiftUI

// MARK: - Templates Gallery View

struct TemplatesGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.section_name.templates",
                subtitle: "catalog.templates.subtitle"
            )
            activitySection
            inputOutputSection
            listSection
            adaptiveSection
            viewportSection
        }
        .zodiakPage(title: "catalog.section_name.templates")
    }

    // MARK: - Sections

    private var activitySection: some View {
        templateCard(
            name: "ZodiakActivityTemplate",
            badge: "Básico",
            // swiftlint:disable:next line_length
            description: "Layout padrão para features: fundo Zodiak + ScrollView + ZodiakHeadlineSection + conteúdo. Suporte a eyebrow, intro e padding adaptativo (iPhone/iPad).",
            anatomy: [
                ("catalog.section.background", "ZodiakColors.background + ignoresSafeArea"),
                ("Scroll", "ScrollView vertical com dismissKeyboardOnTap"),
                ("Padding", "xs (16pt) no iPhone, m (32pt) no iPad"),
                ("Header", "ZodiakHeadlineSection(title:eyebrow:intro:style:)"),
                ("Content", "@ViewBuilder — qualquer conteúdo")
            ],
            usedIn: "Notas, PIX, Palíndromo, Adivinhe, Tabuada, Temperatura"
        )
    }

    private var inputOutputSection: some View {
        templateCard(
            name: "ZodiakInputOutputTemplate",
            badge: "Formulário",
            // swiftlint:disable:next line_length
            description: "Extende o ActivityTemplate com um ZodiakButton fixo no scroll para submissão. Padrão para formulários com resultado.",
            anatomy: [
                ("Herda", "ZodiakActivityTemplate structure"),
                ("Extra", "ZodiakButtonPrimary(title:, action:) no final"),
                ("Parâmetros", "title + eyebrow + intro + submitButtonTitle + onSubmit"),
                ("Uso", "Formulários simples com 1 ação principal")
            ],
            usedIn: "Versão simplificada do padrão de features"
        )
    }

    private var listSection: some View {
        templateCard(
            name: "ZodiakListTemplate",
            badge: "catalog.component_name.list",
            // swiftlint:disable:next line_length
            description: "Template genérico para listas com estado vazio automático. Aceita qualquer tipo Identifiable.",
            anatomy: [
                ("catalog.section.background", "ZodiakColors.background"),
                ("Lista vazia", "Ícone + mensagem 'Nenhum item cadastrado'"),
                ("Lista cheia", "ForEach com @ViewBuilder de item"),
                ("Padding", "xs (iPhone) / m (iPad) adaptativo"),
                ("Generic", "Item: Identifiable, Content: View")
            ],
            usedIn: "PersonManager e TaskManager (via componentes próprios)"
        )
    }

    private var adaptiveSection: some View {
        templateCard(
            name: "ZodiakAdaptiveTemplate",
            badge: "Adaptativo",
            // swiftlint:disable:next line_length
            description: "Layout responsivo com largura máxima de 1024pt. Centraliza conteúdo em telas grandes (iPad landscape). Suporta eyebrow e intro.",
            anatomy: [
                ("catalog.section.background", "ZodiakColors.background"),
                ("Max width", "1024pt — centralizado em iPad"),
                ("ScrollView", "Vertical com padding adaptativo"),
                ("Header", "ZodiakHeadlineSection(title:eyebrow:intro:style:)"),
                ("Uso", "Conteúdo rico que precisa de grid em iPad")
            ],
            usedIn: "QuizGame (tela de seleção de tema e placar)"
        )
    }

    private func templateCard(
        name: String,
        badge: String,
        description: String,
        anatomy: [(String, String)],
        usedIn: String
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakText(name, style: .title3)
                ZodiakBadge(
                    text: LocalizedStringKey(badge),
                    backgroundColor: ZodiakColors.brand,
                    foregroundColor: .white
                )
            }
            ZodiakText(description, style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakText("Anatomia", style: .title3)
            anatomyRows(anatomy)

            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: "iphone")
                    .font(.system(size: 12))
                    .foregroundColor(ZodiakColors.actionPrimary)
                Text(String(format: String(localized: "shared.format.used_in"), usedIn))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    private func anatomyRows(_ anatomy: [(String, String)]) -> some View {
        VStack(spacing: ZodiakSpacing.s4) {
            ForEach(anatomy, id: \.0) { item in
                HStack(spacing: ZodiakSpacing.s8) {
                    Text(item.0)
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .frame(width: 80, alignment: .leading)
                    Text(item.1)
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
        }
    }

    // MARK: - Viewport-aware Section (live demo)

    private var viewportSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakText("ZodiakViewportReader", style: .title3)
                ZodiakBadge(
                    text: "Novo",
                    backgroundColor: ZodiakColors.brand,
                    foregroundColor: .white
                )
            }
            ZodiakText(
                // swiftlint:disable:next line_length
                "Wrapper sobre GeometryReader que injeta o ZodiakViewport (mobile/tablet/tabletLarge/desktopSmall/desktopLarge) no environment. Combine com ZodiakResponsiveGrid para layouts adaptativos sem boilerplate.",
                style: .body(color: .secondary)
            )
            .fixedSize(horizontal: false, vertical: true)

            ZodiakText("Live preview", style: .title3)
            ZodiakViewportReader { viewport in
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(verbatim: "viewport: \(viewport.rawValue) — \(viewport.columnCount) cols")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakResponsiveGrid(applyMargin: false) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                                .fill(ZodiakColors.brand.opacity(0.18))
                                .frame(height: 56)
                                .overlay(
                                    Text(verbatim: "\(index + 1)")
                                        .font(ZodiakTypography.captionLarge)
                                        .foregroundColor(ZodiakColors.textPrimary)
                                )
                        }
                    }
                }
            }
            .frame(minHeight: 220)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    NavigationStack {
        TemplatesGalleryView()
    }
}
