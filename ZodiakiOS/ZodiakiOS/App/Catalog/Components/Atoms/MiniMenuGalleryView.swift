import SwiftUI

struct MiniMenuGalleryView: View {
    @State private var lastAction = "—"

    private func tap(_ label: String) { lastAction = label }

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.mini_menu",
                subtitle: "catalog.mini_menu.subtitle",
                figmaRef: "Mini menu"
            )

            // MARK: - Menu completo
            gallerySectionCard(title: "catalog.section.exemplos") {
                ZodiakMiniMenu(items: [
                    .init(id: "edit", label: "Editar", icon: "pencil", action: { tap("Editar") }),
                    .init(id: "share", label: "Partilhar",
                          icon: "square.and.arrow.up", action: { tap("Partilhar") }),
                    .init(id: "copy", label: "Copiar", icon: "doc.on.doc", action: { tap("Copiar") }),
                    .init(id: "delete", label: "Eliminar", icon: "trash",
                          isDestructive: true, action: { tap("Eliminar") })
                ])
                ZodiakInfoRow(label: "catalog.minimenu.spec.last_action", value: lastAction, style: .spec())
            }

            // MARK: - Sem ícones
            gallerySectionCard(title: "catalog.section.sem_icones") {
                ZodiakMiniMenu(items: [
                    .init(id: "a1", label: "Ver detalhes", action: {}),
                    .init(id: "a2", label: "Exportar", action: {}),
                    .init(id: "a3", label: "Arquivar", action: {})
                ])
            }

            // MARK: - Com item desabilitado
            gallerySectionCard(title: "catalog.section.com_item_desabilitado") {
                ZodiakMiniMenu(items: [
                    .init(id: "b1", label: "Publicar", icon: "paperplane", action: {}),
                    .init(id: "b2", label: "Agendar", icon: "calendar", isDisabled: true, action: {}),
                    .init(id: "b3", label: "Cancelar", icon: "xmark", isDestructive: true, action: {})
                ])
            }

            // MARK: - Sem divisores
            gallerySectionCard(title: "catalog.section.sem_divisores") {
                ZodiakMiniMenu(
                    items: [
                    .init(id: "c1", label: "catalog.radio.option.a", icon: "circle", action: {}),
                    .init(id: "c2", label: "catalog.radio.option.b", icon: "square", action: {}),
                    .init(id: "c3", label: "catalog.radio.option.c", icon: "triangle", action: {})
                    ],
                    showDividers: false
                )
            }

            // MARK: - Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow("Fundo", value: "ZodiakColors.surface", style: .spec())

                ZodiakInfoRow("Raio", value: "ZodiakRadii.s", style: .spec())

                ZodiakInfoRow("Altura de item", value: "44pt", style: .spec())

                ZodiakInfoRow("Ícone", value: "catalog.minimenu.spec.icon_value", style: .spec())

                ZodiakInfoRow("Padding H", value: "ZodiakSpacing.s16 (16pt)", style: .spec())

                ZodiakInfoRow("Cor destrutiva", value: "textNegative", style: .spec())

                ZodiakInfoRow("Cor desabilitado", value: "textDisabled", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.mini_menu")
    }
}

#Preview { NavigationStack { MiniMenuGalleryView() } }
