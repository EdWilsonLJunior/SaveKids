import SwiftUI

// MARK: - ZodiakGalleryShell
/// Pure layout shell for catalog gallery views.
/// Provides consistent background, scroll container and vertical rhythm.
/// Page-level behavior (navigation title, toolbar, keyboard) is applied separately via `.zodiakPage(title:)`.
///
/// Usage:
///   ZodiakGalleryShell {
///       galleryHeader(title: "catalog.component.buttons", subtitle: "...")
///       gallerySectionCard(title: "catalog.section.variantes") { ... }
///   }
///   .zodiakPage(title: "catalog.component.buttons")

struct ZodiakGalleryShell<Content: View>: View {
    let spacing: CGFloat
    let content: Content

    init(spacing: CGFloat = ZodiakSpacing.s32, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        ZStack {
            ZodiakColors.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: spacing) {
                    content
                }
                .padding(.vertical, ZodiakSpacing.s16)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ZodiakGalleryShell {
            galleryHeader(title: "Componente", subtitle: "catalog.zodiak_shell.subtitle", figmaRef: "Componente")
            gallerySectionCard(title: "catalog.section.variantes") {
                ZodiakText("Conteúdo de exemplo", style: .body())
            }
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakText("Radius: ZodiakRadii.s", style: .caption())
            }
        }
        .zodiakPage(title: "Componente")
    }
}
