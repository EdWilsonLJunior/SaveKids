import SwiftUI

// MARK: - ZodiakActivityTemplate
/// Template padrão para features: background Zodiak, ScrollView, headline adaptativo.
///
/// **Responsividade automática** — padding `xs` (iPhone) / `m` (iPad) e `maxContentWidth`
/// opcional para layout centrado no iPad. O developer não precisa ler `horizontalSizeClass`.
///
/// **Slot `edgeToEdgeContent`** — conteúdo sem padding horizontal (ex: `ZodiakTabs`).
/// O template cancela o padding internamente; não use padding negativo manual.
///
/// **⚠️ Contrato de Navegação** — NÃO envolva esta view em `NavigationStack`.
/// O ambiente host (NavigationSplitView / ExamplesListView) já fornece o stack pai.
/// Use `.navigationDestination` diretamente nesta view.
struct ZodiakActivityTemplate<Content: View, EdgeContent: View>: View {
    let title: String
    var eyebrow: String?
    var intro: String?
    var maxContentWidth: CGFloat?
    let content: Content
    let edgeToEdgeContent: EdgeContent

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var padding: CGFloat {
        horizontalSizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16
    }

    // MARK: - Inits

    /// Init padrão — sem slot edge-to-edge.
    init(
        title: String,
        eyebrow: String? = nil,
        intro: String? = nil,
        maxContentWidth: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) where EdgeContent == EmptyView {
        self.title = title
        self.eyebrow = eyebrow
        self.intro = intro
        self.maxContentWidth = maxContentWidth
        self.content = content()
        self.edgeToEdgeContent = EmptyView()
    }

    /// Init com slot `edgeToEdgeContent` para componentes que devem ignorar o padding horizontal
    /// (ex: `ZodiakTabs`). O template aplica o cancelamento de padding internamente.
    init(
        title: String,
        eyebrow: String? = nil,
        intro: String? = nil,
        maxContentWidth: CGFloat? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder edgeToEdgeContent: () -> EdgeContent
    ) {
        self.title = title
        self.eyebrow = eyebrow
        self.intro = intro
        self.maxContentWidth = maxContentWidth
        self.content = content()
        self.edgeToEdgeContent = edgeToEdgeContent()
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            ZodiakColors.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    headlineSection
                    // Slot edge-to-edge: o template cancela o padding horizontal do VStack pai.
                    // O developer injeta o componente sem nenhum modificador de padding.
                    edgeToEdgeContent
                        .padding(.horizontal, -padding)
                    content
                }
                .padding(padding)
                .frame(maxWidth: maxContentWidth ?? .infinity, alignment: .leading)
                .frame(maxWidth: maxContentWidth == nil ? nil : .infinity)
            }
            .dismissKeyboardOnTap()
        }
    }

    // MARK: - Headline

    @ViewBuilder
    private var headlineSection: some View {
        if eyebrow != nil || intro != nil {
            ZodiakHeadlineSection(
                title: title,
                eyebrow: eyebrow,
                intro: intro,
                style: intro != nil ? .plainWithIntro : .plain
            )
        } else {
            ZodiakText(title, style: .headline)
        }
    }
}

// MARK: - ZodiakInputOutputTemplate
/// Template com formulário e botão de submissão fixo no scroll

struct ZodiakInputOutputTemplate<Content: View>: View {
    let title: String
    var eyebrow: String?
    var intro: String?
    let inputContent: Content
    let submitButtonTitle: String
    let onSubmit: () -> Void

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var padding: CGFloat {
        horizontalSizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16
    }

    init(
        title: String,
        eyebrow: String? = nil,
        intro: String? = nil,
        submitButtonTitle: String = "Enviar",
        onSubmit: @escaping () -> Void,
        @ViewBuilder inputContent: () -> Content
    ) {
        self.title = title
        self.eyebrow = eyebrow
        self.intro = intro
        self.inputContent = inputContent()
        self.submitButtonTitle = submitButtonTitle
        self.onSubmit = onSubmit
    }

    var body: some View {
        ZStack {
            ZodiakColors.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    if eyebrow != nil || intro != nil {
                        ZodiakHeadlineSection(
                            title: title,
                            eyebrow: eyebrow,
                            intro: intro,
                            style: intro != nil ? .plainWithIntro : .plain
                        )
                    } else {
                        ZodiakText(title, style: .headline)
                    }
                    inputContent
                    ZodiakButtonPrimary(title: LocalizedStringKey(submitButtonTitle), action: onSubmit)
                    Spacer()
                }
                .padding(padding)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .dismissKeyboardOnTap()
        }
    }
}

// MARK: - ZodiakListTemplate
/// Template para listas com estado vazio.
/// Quando `items` está vazio exibe `ZodiakEmptyState` com os textos fornecidos.

struct ZodiakListTemplate<Item: Identifiable, Content: View>: View {
    let title: String
    var eyebrow: String?
    var intro: String?
    var emptyStateIcon: String
    var emptyStateTitle: String
    var emptyStateSubtitle: String?
    let items: [Item]
    let content: (Item) -> Content

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var padding: CGFloat {
        horizontalSizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16
    }

    // MARK: - Init

    init(
        title: String,
        eyebrow: String? = nil,
        intro: String? = nil,
        emptyStateIcon: String = "tray",
        emptyStateTitle: String = "shared.empty.list.title",
        emptyStateSubtitle: String? = nil,
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.title = title
        self.eyebrow = eyebrow
        self.intro = intro
        self.emptyStateIcon = emptyStateIcon
        self.emptyStateTitle = emptyStateTitle
        self.emptyStateSubtitle = emptyStateSubtitle
        self.items = items
        self.content = content
    }

    var body: some View {
        ZStack {
            ZodiakColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    if eyebrow != nil || intro != nil {
                        ZodiakHeadlineSection(
                            title: title,
                            eyebrow: eyebrow,
                            intro: intro,
                            style: intro != nil ? .plainWithIntro : .plain
                        )
                    } else {
                        ZodiakText(title, style: .headline)
                    }
                }
                .padding(padding)

                if items.isEmpty {
                    ZodiakEmptyState(
                        icon: emptyStateIcon,
                        title: emptyStateTitle,
                        description: emptyStateSubtitle
                    )
                    .padding(padding)
                } else {
                    List {
                        ForEach(items) { item in
                            content(item)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(ZodiakColors.surface)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .dismissKeyboardOnTap()
        }
    }
}

// MARK: - Preview
#Preview {
    ZodiakActivityTemplate(title: "Atividade Exemplo") {
        ZodiakResultCard(title: "feature.voting.result", value: "7.5", subtitle: "shared.state.passed")
    }
}
