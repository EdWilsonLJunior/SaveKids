import SwiftUI

// MARK: - Info Row Gallery View

struct InfoRowGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.info_row",
                subtitle: "catalog.info_row.subtitle",
                figmaRef: nil
            )
            demoSection
            listDemoSection
            specsSection
        }
        .zodiakPage(title: "catalog.component_name.info_row")
    }

    private var demoSection: some View {
        gallerySectionCard(title: "catalog.section.exemplos") {
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakInfoRow(label: "shared.label.name", value: "Ana Silva")
                ZodiakInfoRow(label: "catalog.inforow.demo.average", value: "8.5")
                ZodiakInfoRow(label: "catalog.inforow.demo.status", value: "catalog.inforow.demo.approved")
                ZodiakInfoRow(label: "Curso", value: "Design de Sistemas")
                ZodiakInfoRow(label: "Semestre", value: "4º")
            }
        }
    }

    private var listDemoSection: some View {
        gallerySectionCard(title: "catalog.section.em_lista_tabuada_do_7") {
            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(1...10, id: \.self) { i in
                    ZodiakInfoRow(label: "7 × \(i)", value: "\(7 * i)")
                }
            }
        }
    }

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakInfoRow(label: "Label font", value: "body (textSecondary)")
                ZodiakInfoRow(label: "Value font", value: "body bold (textPrimary)")
                ZodiakInfoRow(label: "Padding", value: "twoXSmall (8pt)")
                ZodiakInfoRow(label: "Background", value: "surface")
                ZodiakInfoRow(label: "Corner Radius", value: "s (16pt)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        InfoRowGalleryView()
    }
}
