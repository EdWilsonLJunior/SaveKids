import SwiftUI

// MARK: - ZodiakAdaptiveTemplate
/// Template responsivo com `maxContentWidth` fixo para iPad (1024pt) e padding adaptativo.
///
/// Wrapper conveniente sobre `ZodiakActivityTemplate(maxContentWidth: ZodiakSizing.contentMaxWidth)`.
/// Para controle explícito da largura máxima, use `ZodiakActivityTemplate` diretamente.
struct ZodiakAdaptiveTemplate<Content: View>: View {
    let title: String
    var eyebrow: String?
    var intro: String?
    let content: Content

    init(title: String, eyebrow: String? = nil, intro: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.eyebrow = eyebrow
        self.intro = intro
        self.content = content()
    }

    var body: some View {
        ZodiakActivityTemplate(
            title: title,
            eyebrow: eyebrow,
            intro: intro,
            maxContentWidth: ZodiakSizing.contentMaxWidth
        ) {
            content
        }
    }
}

// MARK: - Previews
#Preview("iPhone") {
    ZodiakAdaptiveTemplate(title: "Atividade") {
        ZodiakText("Conteúdo de exemplo", style: .body())
    }
}

#Preview("iPad") {
    ZodiakAdaptiveTemplate(title: "Atividade") {
        ZodiakText("Conteúdo de exemplo", style: .body())
    }
    .environment(\.horizontalSizeClass, .regular)
}
